import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.modules.common
import qs.modules.common.widgets

Item {
  id: root

  required property var screen
  readonly property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
  readonly property Toplevel activeWindow: ToplevelManager.activeToplevel

  implicitWidth: Styles.size.topbar.windowTitleWidth
  implicitHeight: Styles.size.topbar.height

  ColumnLayout {
    id: colLayout

    anchors.verticalCenter: parent.verticalCenter
    anchors.left: parent.left
    anchors.right: parent.right
    spacing: -4

    StyledText {
      Layout.fillWidth: true
      font.family: Styles.font.family.main
      font.pixelSize: Styles.font.pixelSize.smaller
      color: Styles._color.colSubtext
      elide: Text.ElideRight
      text: root.activeWindow?.activated ? root.activeWindow?.appId : "..."
    }

    StyledText {
      Layout.fillWidth: true
      font.family: Styles.font.family.main
      font.pixelSize: Styles.font.pixelSize.small
      color: Styles._color.colOnLayer0
      elide: Text.ElideRight
      text: root.activeWindow?.activated ? root.activeWindow?.title : (root.monitor?.activeWorkspace ? `Workspace ${root.monitor?.activeWorkspace.name}` : "Desktop")
    }
  }
}
