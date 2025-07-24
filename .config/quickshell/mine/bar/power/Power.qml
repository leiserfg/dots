import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.UPower
import Quickshell.Widgets
import ".."
import "root:."
import "root:components"
import "power"

BarWidgetInner {
  id: root

  required property var bar
  readonly property UPowerDevice batteryDevice: UPower.devices.values.find(device => device.isLaptopBattery)
  readonly property var chargeState: UPower.displayDevice.state
  readonly property bool isCharging: chargeState == UPowerDeviceState.Charging
  readonly property bool isLow: percentage <= 0.20
  readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
  readonly property real percentage: UPower.displayDevice.percentage
  property TooltipItem rightclickMenu: TooltipItem {
    id: rightclickMenu

    isMenu: true
    owner: root
    show: root.showMenu
    tooltip: bar.tooltip

    onClose: root.showMenu = false

    Loader {
      active: rightclickMenu.visible

      sourceComponent: ColumnLayout {
        spacing: 10

        FontMetrics {
          id: fm

        }

        RowLayout {
          IconImage {
            implicitSize: 32
            source: "root:icons/gauge.svg"
          }

          ColumnLayout {
            spacing: 0

            Label {
              text: "Power Profile"
            }

            OptionSlider {
              implicitWidth: 350
              index: PowerProfiles.profile
              values: ["Power Save", "Balanced", "Performance"]

              onIndexChanged: PowerProfiles.profile = this.index
            }
          }
        }

        RowLayout {
          IconImage {
            Layout.alignment: Qt.AlignTop
            implicitSize: 32
            source: "root:icons/battery-empty.svg"
          }

          ColumnLayout {
            spacing: 0

            RowLayout {
              Label {
                text: "Battery"
              }

              Item {
                Layout.fillWidth: true
              }

              Label {
                color: "#d0eeffff"
                text: `${root.statusStr()} -`
              }

              Label {
                text: `${Math.round(root.percentage * 100)}%`
              }
            }

            ProgressBar {
              Layout.bottomMargin: 5
              Layout.fillWidth: true
              Layout.topMargin: 5
              value: UPower.displayDevice.percentage
            }

            RowLayout {
              visible: remainingTimeLbl.text !== ""

              SmallLabel {
                text: "Time remaining"
              }

              Item {
                Layout.fillWidth: true
              }

              SmallLabel {
                id: remainingTimeLbl

                text: {
                  const device = UPower.displayDevice;
                  const time = device.timeToEmpty || device.timeToFull;

                  if (time === 0)
                    return "";
                  const minutes = Math.floor(time / 60).toString().padStart(2, '0');
                  return `${minutes} minutes`;
                }
              }
            }

            RowLayout {
              visible: root.batteryDevice.healthSupported

              SmallLabel {
                text: "Health"
              }

              Item {
                Layout.fillWidth: true
              }

              SmallLabel {
                text: `${Math.floor((root.batteryDevice?.healthPercentage ?? 0))}%`
              }
            }
          }
        }

        Repeater {
          model: ScriptModel {
            // external devices
            values: UPower.devices.values.filter(device => !device.powerSupply)
          }

          RowLayout {
            required property UPowerDevice modelData

            IconImage {
              Layout.alignment: Qt.AlignTop
              implicitSize: 32
              source: {
                switch (modelData.type) {
                case UPowerDeviceType.Headset:
                  return "root:icons/headset.svg";
                }
                return Quickshell.iconPath(modelData.iconName);
              }
            }

            ColumnLayout {
              spacing: 0

              RowLayout {
                Label {
                  text: modelData.model
                }

                Item {
                  Layout.fillWidth: true
                }

                Label {
                  text: `${Math.round(modelData.percentage * 100)}%`
                }
              }

              ProgressBar {
                Layout.bottomMargin: 5
                Layout.fillWidth: true
                Layout.topMargin: 5
                value: modelData.percentage
              }

              RowLayout {
                visible: modelData.healthSupported

                SmallLabel {
                  text: "Health"
                }

                Item {
                  Layout.fillWidth: true
                }

                SmallLabel {
                  text: `${Math.floor(modelData.healthPercentage)}%`
                }
              }
            }
          }
        }
      }
    }
  }
  property bool showMenu: false
  property TooltipItem tooltip: TooltipItem {
    id: tooltip

    owner: root
    show: button.containsMouse
    tooltip: bar.tooltip

    Loader {
      active: tooltip.visible

      sourceComponent: Label {
        text: {
          const status = root.statusStr();

          const percentage = Math.round(root.percentage * 100);

          let str = `${percentage}% - ${status}`;
          return str;
        }
      }
    }
  }

  function statusStr() {
    return root.isPluggedIn ? `Plugged in, ${root.isCharging ? "Charging" : "Not Charging"}` : "Discharging";
  }

  color: isLow ? "#45ff6060" : ShellGlobals.colors.widget
  implicitHeight: width

  BarButton {
    id: button

    acceptedButtons: Qt.RightButton
    anchors.fill: parent
    baseMargin: 5
    directScale: true
    fillWindowWidth: true
    showPressed: root.showMenu

    onPressed: {
      root.showMenu = !root.showMenu;
    }

    BatteryIcon {
      device: UPower.displayDevice
    }
  }

  component SmallLabel: Label {
    color: "#d0eeffff"
    font.pointSize: fm.font.pointSize * 0.8
  }
}
