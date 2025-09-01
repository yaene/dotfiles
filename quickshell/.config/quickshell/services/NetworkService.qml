pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property string connectionType: "unknown"
    property bool ethernet: false
    property int networkStrength
    property bool wlan: false

    function checkSignalStrength(station) {
        showStation.command[2] = station;
        showStation.running = true;
    }
    function checkStatus() {
        networkctl.running = true;
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
        id: showStation

        command: ["iwctl", "station", "none", "show"]
        running: false

        stdout: SplitParser {
            onRead: line => {
                if (line.includes("AverageRSSI")) {
                    const rssi = Math.floor(line.trim().split(" ").filter(Boolean)[1]);
                    root.networkStrength = rssi;
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
