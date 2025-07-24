pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Effects
import Quickshell
import Quickshell.Services.Mpris
import ".."
import "../.."

import QtQuick.Effects

FullwidthMouseArea {
  id: root

  readonly property var activePlayer: MprisController.activePlayer
  required property var bar
  property alias widgetOpen: persist.widgetOpen

  acceptedButtons: Qt.RightButton | Qt.ForwardButton | Qt.BackButton
  fillWindowWidth: true
  hoverEnabled: true
  implicitHeight: column.implicitHeight + 10

  onPressed: event => {
    if (event.button == Qt.RightButton)
      widgetOpen = !widgetOpen;
    else if (event.button == Qt.ForwardButton) {
      MprisController.next();
    } else if (event.button == Qt.BackButton) {
      MprisController.previous();
    }
  }
  onWheel: event => {
    event.accepted = true;
    if (MprisController.canChangeVolume) {
      root.activePlayer.volume = Math.max(0, Math.min(1, root.activePlayer.volume + (event.angleDelta.y / 120) * 0.05));
    }
  }

  PersistentProperties {
    id: persist

    property bool widgetOpen: false

    reloadableId: "MusicWidget"

    onReloaded: {
      rightclickMenu.snapOpacity(widgetOpen ? 1.0 : 0.0);
    }
  }

  Item {
    id: widget

    property Scope positionInfo: Scope {
      id: positionInfo

      property int length: Math.floor(player.length)
      property var player: root.activePlayer
      property int position: Math.floor(player.position)

      function timeStr(time: int): string {
        const seconds = time % 60;
        const minutes = Math.floor(time / 60);

        return `${minutes}:${seconds.toString().padStart(2, '0')}`;
      }

      FrameAnimation {
        id: posTracker

        running: positionInfo.player.isPlaying && (tooltip.visible || rightclickMenu.visible)

        onTriggered: positionInfo.player.positionChanged()
      }
    }
    property var rightclickMenu: TooltipItem {
      id: rightclickMenu

      isMenu: true
      owner: root

      // some very large covers take a sec to appear in the background,
      // so we'll try to preload them.
      preloadBackground: root.containsMouse
      show: widgetOpen
      tooltip: bar.tooltip

      backgroundComponent: BackgroundArt {
        id: popupBkg

        anchors.fill: parent
        blurRadius: 100
        blurSamples: 201
        overlay.color: "#80000000"
        renderHeight: rightclickMenu.implicitHeight
        renderWidth: rightclickMenu.implicitWidth

        Component.onCompleted: {
          setArt(MprisController.activeTrack.artUrl, false, true);
        }

        Connections {
          function onTrackChanged(reverse: bool) {
            console.log(`track changed: rev: ${reverse}`);
            popupBkg.setArt(MprisController.activeTrack.artUrl, reverse, false);
          }

          target: MprisController
        }
      }

      onClose: widgetOpen = false

      contentItem {
        implicitHeight: 650
        implicitWidth: 500
      }

      Loader {
        active: rightclickMenu.visible
        height: 650
        width: 500

        sourceComponent: ColumnLayout {
          property var player: root.activePlayer

          anchors.fill: parent

          Connections {
            function onTrackChanged(reverse: bool) {
              trackStack.updateTrack(reverse, false);
            }

            target: MprisController
          }

          Item {
            id: playerSelectorContainment

            Layout.fillWidth: true
            implicitHeight: playerSelector.implicitHeight + 20
            implicitWidth: playerSelector.implicitWidth

            Rectangle {
              anchors.centerIn: parent
              color: "#20ceffff"
              implicitHeight: 50
              implicitWidth: 50
              radius: 5
            }

            RowLayout {
              id: playerSelector

              //ScrollView {
              property Item selectedPlayerDisplay: null

              anchors.verticalCenter: parent.verticalCenter
              width: Math.min(implicitWidth, playerSelectorContainment.width)
              x: parent.width / 2 - (selectedPlayerDisplay ? selectedPlayerDisplay.x + selectedPlayerDisplay.width / 2 : 0)

              Behavior on x {
                NumberAnimation {
                  duration: 400
                  easing.type: Easing.OutExpo
                }
              }

              onSelectedPlayerDisplayChanged: console.log(selectedPlayerDisplay)

              //RowLayout {
              Repeater {
                model: Mpris.players

                MouseArea {
                  required property MprisPlayer modelData
                  readonly property bool selected: modelData == player

                  implicitHeight: childrenRect.height
                  implicitWidth: childrenRect.width

                  onClicked: MprisController.setActivePlayer(modelData)
                  onSelectedChanged: if (selected)
                    playerSelector.selectedPlayerDisplay = this

                  Item {
                    implicitHeight: 50
                    implicitWidth: 50

                    Image {
                      anchors.fill: parent
                      anchors.margins: 5
                      cache: false
                      source: {
                        const entry = DesktopEntries.byId(modelData.desktopEntry);
                        console.log(`ent ${entry} id ${modelData.desktopEntry}`);
                        return Quickshell.iconPath(entry?.icon);
                      }
                      sourceSize.height: 50
                      sourceSize.width: 50
                    }
                  }
                }
                //}
              }
            }
          }

          Item {
            Layout.bottomMargin: 20
            Layout.fillWidth: true

            Label {
              anchors.centerIn: parent
              text: root.activePlayer.identity
            }
          }

          SlideView {
            id: trackStack

            readonly property real fromPos: trackStack.width * (trackStack.reverse ? -1 : 1)
            property Flickable lastFlicked
            property bool reverse: false
            property var trackComponent: Component {
              Flickable {
                id: flickable

                // in most cases this is ready around the same time as the background,
                // but may take longer if the image is huge.
                readonly property bool svReady: img.status === Image.Ready
                required property var track

                contentWidth: width + 1

                onDragEnded: {
                  //return;
                  console.log(`dragend ${contentX}`);
                  if (Math.abs(contentX) > 75) {
                    if (contentX < 0)
                      MprisController.previous();
                    else if (contentX > 0)
                      MprisController.next();
                  }
                }
                onDragStarted: trackStack.lastFlicked = this

                ColumnLayout {
                  id: trackContent

                  height: flickable.height
                  width: flickable.width

                  Item {
                    Layout.fillWidth: true
                    implicitHeight: 302//img.implicitHeight
                    implicitWidth: img.implicitWidth

                    Image {
                      id: img

                      anchors.centerIn: parent
                      asynchronous: true
                      //height: 300
                      //fillMode: Image.PreserveAspectFit
                      cache: false
                      layer.enabled: true
                      source: track.artUrl ?? ""
                      sourceSize.height: 300
                      sourceSize.width: 300

                      layer.effect: MultiEffect {
                        maskEnabled: true

                        maskSource: Rectangle {
                          height: img.height
                          radius: 5
                          width: img.width
                        }
                      }
                    }
                  }

                  CenteredText {
                    Layout.topMargin: 20
                    font.pointSize: albumLabel.font.pointSize + 1
                    text: track.title
                  }

                  CenteredText {
                    id: albumLabel

                    Layout.topMargin: 18
                    opacity: 0.8
                    text: track.album
                  }

                  CenteredText {
                    Layout.topMargin: 20
                    text: track.artist
                  }

                  Item {
                    Layout.fillHeight: true
                  }
                }
              }
            }

            function updateTrack(reverse: bool, immediate: bool) {
              this.reverse = reverse;
              this.replace(trackComponent, {
                track: MprisController.activeTrack
              }, immediate);
            }

            Layout.fillWidth: true

            // inverse of default tooltip margin - 1px for border
            Layout.leftMargin: -4
            Layout.rightMargin: -4
            clip: animating || (lastFlicked?.contentX ?? 0) != 0
            implicitHeight: 400

            // intentionally slightly faster than the background
            enterTransition: PropertyAnimation {
              duration: 350
              easing.type: Easing.OutExpo
              from: trackStack.fromPos
              property: "x"
              to: 0
            }
            exitTransition: PropertyAnimation {
              duration: 350
              easing.type: Easing.OutExpo
              property: "x"
              to: target.x - trackStack.fromPos
            }

            Component.onCompleted: updateTrack(false, true)
          }

          Item {
            Layout.fillHeight: true
          }

          Item {
            Layout.fillWidth: true
            implicitHeight: controlsRow.implicitHeight

            RowLayout {
              id: controlsRow

              anchors.centerIn: parent

              ClickableIcon {
                baseMargin: 3
                enabled: MprisController.loopSupported
                image: {
                  switch (MprisController.loopState) {
                  case MprisLoopState.None:
                    return "root:icons/repeat-none.svg";
                  case MprisLoopState.Playlist:
                    return "root:icons/repeat-all.svg";
                  case MprisLoopState.Track:
                    return "root:icons/repeat-once.svg";
                  }
                }
                implicitHeight: width
                implicitWidth: 50
                scaleIcon: false

                onClicked: {
                  let target = MprisLoopState.None;
                  switch (MprisController.loopState) {
                  case MprisLoopState.None:
                    target = MprisLoopState.Playlist;
                    break;
                  case MprisLoopState.Playlist:
                    target = MprisLoopState.Track;
                    break;
                  case MprisLoopState.Track:
                    target = MprisLoopState.None;
                    break;
                  }

                  MprisController.setLoopState(target);
                }
              }

              ClickableIcon {
                baseMargin: 3
                enabled: MprisController.canGoPrevious
                image: "root:icons/rewind.svg"
                implicitHeight: width
                implicitWidth: 60
                scaleIcon: false

                onClicked: MprisController.previous()
              }

              ClickableIcon {
                Layout.leftMargin: -10
                Layout.rightMargin: -10
                enabled: MprisController.canTogglePlaying
                image: `root:icons/${MprisController.isPlaying ? "pause" : "play"}.svg`
                implicitHeight: width
                implicitWidth: 80
                scaleIcon: false

                onClicked: MprisController.togglePlaying()
              }

              ClickableIcon {
                baseMargin: 3
                enabled: MprisController.canGoNext
                image: "root:icons/fast-forward.svg"
                implicitHeight: width
                implicitWidth: 60
                scaleIcon: false

                onClicked: MprisController.next()
              }

              ClickableIcon {
                enabled: MprisController.shuffleSupported
                image: `root:icons/${MprisController.hasShuffle ? "shuffle" : "shuffle-off"}.svg`
                implicitHeight: width
                implicitWidth: 50
                scaleIcon: false

                onClicked: MprisController.setShuffle(!MprisController.hasShuffle)
              }
            }
          }

          RowLayout {
            Layout.margins: 5

            Label {
              Layout.preferredWidth: lengthLabel.implicitWidth
              text: positionInfo.timeStr(positionInfo.position)
            }

            MediaSlider {
              id: slider

              property bool bindSlider: true
              property real boundAnimFactor: 1
              property real boundAnimStart: 0
              property real boundPosition: {
                const ppos = player.position / player.length;
                const bpos = boundAnimStart;
                return (ppos * boundAnimFactor) + (bpos * (1.0 - boundAnimFactor));
              }
              property real lastLength: 0
              property real lastPosition: 0

              Layout.fillWidth: true
              barColor: quant.colors.length === 0 ? "#80ceffff" : Qt.alpha(Qt.lighter(quant.colors[0]), 0.5)
              enabled: player.canSeek
              from: 0
              grooveColor: quant.colors.length === 0 ? "#30ceffff" : Qt.alpha(quant.colors[0], 0.2)
              to: 1

              Behavior on barColor {
                ColorAnimation {
                  duration: 200
                }
              }
              Behavior on grooveColor {
                ColorAnimation {
                  duration: 200
                }
              }

              onPressedChanged: {
                if (!pressed)
                  player.position = value * player.length;
                bindSlider = !pressed;
              }

              NumberAnimation {
                id: boundAnim

                duration: 600
                easing.type: Easing.OutExpo
                from: 0
                property: "boundAnimFactor"
                target: slider
                to: 1
              }

              Connections {
                function onPositionChanged() {
                  if (false && player.position == 0 && slider.lastPosition != 0 && !boundAnim.running) {
                    slider.boundAnimStart = slider.lastPosition / slider.lastLength;
                    boundAnim.start();
                  }

                  slider.lastPosition = player.position;
                  slider.lastLength = player.length;
                }

                target: player
              }

              ColorQuantizer {
                id: quant

                depth: 0
                rescaleSize: 200
                source: MprisController.activeTrack.artUrl

                onColorsChanged: console.log(colors)
              }

              Binding {
                slider.value: slider.boundPosition
                when: slider.bindSlider
              }
            }

            Label {
              id: lengthLabel

              text: positionInfo.timeStr(positionInfo.length)
            }
          }
        }
      }
    }
    property real scaleMul: widgetOpen ? 100 : 1
    property TooltipItem tooltip: TooltipItem {
      id: tooltip

      /*ColumnLayout {
				ColumnLayout {
					visible: MprisController.activePlayer != null

					Label { text: MprisController.activeTrack?.title ?? "" }

					Label {
						text: {
							const artist = MprisController.activeTrack?.artist ?? "";
							const album = MprisController.activeTrack?.album ?? "";

							return artist + (album ? ` - ${album}` : "");
						}
					}

					Label { text: MprisController.activePlayer?.identity ?? "" }
				}

				Label {
					visible: MprisController.activePlayer == null
					text: "No media playing"
				}

				Rectangle { implicitHeight: 10; color: "white"; Layout.fillWidth: true }
				}*/

      contentItem.anchors.margins: 0
      owner: root
      show: root.containsMouse
      tooltip: bar.tooltip

      Item {
        id: ttcontent

        height: Math.max(parent.height, implicitHeight)
        implicitHeight: cl.implicitHeight + 10 + (MprisController.activePlayer ? 8 : 0)
        implicitWidth: cl.implicitWidth + 10
        layer.enabled: true
        width: parent.width

        layer.effect: MultiEffect {
          maskEnabled: true

          maskSource: Rectangle {
            bottomLeftRadius: 5
            bottomRightRadius: 5
            height: ttcontent.height
            width: ttcontent.width
          }
        }

        ColumnLayout {
          id: cl

          anchors {
            left: parent.left
            margins: 5
            right: parent.right
            top: parent.top
          }

          //visible: MprisController.activePlayer != null

          FontMetrics {
            id: fontmetrics

          }

          FullheightLabel {
            text: MprisController.activeTrack?.title ?? ""
            visible: MprisController.activePlayer != null
          }

          FullheightLabel {
            text: MprisController.activeTrack?.artist ?? ""
            /*text: {
							const artist = MprisController.activeTrack?.artist ?? "";
							const album = MprisController.activeTrack?.album ?? "";

							return artist + (album ? ` - ${album}` : "");
						}*/
            visible: MprisController.activePlayer != null
          }

          Label {
            text: {
              if (!MprisController.activePlayer)
                return "No media playing";

              return MprisController.activePlayer?.identity + " - " + positionInfo.timeStr(positionInfo.position) + " / " + positionInfo.timeStr(positionInfo.length);
            }
          }
        }

        Rectangle {
          id: ttprect

          color: "#30ceffff"
          implicitHeight: 8
          visible: MprisController.activePlayer != null

          anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
          }

          Rectangle {
            color: "#80ceffff"
            width: parent.width * (root.activePlayer.position / root.activePlayer.length)

            anchors {
              bottom: parent.bottom
              left: parent.left
              top: parent.top
            }
          }
        }
      }
    }

    anchors.fill: parent
    implicitHeight: column.implicitHeight + 10
    scale: scaleCurve.interpolate(scaleMul / 100, 1, (width - 6) / width)

    Behavior on scaleMul {
      SmoothedAnimation {
        velocity: 600
      }
    }

    EasingCurve {
      id: scaleCurve

      curve.type: Easing.Linear
    }

    BackgroundArt {
      id: bkg

      function updateArt(reverse: bool) {
        console.log("update art", MprisController.activeTrack.artUrl);
        this.setArt(MprisController.activeTrack.artUrl, reverse, false);
      }

      anchors.fill: parent
      overlay.color: "#30000000"

      Component.onCompleted: this.updateArt(false)

      Connections {
        function onTrackChanged(reverse: bool) {
          bkg.updateArt(reverse);
        }

        target: MprisController
      }
    }

    ColumnLayout {
      id: column

      anchors {
        fill: parent
        margins: 5
      }

      ClickableIcon {
        Layout.fillWidth: true
        baseMargin: 3
        enabled: MprisController.canGoPrevious
        hoverEnabled: false
        image: "root:icons/rewind.svg"
        implicitHeight: width
        scaleIcon: false

        onClicked: MprisController.previous()
      }

      ClickableIcon {
        Layout.fillWidth: true
        enabled: MprisController.canTogglePlaying
        hoverEnabled: false
        image: `root:icons/${MprisController.isPlaying ? "pause" : "play"}.svg`
        implicitHeight: width
        scaleIcon: false

        onClicked: MprisController.togglePlaying()
      }

      ClickableIcon {
        Layout.fillWidth: true
        baseMargin: 3
        enabled: MprisController.canGoNext
        hoverEnabled: false
        image: "root:icons/fast-forward.svg"
        implicitHeight: width
        scaleIcon: false

        onClicked: MprisController.next()
      }
    }
  }

  component CenteredText: Item {
    property alias font: label.font
    property alias text: label.text

    Layout.fillWidth: true

    Label {
      id: label

      anchors.centerIn: parent
      elide: Text.ElideRight
      visible: text != ""
      width: Math.min(parent.width - 20, implicitWidth)
    }
  }
  component FullheightLabel: Item {
    property alias text: label.text

    implicitHeight: fontmetrics.height
    implicitWidth: label.implicitWidth

    Label {
      id: label

      anchors.verticalCenter: parent.verticalCenter
    }
  }
}
