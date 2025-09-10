import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Mpris
import qs.common

RowLayout {
    id: currentlyPlaying

    required property MprisPlayer player

    function goNext() {
        player.next();
    }
    function goPrevious() {
        player.previous();
    }
    function repeat() {
        if (player?.loopState === MprisLoopState.None) {
            player.loopState = MprisLoopState.Playlist;
        } else if (player?.loopState === MprisLoopState.Playlist) {
            player.loopState = MprisLoopState.Track;
        } else {
            player.loopState = MprisLoopState.None;
        }
    }
    function shuffle() {
        player.shuffle = !player.shuffle;
    }
    function togglePlaying() {
        player.togglePlaying();
    }

    anchors.fill: parent
    focus: true
    spacing: 16

    Keys.onPressed: event => {
        switch (event.key) {
        case Qt.Key_P:
            goPrevious();
            event.accepted = true;
            break;
        case Qt.Key_N:
            goNext();
            event.accepted = true;
            break;
        case Qt.Key_S:
            shuffle();
            event.accepted = true;
            break;
        case Qt.Key_R:
            repeat();
            event.accepted = true;
            break;
        case Qt.Key_Space:
            togglePlaying();
            event.accepted = true;
            break;
        }
    }
    onVisibleChanged: {
        if (visible) {
            currentlyPlaying.forceActiveFocus();
        }
    }

    Image {
        id: art

        Layout.preferredHeight: 150
        Layout.preferredWidth: 150
        fillMode: Image.PreserveAspectFit
        source: player?.trackArtUrl || ""
    }

    // Track info and progress
    ColumnLayout {
        Layout.fillWidth: true
        spacing: 6

        // Song + Artist
        Text {
            color: Theme.colors.text
            elide: Text.ElideRight
            font.bold: true
            font.pixelSize: 18
            text: player?.trackTitle || "Not Playing"
        }
        Text {
            color: Theme.colors.warning
            elide: Text.ElideRight
            font.pixelSize: 14
            text: player?.trackArtist || ""
        }

        // Progress bar
        RowLayout {
            function timeFromSeconds(seconds) {
                return Math.floor(seconds / 60).toString().padStart(2, "0") + ":" + Math.floor(seconds % 60).toString().padStart(2, "0");
            }

            spacing: 6

            Timer {
                // Make sure the position updates at least once per second.
                interval: 1000
                repeat: true
                // only emit the signal when the position is actually changing.
                running: player?.playbackState == MprisPlaybackState.Playing

                // emit the positionChanged signal every second.
                onTriggered: player.positionChanged()
            }
            Text {
                Layout.preferredWidth: 30
                color: Theme.colors.text
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                text: parent.timeFromSeconds(player?.position || 0)
            }
            ProgressBar {
                id: progress

                Layout.preferredWidth: 150
                implicitHeight: 7
                value: player && player.length > 0 ? player.position / player.length : 0

                background: Rectangle {
                    anchors.fill: parent
                    color: Theme.colors.backgroundDark
                    radius: 8
                }
                contentItem: Item {
                    anchors.fill: parent

                    Rectangle {
                        color: Theme.colors.text
                        height: parent.height
                        radius: 8
                        width: progress.visualPosition * parent.width
                    }
                }
            }
            Text {
                Layout.preferredWidth: 30
                color: Theme.colors.text
                font.pixelSize: 12
                text: parent.timeFromSeconds(player?.length || 0)
            }
        }
    }
    RowLayout {
        Layout.rightMargin: 20
        spacing: 0

        // Shuffle
        Button {
            ToolTip.text: player?.shuffle ? "Shuffle On" : "Shuffle Off"
            font.family: Theme.font.family.nerd
            font.pixelSize: Theme.font.size.large
            text: player?.shuffle ? "󰒟" : "󰒞"

            background: Rectangle {
                color: "transparent"
            }

            onClicked: currentlyPlaying.shuffle()
        }
        // Previous
        Button {
            font.family: Theme.font.family.nerd
            font.pixelSize: Theme.font.size.large
            text: "󰙣"

            background: Rectangle {
                color: "transparent"
            }

            onClicked: player.previous()
        }
        Button {
            font.family: Theme.font.family.nerd
            font.pixelSize: Theme.font.size.large
            text: player?.isPlaying ? "" : ""

            background: Rectangle {
                color: "transparent"
            }

            onClicked: player.togglePlaying()
        }
        Button {
            font.family: Theme.font.family.nerd
            font.pixelSize: Theme.font.size.large
            text: "󰙡"

            background: Rectangle {
                color: "transparent"
            }

            onClicked: player.next()
        }
        Button {
            ToolTip.text: player?.loopState === MprisLoopState.None ? "Repeat Off" : player?.loopState === MprisLoopState.Playlist ? "Loop Playlist" : "Loop Track"
            font.family: Theme.font.family.nerd
            font.pixelSize: Theme.font.size.large
            text: player?.loopState === MprisLoopState.None ? "󰑗" : player?.loopState === MprisLoopState.Playlist ? "󰑖" : "󰑘"

            background: Rectangle {
                color: "transparent"
            }

            onClicked: currentlyPlaying.repeat()
        }
    }
}
