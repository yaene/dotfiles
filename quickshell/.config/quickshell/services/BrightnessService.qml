pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property list<var> ddcMonitors: []
    property list<Monitor> monitors: screens.instances

    function decreaseBrightness() {
        const monitor = monitors.find(m => m.modelData.name === Hyprland.focusedMonitor?.name);
        monitor.setBrightness(monitor.brightness - 0.05);
    }
    function getMonitorForScreen(screen) {
        return monitors.find(m => m.modelData === screen);
    }
    function increaseBrightness() {
        const monitor = monitors.find(m => m.modelData.name === Hyprland.focusedMonitor?.name);
        monitor.setBrightness(monitor.brightness + 0.05);
    }

    onMonitorsChanged: detectProc.running = true

    Process {
        id: detectProc

        command: ["ddcutil", "detect", "--brief"]

        stdout: StdioCollector {
            onStreamFinished: {
                const monitors = this.text.split("\n\n").filter(line => line.startsWith("Display ")).map(display => {
                    const num = display.match(/Display ([0-9]+)/)[1];
                    const connector = display.match(/DRM connector:\s+(.+)/)[1].replace(/^card\d+-/, "");
                    return {
                        num,
                        connector
                    };
                });
                root.ddcMonitors = monitors;
            }
        }
    }
    Process {
        id: setBrightnessProc

        command: ["brightnessctl", "s", ""]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                root.brightness = Math.floor(this.text.match("([0-9]*)%")[1]);
            }
        }
    }
    IpcHandler {
        function decrease(): void {
            root.decreaseBrightness();
        }
        function increase(): void {
            root.increaseBrightness();
        }

        target: "brightness"
    }
    GlobalShortcut {
        description: "Increase Brightness"
        name: "brightnessIncrease"

        onPressed: root.increaseBrightness()
    }
    GlobalShortcut {
        description: "Decrease Brightness"
        name: "brightnessDecrease"

        onPressed: root.decreaseBrightness()
    }
    Variants {
        id: screens

        model: Quickshell.screens

        Monitor {
        }
    }

    component Monitor: QtObject {
        id: monitor

        property real brightness
        readonly property string displayNum: root.ddcMonitors.find(m => m.connector === modelData.name)?.num ?? ""
        readonly property Process initProc: Process {
            stdout: StdioCollector {
                onStreamFinished: {
                    if (text.includes("ERR") || !text.trim())
                        return;
                    const [, , , current, max] = text.split(" ");
                    monitor.brightness = parseInt(current) / parseInt(max);
                }
            }
        }
        readonly property bool isDdc: root.ddcMonitors.some(m => m.connector === modelData.name)
        required property ShellScreen modelData

        function initBrightness(): void {
            console.log(isDdc);
            console.log(displayNum);
            if (isDdc) {
                // feature code 10 is brightness
                initProc.command = ["ddcutil", "-d", displayNum, "getvcp", "10", "--brief"];
            } else {
                initProc.command = ["sh", "-c", "echo - - - $(brightnessctl g) $(brightnessctl m)"];
            }

            initProc.running = true;
        }
        function setBrightness(value: real): void {
            value = Math.max(0, Math.min(1, value));
            const rounded = Math.round(value * 100);
            console.log("set brightness to: ", rounded, "for display: ", displayNum);
            if (Math.round(brightness * 100) === rounded)
                return;

            brightness = value;

            if (isDdc) {
                Quickshell.execDetached(["ddcutil", "-d", displayNum, "setvcp", "10", rounded]);
            } else {
                Quickshell.execDetached(["brightnessctl", "s", `${rounded}%`]);
            }
        }

        Component.onCompleted: initBrightness()
        onDisplayNumChanged: initBrightness()
        onIsDdcChanged: initBrightness()
    }
}
