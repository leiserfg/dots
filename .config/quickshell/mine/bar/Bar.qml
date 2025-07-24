pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import "systray" as SysTray
import "audio" as Audio
import "mpris" as Mpris
import "power" as Power
import "../notifications" as Notifs

BarContainment {
  id: root

  property bool isSoleBar: Quickshell.screens.length == 1

  ColumnLayout {
    anchors {
      left: parent.left
      right: parent.right
      top: parent.top
    }

    ColumnLayout {
      Layout.fillWidth: true

      Notifs.NotificationWidget {
        Layout.fillWidth: true
        bar: root
      }

      ColumnLayout {
        spacing: 0

        Loader {
          Layout.fillWidth: true
          Layout.preferredHeight: active ? implicitHeight : 0
          active: root.isSoleBar

          sourceComponent: Workspaces {
            bar: root
            wsBaseIndex: 1
          }
        }

        Workspaces {
          Layout.fillWidth: true
          bar: root
          hideWhenEmpty: root.isSoleBar
          wsBaseIndex: root.screen.name == "eDP-1" ? 6 : 1
        }
      }
    }
  }

  ColumnLayout {
    anchors {
      bottom: parent.bottom
      left: parent.left
      right: parent.right
    }

    Mpris.Players {
      Layout.fillWidth: true
      bar: root
    }

    Audio.AudioControls {
      Layout.fillWidth: true
      bar: root
    }

    SysTray.SysTray {
      Layout.fillWidth: true
      bar: root
    }

    // Power.Power {
    //   Layout.fillWidth: true
    //   bar: root
    // }

    ClockWidget {
      Layout.fillWidth: true
      bar: root
    }
  }
}
