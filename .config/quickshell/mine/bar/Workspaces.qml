pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."
import "root:."
import QtQuick.Effects

FullwidthMouseArea {
  id: root

  required property var bar
  property int currentIndex: 0
  property int existsCount: 0
  property bool hideWhenEmpty: false
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)
  required property int wsBaseIndex
  property int wsCount: 10

  // destructor takes care of nulling
  signal workspaceAdded(workspace: HyprlandWorkspace)

  acceptedButtons: Qt.NoButton
  fillWindowWidth: true
  implicitHeight: column.implicitHeight + 10
  visible: !hideWhenEmpty || existsCount > 0

  Component.onCompleted: {
    Hyprland.workspaces.values.forEach(workspace => {
      root.workspaceAdded(workspace);
    });
  }
  onWheel: event => {
    event.accepted = true;
    const step = -Math.sign(event.angleDelta.y);
    const targetWs = currentIndex + step;

    if (targetWs >= wsBaseIndex && targetWs < wsBaseIndex + wsCount) {
      Hyprland.dispatch(`workspace ${targetWs}`);
    }
  }

  ColumnLayout {
    id: column

    spacing: 0

    anchors {
      fill: parent
      margins: 5
      topMargin: 0
    }

    Repeater {
      model: root.wsCount

      FullwidthMouseArea {
        id: wsItem

        property bool active: workspace?.active ?? false
        property real animActive: active ? 1 : 0
        property real animExists: exists ? 1 : 0
        property bool exists: workspace != null
        required property int index
        property HyprlandWorkspace workspace: null
        property int wsIndex: root.wsBaseIndex + index

        Layout.fillWidth: true
        fillWindowWidth: true
        implicitHeight: 15

        Behavior on animActive {
          NumberAnimation {
            duration: 150
          }
        }
        Behavior on animExists {
          NumberAnimation {
            duration: 100
          }
        }

        onActiveChanged: {
          if (active)
            root.currentIndex = wsIndex;
        }
        onExistsChanged: {
          root.existsCount += exists ? 1 : -1;
        }
        onPressed: Hyprland.dispatch(`workspace ${wsIndex}`)

        Connections {
          function onWorkspaceAdded(workspace: HyprlandWorkspace) {
            if (workspace.id == wsItem.wsIndex) {
              wsItem.workspace = workspace;
            }
          }

          target: root
        }

        Rectangle {
          anchors.centerIn: parent
          border.color: ShellGlobals.colors.widgetOutline
          border.width: 1
          color: ShellGlobals.interpolateColors(animExists, ShellGlobals.colors.widget, ShellGlobals.colors.widgetActive)
          height: parent.width * 0.9
          radius: height / 2
          scale: 1 + wsItem.animActive * 0.3
          width: parent.width * 0.9
        }
      }
    }
  }

  Connections {
    function onObjectInsertedPost(workspace) {
      root.workspaceAdded(workspace);
    }

    target: Hyprland.workspaces
  }
}
