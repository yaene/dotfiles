//@ pragma UseQApplication
import Quickshell // for PanelWindow
import QtQuick
import "./bar"
import "./osd"
import "./spotify"
import "./notifications"

ShellRoot {
    Bar {
    }
    BrightnessOSD {
    }
    VolumeOSD {
    }
    Spotify {
    }
    Notifications {
    }
}
