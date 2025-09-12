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

    property Item currentComponent: currentlyPlaying
    readonly property MprisPlayer player: Mpris.players.values.find(player => player.identity === "Spotify")

    function setCurrentPage(page) {
        if (api.authorized) {
            currentComponent = page;
        }
    }

    child: content

    onVisibleChanged: {
        if (visible) {
            spotifyWidget.currentComponent = api.authorized ? currentlyPlaying : login;
        }
    }

    SpotifyApi {
        id: api

        clientId: "d66dea877b004271813e5579438321df"
        scope: ["user-read-playback-state", "user-modify-playback-state", "playlist-read-private", "user-library-read"]

        Component.onCompleted: api.init()
        onAuthorizedChanged: {
            if (authorized) {
                api.updateCurrentUser();
                spotifyWidget.setCurrentPage(currentlyPlaying);
            } else {
                spotifyWidget.setCurrentPage(login);
            }
        }
    }
    Item {
        id: content

        implicitHeight: currentComponent.implicitHeight
        implicitWidth: currentComponent.implicitWidth

        CurrentlyPlaying {
            id: currentlyPlaying

            player: spotifyWidget.player
            visible: spotifyWidget.currentComponent === currentlyPlaying
        }
        Playlists {
            id: playlists

            api: api
            visible: spotifyWidget.currentComponent === playlists
        }
        Login {
            id: login

            api: api
            visible: spotifyWidget.currentComponent === login
        }
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

        onPressed: {
            spotifyWidget.show();
        }
    }
}
