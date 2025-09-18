import QtQuick
import QtQuick.Layouts
import qs.common
import Spotify

StyledSelectList {
    id: playlistList

    required property SpotifyApi api

    height: 300
    implicitWidth: 600
    model: api.playlists

    delegate: StyledSelectItem {
        id: playlistItem

        required property int index
        required property Playlist modelData

        selected: ListView.isCurrentItem
        width: parent.width

        Text {
            Layout.fillWidth: true
            color: selected ? Theme.colors.background : Theme.colors.text
            font.pixelSize: Theme.font.size.medium
            text: modelData.name
        }
    }

    onSelected: playlist => {
        playlist.play();
    }
    onVisibleChanged: {
        if (visible) {
            api.updatePlaylists();
            playlistList.forceActiveFocus();
        }
    }
}
