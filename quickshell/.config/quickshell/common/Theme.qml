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

                // Backgrounds
                property string background: "#24283b"
                property string backgroundDark: "#1f2335"
                property string backgroundDarker: "#1b1e2d"
                property string backgroundHighlight: "#292e42"
                property string danger: "#f7768e"
                property string dangerDark: "#db4b4b"

                // States (Success/Warning/Danger)
                property string success: "#9ece6a"

                // Foregrounds / Text
                property string text: "#c0caf5"
                property string textMuted: "#a9b1d6"
                property string warning: "#e0af68"
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
