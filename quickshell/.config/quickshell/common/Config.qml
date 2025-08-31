pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import QtCore

Singleton {
    readonly property string file: StandardPaths.locate(StandardPaths.ConfigLocation, "jing/config.json")
    property alias bar: configJsonAdapter.bar
    FileView {
        path: Utils.urlStripProtocol(Config.file)
        watchChanges: true
        onFileChanged: reload()
        JsonAdapter {
            id: configJsonAdapter
            property JsonObject bar: JsonObject {
                property int height: 30
                property bool transparent: true
                property int borderWidth: 2
            }
        }
    }
}
