import QtQuick
import Quickshell
import qs.common
import Quickshell.Services.UPower
import QtQuick.Controls
import ".."

BarItem {
    readonly property UPowerDevice powerDevice: UPower.displayDevice

    function iconFromBatteryPercentage(percentage, battery_state) {
        let status = " ";
        let battery = "";

        if (percentage <= 10) {
            battery = "";
            status = "";
        } else if (percentage <= 35) {
            battery = "";
        } else if (percentage <= 60) {
            battery = "";
        } else if (percentage <= 85) {
            battery = "";
        } else {
            battery = "";
        }
        if (battery_state === UPowerDeviceState.Charging) {
            status = "󱐋";
        }

        return battery + " " + status;
    }

    visible: powerDevice.isLaptopBattery

    Text {
        id: percentText
        readonly property int percentage: Math.floor(powerDevice.percentage * 100)
        color: hovered ? Theme.colors.background : Theme.colors.text
        text: `${percentage}%`
        font {
            pixelSize: Theme.font.size.smaller
        }
    }
    Text {
        text: iconFromBatteryPercentage(percentText.percentage, powerDevice.state)
        color: hovered ? Theme.colors.background : Theme.colors.text
        font {
            pixelSize: Theme.font.size.large
            family: Theme.font.family.nerd
        }
    }
}
