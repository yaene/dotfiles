pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import QtCore

Singleton {
    property alias colors: configJsonAdapter.colors
    readonly property string file: StandardPaths.locate(StandardPaths.ConfigLocation, "jing/theme.json")
    property alias font: configJsonAdapter.font
    property alias iconFont: configJsonAdapter.iconFont

    FileView {
        path: Utils.urlStripProtocol(Theme.file)
        watchChanges: true

        onFileChanged: reload()

        JsonAdapter {
            id: configJsonAdapter

            property JsonObject colors: JsonObject {
                property string active: Colors.color12

                // Backgrounds
                property color background: Colors.background
                property color backgroundDark: Qt.darker(background, 1.2)
                property color backgroundDarker: Qt.darker(background, 1.5)
                property string backgroundHighlight: Qt.lighter(background, 1.1)
                property string danger: Colors.color9
                property string dangerDark: Colors.color1
                property color primaryButton: Colors.color6
                property string selected: Colors.color5

                // States (Success/Warning/Danger)
                property string success: Colors.color2

                // Foregrounds / Text
                property string text: Colors.foreground
                property string textMuted: Colors.color7
                property color title: Colors.color4
                property string warning: Colors.color3

                function opaqueBackground(alpha) {
                    return Qt.rgba(colors.background.r, colors.background.g, colors.background.b, alpha);
                }
            }
            property JsonObject font: JsonObject {
                property JsonObject family: JsonObject {
                    property string nerd: "0xProto Nerd Font"
                    property string primary: "Adwaita"
                }
                property JsonObject size: JsonObject {
                    property int large: 20
                    property int larger: 24
                    property int medium: 16
                    property int small: 15
                    property int smaller: 13
                }
            }
            property string iconFont: "/home/yaene/.icons/Tela-circle-purple"
        }
    }
}
