pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool askPassword: false
    property list<var> availableNetworks: []
    property string connectedSSID: "unknown"
    property string defaultStation
    property bool ethernet: false
    property int networkStrength
    property bool scanning: false
    property bool wlan: false

    signal connectionResult(string ssid, string connectionError)

    function checkSignalStrength(station) {
        showStation.station = station;
        showStation.running = true;
    }
    function checkStatus() {
        networkctl.running = true;
    }
    function connect(ssid) {
        connect.ssid = ssid;
        connect.running = true;
    }
    function submitPassword(pass) {
        root.askPassword = false;
        connectWithPassphrase.passphrase = pass;
        connectWithPassphrase.running = true;
    }
    function triggerScan() {
        root.scanning = true;
        scan.running = true;
    }

    Process {
        id: connect

        property string ssid
        property string station: root.defaultStation

        command: ["iwctl", "station", station, "connect", ssid]
        stdinEnabled: true

        stdout: SplitParser {
            splitMarker: ":"

            onRead: line => {
                if (line.includes("Passphrase") && !root.askPassword) {
                    connectWithPassphrase.ssid = connect.ssid;
                    root.askPassword = true;
                    connect.signal(9);
                }
            }
        }

        onExited: {
            if (!root.askPassword) {
                root.connectedSSID = connect.ssid;
                root.connectionResult(connect.ssid, this.text);
            }
        }
    }
    Process {
        id: connectWithPassphrase

        property string passphrase
        property string ssid
        property string station: root.defaultStation

        command: ["iwctl", "--passphrase", passphrase, "station", station, "connect", ssid]
        stdinEnabled: true

        stdout: StdioCollector {
            onStreamFinished: {
                const err = this.text.replace(/[\u001b\u009b][[()#;?]*(?:[0-9]{1,4}(?:;[0-9]{0,4})*)?[0-9A-ORZcf-nqry=><]/g, "");
                root.connectionResult(connectWithPassphrase.ssid, err);
                if (!err) {
                    root.connectedSSID = connectWithPassphrase.ssid;
                }
            }
        }
    }
    Process {
        id: init

        command: ["networkctl"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n");
                let hasWlan = false;
                let hasEther = false;
                for (const line of lines) {
                    const fields = line.trim().split(" ");
                    const type = fields[2];
                    if (type === "wlan") {
                        root.defaultStation = fields[1];
                        return;
                    }
                }
            }
        }
    }
    Process {
        id: networkctl

        command: ["networkctl"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n");
                let hasWlan = false;
                let hasEther = false;
                for (const line of lines) {
                    if (line.includes("routable")) {
                        const fields = line.trim().split(" ");
                        const type = fields[2];
                        if (type === "wlan") {
                            checkSignalStrength(fields[1]);
                            hasWlan = true;
                        } else if (type === "ether") {
                            hasEther = true;
                        }
                    }
                }
                root.wlan = hasWlan;
                root.ethernet = hasEther;
            }
        }
    }
    Process {
        id: scan

        command: ["iwctl", "station", root.defaultStation, "scan"]
        running: false

        onExited: {
            pollScanDone.start();
        }
    }
    Timer {
        id: pollScanDone

        interval: 500
        repeat: true
        running: false

        onTriggered: checkScanDone.running = true
    }
    Process {
        id: checkScanDone

        command: ["iwctl", "station", root.defaultStation, "show"]
        running: false

        stdout: SplitParser {
            onRead: line => {
                if (line.includes("Scanning") && line.includes("no")) {
                    updateNetworks.running = true;
                    pollScanDone.stop();
                }
            }
        }
    }
    Process {
        id: updateNetworks

        command: ["iwctl", "station", root.defaultStation, "get-networks", "rssi-dbms"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.split("\n");
                const networks = lines.slice(4).map(line => {
                    // remove the current network indicator + color codes
                    line = line.replace(/>/, "");
                    line = line.replace(/\x1B\[[0-9;]*m/g, "").trim();

                    if (!line)
                        return null;
                    // Capture: SSID (any non-space), security type (non-space), signal strength (number)
                    const match = line.match(/^(.+?)\s+(\S+)\s+(-?\d+)$/);
                    if (!match)
                        return null;
                    return {
                        ssid: match[1].trim(),
                        type: match[2],
                        signalStrength: Math.floor(parseInt(match[3], 10) / 100)
                    };
                }).filter(Boolean);
                root.availableNetworks = networks;
                root.scanning = false;
            }
        }
    }
    Process {
        id: showStation

        property string station: root.defaultStation

        command: ["iwctl", "station", station, "show"]
        running: false

        stdout: SplitParser {
            onRead: line => {
                if (line.includes("AverageRSSI")) {
                    const rssi = Math.floor(line.trim().split(" ").filter(Boolean)[1]);
                    root.networkStrength = rssi;
                } else if (line.includes("Connected network")) {
                    root.connectedSSID = line.match(/Connected network\s+(.*)\s*$/)[1].trim();
                }
            }
        }
    }
    Timer {
        interval: 1000
        repeat: true
        running: true

        onTriggered: checkStatus()
    }
}
