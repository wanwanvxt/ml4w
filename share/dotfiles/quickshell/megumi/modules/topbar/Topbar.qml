import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules.common
import qs.modules.common.widgets

Scope {
  id: root

  component VerticalTopbarSeparator: Rectangle {
    Layout.topMargin: Styles.size.topbar.height / 3
    Layout.bottomMargin: Styles.size.topbar.height / 3
    Layout.fillHeight: true
    implicitWidth: 1
    color: Styles._color.colOutlineVariant
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: topbarWrapper

      required property ShellScreen modelData
      screen: modelData

      WlrLayershell.namespace: "megumi:bar"
      exclusiveZone: Styles.size.topbar.exclusiveZone
      implicitHeight: Styles.size.topbar.wrapperHeight
      anchors {
        top: true
        bottom: false
        left: true
        right: true
      }
      color: "transparent"

      Item {
        id: topbar

        implicitHeight: Styles.size.topbar.height
        anchors {
          fill: parent
          margins: Styles.size.topbar.margin
        }

        // topbar shadow
        StyledRectangularShadow {
          target: topbarBackground
        }

        // topbar background
        Rectangle {
          id: topbarBackground

          anchors.fill: parent
          color: Styles._color.colLayer0
          border {
            color: Styles._color.colOutlineVariant
            width: 2
          }
          radius: Styles.rounding.windowRounding
        }

        // topbar left section
        TopbarSection {
          anchors.left: parent.left

          ActiveWindow {
            screen: topbarWrapper.screen
          }
        }

        // topbar middle section
        TopbarSection {
          anchors.centerIn: parent

          Workspaces {
            screen: topbarWrapper.screen
          }
        }

        // topbar right section
        TopbarSection {
          anchors.right: parent.right

          SysTray {
            window_: topbarWrapper
          }
          VerticalTopbarSeparator {}
          ClockWidget {}
        }
      }
    }
  }
}
