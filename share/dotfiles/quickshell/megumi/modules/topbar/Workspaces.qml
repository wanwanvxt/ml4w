import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import qs.modules.common
import qs.modules.common.functions
import qs.services

Item {
  id: root

  required property var screen
  readonly property int maxWorkspaces: 10
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel
  property list<bool> workspacesOccupied: []

  implicitWidth: background.implicitWidth + background.spacing
  implicitHeight: Styles.size.topbar.workspace.buttonWidth

  function updateWorkspaceOccupied() {
    workspacesOccupied = Array.from({
      length: maxWorkspaces
    }, (_, idx) => {
      return Hyprland.workspaces.values.some(ws => ws.id === (idx + 1));
    });
  }

  Connections {
    target: Hyprland.workspaces
    function onValuesChanged() {
      root.updateWorkspaceOccupied();
    }
  }

  Component.onCompleted: updateWorkspaceOccupied()

  // scroll to switch workspaces
  WheelHandler {
    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
    onWheel: event => {
      if (event.angleDelta.y < 0) {
        Hyprland.dispatch("workspace e+1");
      } else if (event.angleDelta.y > 0) {
        Hyprland.dispatch("workspace e-1");
      }
    }
  }

  // background
  Rectangle {
    anchors.fill: parent
    radius: Styles.rounding.full
    color: Styles._color.colLayer2
  }
  RowLayout {
    id: background

    z: 1
    spacing: 0
    anchors.fill: parent
    implicitHeight: Styles.size.topbar.height

    Repeater {
      model: root.maxWorkspaces

      Rectangle {
        z: 2
        implicitWidth: Styles.size.topbar.workspace.buttonWidth
        implicitHeight: Styles.size.topbar.workspace.buttonWidth
        radius: Styles.rounding.full
        property var leftOccupied: (root.workspacesOccupied[model.index - 1] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace.id === (model.index)))
        property var rightOccupied: (root.workspacesOccupied[model.index + 1] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace.id === (model.index + 2)))
        property int radiusLeft: leftOccupied ? 0 : Styles.rounding.full
        property int radiusRight: rightOccupied ? 0 : Styles.rounding.full
        topLeftRadius: radiusLeft
        bottomLeftRadius: radiusLeft
        topRightRadius: radiusRight
        bottomRightRadius: radiusRight
        color: ColorUtils.transparentize(Styles.m3color.m3_secondaryContainer, 0.4)
        opacity: (root.workspacesOccupied[model.index] && !(!root.activeWindow?.activated && root.monitor?.activeWorkspace.id === (model.index + 1))) ? 1 : 0

        Behavior on opacity {
          animation: Styles.animation.elementMove.numberAnimation.createObject(this)
        }
        Behavior on leftOccupied {
          animation: Styles.animation.elementMove.numberAnimation.createObject(this)
        }
        Behavior on rightOccupied {
          animation: Styles.animation.elementMove.numberAnimation.createObject(this)
        }
      }
    }
  }

  // active workspace
  Rectangle {
    z: 3
    property real idx1: monitor?.activeWorkspace.id - 1
    property real idx2: monitor?.activeWorkspace.id - 1
    x: Math.min(idx1, idx2) * Styles.size.topbar.workspace.buttonWidth + Styles.size.topbar.workspace.activeMargin
    implicitWidth: Math.abs(idx1 - idx2) * Styles.size.topbar.workspace.buttonWidth + Styles.size.topbar.workspace.buttonWidth - Styles.size.topbar.workspace.activeMargin * 2
    implicitHeight: Styles.size.topbar.workspace.buttonWidth - Styles.size.topbar.workspace.activeMargin * 2
    radius: Styles.rounding.full
    color: Styles._color.colPrimary
    anchors.verticalCenter: parent.verticalCenter

    Behavior on idx1 {
      NumberAnimation {
        duration: 100
        easing.type: Easing.OutSine
      }
    }
    Behavior on idx2 {
      NumberAnimation {
        duration: 300
        easing.type: Easing.OutSine
      }
    }
  }

  // window icons
  RowLayout {
    id: icons

    z: 4
    spacing: 0
    anchors.fill: parent
    implicitHeight: Styles.size.topbar.height

    Repeater {
      model: maxWorkspaces

      Button {
        id: buttonWorkspace

        property var biggestWindow: HyprService.biggestWindowByWorkspace(model.index + 1)
        width: Styles.size.topbar.workspace.buttonWidth
        Layout.fillHeight: true
        onPressed: Hyprland.dispatch(`workspace ${model.index + 1}`)
        background: Item {
          id: buttonWorkspaceBackground

          implicitWidth: Styles.size.topbar.workspace.buttonWidth
          implicitHeight: Styles.size.topbar.workspace.buttonWidth

          Rectangle {
            id: buttonWorkspaceDot

            width: Styles.size.topbar.workspace.buttonWidth * 0.2
            height: Styles.size.topbar.workspace.buttonWidth * 0.2
            anchors.centerIn: parent
            radius: Styles.rounding.full
            color: (monitor?.activeWorkspace.id === (model.index + 1)) ? Styles.m3color.m3_onPrimary : (workspacesOccupied[model.index] ? Styles.m3color.m3_onSecondaryContainer : Styles._color.colOnLayer1Inactive)
            opacity: biggestWindow ? 0 : 1
          }

          IconImage {
            id: biggestWindowIcon

            width: Styles.size.topbar.workspace.buttonWidth * 0.7
            height: Styles.size.topbar.workspace.buttonWidth * 0.7
            anchors.centerIn: parent
            source: Quickshell.iconPath(AppService.guessIcon(biggestWindow?.class), "image-missing")
            opacity: biggestWindow ? 1 : 0
          }
        }
      }
    }
  }
}
