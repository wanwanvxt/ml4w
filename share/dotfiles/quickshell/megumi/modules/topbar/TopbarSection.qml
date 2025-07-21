import QtQuick
import QtQuick.Layouts
import qs.modules.common

Item {
  id: root

  implicitWidth: rowLayout.implicitWidth + Styles.size.topbar.spacing * 2
  implicitHeight: Styles.size.topbar.height
  default property alias items: rowLayout.children

  RowLayout {
    id: rowLayout

    anchors {
      verticalCenter: parent.verticalCenter
      left: parent.left
      right: parent.right
      leftMargin: Styles.size.topbar.spacing
      rightMargin: Styles.size.topbar.spacing
    }
    spacing: Styles.size.topbar.spacing
  }
}
