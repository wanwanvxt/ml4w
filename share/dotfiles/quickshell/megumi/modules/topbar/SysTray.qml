import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.modules.common
import qs.modules.common.widgets

Item {
  id: root

  required property var window_
  implicitWidth: rowLayout.implicitWidth
  implicitHeight: Styles.size.topbar.height

  RowLayout {
    id: rowLayout

    anchors.fill: parent
    spacing: Styles.size.topbar.spacing

    Repeater {
      model: SystemTray.items

      SysTrayItem {
        required property SystemTrayItem modelData
        window__: root.window_
        trayItem: modelData
      }
    }
  }
}
