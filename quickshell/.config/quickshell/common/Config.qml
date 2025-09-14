pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import QtCore

Singleton {
    property alias bar: configJsonAdapter.bar
    readonly property string file: StandardPaths.locate(StandardPaths.ConfigLocation, "jing/config.json")
    property alias osd: configJsonAdapter.osd

    FileView {
        path: Utils.urlStripProtocol(Config.file)
        watchChanges: true

        onFileChanged: reload()

        JsonAdapter {
            id: configJsonAdapter

            property JsonObject bar: JsonObject {
                property bool borderOnlyBottom: true
                property int borderWidth: 0
                property int height: 30
                property bool transparent: false
            }
            property JsonObject osd: JsonObject {
                property int hideTimeout: 800
            }
        }
    }
}
