import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import Quickshell
import QtQuick
import QtQuick.Controls.Basic

ShellRoot {
  property var date: new Date()
  property string time: Qt.formatDateTime(date, "hh:mm")

  property bool isSoleBar: Quickshell.screens.length == 1;

  ReloadPopup {}

  Variants {
    model: Quickshell.screens

    PanelWindow {
      property var modelData
      screen: modelData

      anchors {
        top: true
        left: true
        right: true
      }

      height: 40
      // color: "#22333388"
      color: "gray"

    RowLayout {
        spacing: 1
        anchors.fill: parent
        // anchors.verticalCenter: parent.verticalCenter

        // RoundButton {
        //     text: "99"
        //     id: btn
        //     radius: 10
        // }
         Item {
            // color: "red"
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Layout.preferredHeight: 4

            Workspaces {
                    bar: root
                    Layout.fillHeight: true
                    wsBaseIndex: root.screen.name == "eDP-1" ? 11 : 1;
                    hideWhenEmpty: root.isSoleBar
            }
        }

         Rectangle {
            color: "green"
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Layout.preferredHeight: 4
        }

         Rectangle {
            color: "blue"
            Layout.fillWidth: true
            Layout.fillHeight: true
            // Layout.preferredHeight: 4
        }
    }

      // Text {
      //   anchors.verticalCenter: parent.verticalCenter
      //   anchors.right: parent.right
      //   anchors.rightMargin: 10
      //
      //   text: time
      //   color: "white"
      //   font.pointSize: 12
      // }
    }
   
  }


  Timer {
    interval: 10000
    running: true
    repeat: true
    onTriggered: date = new Date()
  }
}
