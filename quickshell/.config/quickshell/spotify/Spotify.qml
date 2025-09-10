import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Spotify
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Mpris
import qs.common
import "."

StyledPopup {
    id: spotifyWidget

    property Component currentComponent: CurrentlyPlaying
    readonly property MprisPlayer player: Mpris.players.values.find(player => player.identity === "Spotify")

    function setCurrentPage(page) {
        spotifyWidget.child.visible = false;
        spotifyWidget.child = page;
        spotifyWidget.child.visible = true;
    }

    child: currentlyPlaying

    onVisibleChanged: {
        if (visible) {
            setCurrentPage(currentlyPlaying);
            child.forceActiveFocus();
        }
    }

    SpotifyApi {
        id: api

        clientId: "d66dea877b004271813e5579438321df"
        scope: ["user-read-playback-state", "user-modify-playback-state", "playlist-read-private", "user-library-read"]

        Component.onCompleted: api.init()
    }
    CurrentlyPlaying {
        id: currentlyPlaying

        player: spotifyWidget.player
    }
    Playlists {
        id: playlists

        api: api
        visible: false
    }
    Shortcut {
        sequences: ["Ctrl+C"]

        onActivated: {
            spotifyWidget.setCurrentPage(currentlyPlaying);
        }
    }
    Shortcut {
        sequences: ["Ctrl+P"]

        onActivated: {
            spotifyWidget.setCurrentPage(playlists);
        }
    }
    GlobalShortcut {
        description: "Open the Spotify Widget"
        name: "spotifyWidgetOpen"

        onPressed: spotifyWidget.visible = true
    }
}
