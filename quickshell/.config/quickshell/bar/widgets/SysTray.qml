import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.common
import ".."

BarItem {
    id: root

    onPressed: tray.visible = !tray.visible

    Text {
        id: icon

        color: root.hovered ? Theme.colors.background : Theme.colors.text
        font.pixelSize: Config.bar.iconSize
        text: "󱊖"
    }
    Tray {
        id: tray

    }

    component Tray: PopupWindow {
        anchor.rect.x: anchor.window.width - wrapper.width - 5
        anchor.rect.y: anchor.window.height + 3
        anchor.window: QsWindow.window
        color: "transparent"
        implicitHeight: Math.max(Math.round(wrapper.implicitHeight), 32)
        implicitWidth: Math.max(Math.round(wrapper.implicitWidth), 64)

        WrapperRectangle {
            id: wrapper

            color: Theme.colors.backgroundDarker
            margin: 5
            radius: 8

            Flow {
                id: content

                spacing: 5
                width: 200

                Repeater {
                    model: SystemTray.items

                    TrayItem {
                    }
                }
            }
        }
    }
    component TrayItem: MouseArea {
        id: trayItem

        required property SystemTrayItem modelData

        implicitHeight: img.height
        implicitWidth: img.width

        Image {
            id: img

            fillMode: Image.PreserveAspectFit
            height: 25
            source: Utils.iconUrlFromTrayIcon(modelData.icon)
        }
    }
}
