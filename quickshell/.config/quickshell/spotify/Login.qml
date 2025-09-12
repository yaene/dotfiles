import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell.Widgets
import Spotify
import qs.common

WrapperRectangle {
    id: login

    required property SpotifyApi api

    color: Theme.colors.background
    margin: 60

    onVisibleChanged: {
        if (visible) {
            login.forceActiveFocus();
        }
    }

    ColumnLayout {
        spacing: 24

        Text {
            Layout.alignment: Qt.AlignHCenter
            color: Theme.colors.text
            font.pixelSize: 18
            text: "You need to authorize this app with spotify to get access to necessary information (such as your library or playback state)."
        }
        Button {
            Layout.alignment: Qt.AlignHCenter
            text: "Authorize"

            onClicked: api.authorize()
        }
    }
}
