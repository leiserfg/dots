import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QtQuick.Effects

import ".."
import "../.."

BarWidgetInner {
  id: root

  property real blurRadius: 20
  property real blurSamples: 41
  property var component: Component {
    Item {
      id: componentRoot

      // Weird crash if the blur is not owned by its visual parent,
      // so it has to be a component.
      property Item blur: blurComponent.createObject(blurContainment)
      property Component blurComponent: Item {
        id: blur

        height: image.height
        width: componentRoot.width + blurRadius * 8
        //parent: blurContainment
        // blur into the neighboring elements if applicable
        x: componentRoot.x - blurRadius * 4
        y: componentRoot.y + image.y

        onVisibleChanged: {
          if (visible)
            blurSource.scheduleUpdate();
        }

        Connections {
          function onStatusChanged() {
            if (image.status == Image.Ready) {
              blurSource.scheduleUpdate();
            }
          }

          target: image
        }

        ShaderEffectSource {
          id: blurSource

          anchors.fill: parent
          live: false
          sourceItem: stack
          sourceRect: Qt.rect(blur.x, blur.y, blur.width, blur.height)
          visible: false
        }

        Item {
          height: blur.height
          width: blur.width - blurRadius * 2
          x: blurRadius

          MultiEffect {
            blur: root.blurRadius
            blurEnabled: True
            height: blur.height
            // samples: root.blurSamples
            source: blurSource
            visible: true
            width: blur.width
            x: -parent.x
          }
        }
      }
      readonly property bool svReady: image.status === Image.Ready
      property var uri: null

      Component.onDestruction: blur.destroy()

      Image {
        id: image

        anchors.centerIn: parent
        asynchronous: true
        cache: false
        fillMode: Image.PreserveAspectCrop
        height: stack.height + blurRadius * 2
        source: uri
        sourceSize.height: height
        sourceSize.width: width
        width: stack.width + blurRadius * 2
      }
    }
  }
  readonly property Rectangle overlay: overlayItem
  property real renderHeight: height
  property real renderWidth: width
  property bool reverse: false

  function setArt(art: string, reverse: bool, immediate: bool) {
    this.reverse = reverse;

    if (art.length == 0) {
      stack.replace(null);
    } else {
      stack.replace(component, {
        uri: art
      }, immediate);
    }
  }

  border.color: "transparent"

  // slightly offset on the corners :/
  layer.enabled: true

  layer.effect: MultiEffect {
    maskEnabled: true

    maskSource: Rectangle {
      height: root.height
      radius: root.radius
      width: root.width
    }
  }

  SlideView {
    id: stack

    readonly property real fromPos: (stack.width + blurRadius * 2) * (reverse ? -1 : 1)

    anchors.centerIn: parent
    animate: root.visible
    height: renderHeight
    visible: false
    width: renderWidth

    enterTransition: PropertyAnimation {
      duration: 400
      easing.type: Easing.OutExpo
      from: stack.fromPos
      property: "x"
      to: 0
    }
    exitTransition: PropertyAnimation {
      duration: 400
      easing.type: Easing.OutExpo
      property: "x"
      to: -stack.fromPos
    }
  }

  Item {
    id: blurContainment

    height: stack.height
    width: stack.width
    x: stack.x
    y: stack.y
  }

  Rectangle {
    id: overlayItem

    anchors.fill: parent
    color: "transparent"
    radius: root.radius
    visible: true

    Rectangle {
      anchors.fill: parent
      border.color: ShellGlobals.colors.widgetOutlineSeparate
      border.width: 1
      color: "transparent"
      radius: root.radius
    }
  }
}
