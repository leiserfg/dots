import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import ".."
import "../lock" as Lock

PanelWindow {
  id: root

  default property alias barItems: containment.data
  property real baseWidth: 40
  property real compactState: isFullscreenWorkspace ? 0 : 1
  readonly property bool isFullscreenWorkspace: Hyprland.monitorFor(screen).activeWorkspace.hasFullscreen
  property real leftMargin: root.compactState * 10
  readonly property Tooltip tooltip: tooltip
  readonly property real tooltipXOffset: root.baseWidth + root.leftMargin + 5

  function boundedY(targetY: real, height: real): real {
    return Math.max(barRect.anchors.topMargin + height, Math.min(barRect.height + barRect.anchors.topMargin - height, targetY));
  }

  WlrLayershell.namespace: "shell:bar"
  color: "transparent"
  exclusiveZone: baseWidth + (isFullscreenWorkspace ? 0 : 15) - margins.left
  width: baseWidth + 15

  Behavior on compactState {
    NumberAnimation {
      duration: 600
      easing.bezierCurve: [0.0, 0.75, 0.15, 1.0, 1.0, 1.0]
      easing.type: Easing.BezierSpline
    }
  }
  mask: Region {
    height: root.height
    width: root.exclusiveZone
  }

  anchors {
    bottom: true
    left: true
    top: true
  }

  Tooltip {
    id: tooltip

    bar: root
  }

  Rectangle {
    id: barRect

    border.color: ShellGlobals.colors.barOutline
    border.width: root.compactState
    color: ShellGlobals.colors.bar
    radius: root.compactState * 5
    width: parent.width - 15
    x: root.leftMargin - Lock.Controller.lockSlide * (barRect.width + root.leftMargin)

    anchors {
      bottom: parent.bottom
      margins: root.compactState * 10
      top: parent.top
    }

    Item {
      id: containment

      anchors {
        fill: parent
        margins: 5
      }
    }
  }
}
