import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import qs.common
import qs.services
import "../.."

Item {
    implicitHeight: barItem.implicitHeight
    implicitWidth: barItem.implicitWidth

    BarItem {
        id: barItem

        anchors.centerIn: parent

        onPressed: networkCtlLoader.item.visible = !networkCtlLoader.item.visible

        Text {
            id: icon

            color: barItem.hovered ? Theme.colors.background : Theme.colors.text
            text: {
                NetworkService.ethernet ? "" : !NetworkService.wlan ? "󰤮" : Utils.iconFromWlanSignalStrength(NetworkService.networkStrength);
            }

            font {
                family: Theme.font.family.nerd
                pixelSize: Theme.font.size.large
            }
        }
    }
    LazyLoader {
        id: networkCtlLoader

        loading: true
        source: "NetworkCtl.qml"
    }
    GlobalShortcut {
        description: "Open simple network selection widget"
        name: "openNetworkSelection"

        onPressed: {
            networkCtlLoader.item.show();
        }
    }
}
