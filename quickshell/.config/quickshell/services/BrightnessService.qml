pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    property int brightness: 0

    function decreaseBrightness() {
        setBrightnessProc.command[2] = "5%-";
        setBrightnessProc.running = true;
    }
    function increaseBrightness() {
        setBrightnessProc.command[2] = "5%+";
        setBrightnessProc.running = true;
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
    Process {
        id: initBrightnessProc

        command: ["brightnessctl"]
        running: true

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
}
