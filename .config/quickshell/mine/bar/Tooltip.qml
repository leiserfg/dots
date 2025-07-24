import QtQuick
import Quickshell
import Quickshell.Hyprland
import "root:/"

Scope {
  id: root

  readonly property TooltipItem activeItem: activeMenu ?? activeTooltip
  property TooltipItem activeMenu: null
  property TooltipItem activeTooltip: null
  required property var bar
  property real hangTime: lastActiveItem?.hangTime ?? 0
  property TooltipItem lastActiveItem: null
  property real scaleMul: lastActiveItem && lastActiveItem.targetVisible ? 1 : 0
  readonly property TooltipItem shownItem: activeItem ?? lastActiveItem
  property Item tooltipItem: null

  function doLastHide() {
    lastActiveItem.targetVisible = false;
  }

  function onHidden(item: TooltipItem) {
    if (item == lastActiveItem) {
      lastActiveItem = null;
    }
  }

  function removeItem(item: TooltipItem) {
    if (item.isMenu && activeMenu == item) {
      activeMenu = null;
    } else if (!item.isMenu && activeTooltip == item) {
      activeTooltip = null;
    }
  }

  function setItem(item: TooltipItem) {
    if (item.isMenu) {
      activeMenu = item;
    } else {
      activeTooltip = item;
    }
  }

  Behavior on scaleMul {
    SmoothedAnimation {
      velocity: 5
    }
  }

  onActiveItemChanged: {
    if (activeItem != null) {
      hangTimer.stop();
      activeItem.targetVisible = true;

      if (tooltipItem) {
        activeItem.parent = tooltipItem;
      }
    }

    if (lastActiveItem != null && lastActiveItem != activeItem) {
      if (activeItem != null)
        lastActiveItem.targetVisible = false;
      else if (root.hangTime == 0)
        doLastHide();
      else
        hangTimer.start();
    }

    if (activeItem != null)
      lastActiveItem = activeItem;
  }

  Timer {
    id: hangTimer

    interval: root.hangTime

    onTriggered: doLastHide()
  }

  LazyLoader {
    id: popupLoader

    activeAsync: shownItem != null

    PopupWindow {
      id: popup

      HyprlandWindow.opacity: root.scaleMul
      color: "transparent"
      implicitHeight: {
        const h = tooltipItem.lowestAnimY - tooltipItem.highestAnimY;
        //console.log(`seth ${h} ${tooltipItem.highestAnimY} ${tooltipItem.lowestAnimY}; ${tooltipItem.y1} ${tooltipItem.y2}`)
        return h;
      }

      //height: bar.height
      implicitWidth: Math.max(700, tooltipItem.largestAnimWidth) // max due to qtwayland glitches

      visible: true

      HyprlandWindow.visibleMask: Region {
        id: visibleMask

        item: tooltipItem
      }
      //color: "#20ff0000"

      mask: Region {
        item: (shownItem?.hoverable ?? false) ? tooltipItem : null
      }

      anchor {
        adjustment: PopupAdjustment.None
        rect.x: bar.tooltipXOffset
        rect.y: tooltipItem.highestAnimY
        window: bar
      }

      Connections {
        function onScaleMulChanged() {
          visibleMask.changed();
        }

        target: root
      }

      HyprlandFocusGrab {
        active: activeItem?.isMenu ?? false
        windows: [popup, bar, ...(activeItem?.grabWindows ?? [])]

        onActiveChanged: {
          if (!active && activeItem?.isMenu) {
            activeMenu.close();
          }
        }
      }


      Item {
        id: tooltipItem

        readonly property bool anyAnimsRunning: y1Anim.running || y2Anim.running || widthAnim.running
        property var highestAnimY: 0 // unused due to reposition timing issues
        property var largestAnimWidth: 0
        property var lowestAnimY: bar.height
        readonly property var targetHeight: shownItem?.implicitHeight ?? 0
        readonly property var targetWidth: shownItem?.implicitWidth ?? 0
        readonly property real targetY: {
          if (shownItem == null)
            return 0;
          const target = bar.contentItem.mapFromItem(shownItem.owner, 0, shownItem.targetRelativeY).y;
          return bar.boundedY(target, shownItem.implicitHeight / 2);
        }
        property var w: -1
        property var y1: -1
        property var y2: -1

        function updateYBounds() {
          if (targetY - targetHeight / 2 < highestAnimY)
          //highestAnimY = targetY - targetHeight / 2
          {}

          if (targetY + targetHeight / 2 > lowestAnimY)
          //lowestAnimY = targetY + targetHeight / 2
          {}
        }

        clip: width != targetWidth || height != targetHeight
        height: y2 - y1
        width: Math.max(1, w)
        y: y1 - popup.anchor.rect.y

        transform: Scale {
          origin.x: 0
          origin.y: tooltipItem.height / 2
          xScale: 0.9 + scaleMul * 0.1
          yScale: xScale
        }
        SmoothedAnimation on w {
          id: widthAnim

          to: tooltipItem.targetWidth

          onToChanged: {
            if (tooltipItem.w == -1 || !(shownItem?.animateSize ?? true)) {
              stop();
              tooltipItem.w = to;
            } else {
              velocity = (Math.max(tooltipItem.width, to) - Math.min(tooltipItem.width, to)) * 5;
              restart();
            }
          }
        }
        SmoothedAnimation on y1 {
          id: y1Anim

          to: tooltipItem.targetY - tooltipItem.targetHeight / 2

          onToChanged: {
            if (tooltipItem.y1 == -1 || !(shownItem?.animateSize ?? true)) {
              stop();
              tooltipItem.y1 = to;
            } else {
              velocity = (Math.max(tooltipItem.y1, to) - Math.min(tooltipItem.y1, to)) * 5;
              restart();
            }
          }
        }
        SmoothedAnimation on y2 {
          id: y2Anim

          to: tooltipItem.targetY + tooltipItem.targetHeight / 2

          onToChanged: {
            if (tooltipItem.y2 == -1 || !(shownItem?.animateSize ?? true)) {
              stop();
              tooltipItem.y2 = to;
            } else {
              velocity = (Math.max(tooltipItem.y2, to) - Math.min(tooltipItem.y2, to)) * 5;
              restart();
            }
          }
        }

        Component.onCompleted: {
          root.tooltipItem = this;
          if (root.shownItem) {
            root.shownItem.parent = this;
          }

          //highestAnimY = targetY - targetHeight / 2;
          //lowestAnimY = targetY + targetHeight / 2;
        }
        onAnyAnimsRunningChanged: {
          if (!anyAnimsRunning) {
            largestAnimWidth = targetWidth;
            //highestAnimY = y1;
            //lowestAnimY = y2;
          }
        }
        onTargetHeightChanged: updateYBounds()
        onTargetWidthChanged: {
          if (targetWidth > largestAnimWidth) {
            largestAnimWidth = targetWidth;
          }
        }
        onTargetYChanged: updateYBounds()

        // bkg
        BarWidgetInner {
          anchors.fill: parent
          color: ShellGlobals.colors.bar
        }
      }
    }
  }
}
