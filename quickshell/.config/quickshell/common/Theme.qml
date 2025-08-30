pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import QtCore

Singleton {
    readonly property string file: StandardPaths.locate(StandardPaths.ConfigLocation, "jing/theme.json")
    property alias font: configJsonAdapter.font
    property alias colors: configJsonAdapter.colors

    FileView {
        path: Utils.urlStripProtocol(Theme.file)
        watchChanges: true
        onFileChanged: reload()
        JsonAdapter {
            id: configJsonAdapter
            property JsonObject font: JsonObject {
                property JsonObject family: JsonObject {
                    property string primary: "Adwaita"
                }
                property JsonObject size: JsonObject {
                    property int small: 15
                    property int medium: 16
                    property int large: 22
                }
            }
            property JsonObject colors: JsonObject {

                // Backgrounds
                property string background: "#24283b"
                property string backgroundDark: "#1f2335"
                property string backgroundDarker: "#1b1e2d"
                property string backgroundHighlight: "#292e42"

                // Foregrounds / Text
                property string text: "#c0caf5"
                property string textMuted: "#a9b1d6"

                // States (Success/Warning/Danger)
                property string success: "#9ece6a"
                property string danger: "#f7768e"
                property string dangerDark: "#db4b4b"
                property string warning: "#e0af68"
            }
        }
    }
}
