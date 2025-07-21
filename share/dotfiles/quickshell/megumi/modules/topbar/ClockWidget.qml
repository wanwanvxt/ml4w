import QtQuick
import QtQuick.Layouts
import qs.modules.common
import qs.modules.common.widgets
import qs.services

Item {
  id: root

  implicitWidth: colLayout.implicitWidth
  implicitHeight: Styles.size.topbar.height

  ColumnLayout {
    id: colLayout

    anchors.centerIn: parent
    spacing: -4

    StyledText {
      font.pixelSize: Styles.font.pixelSize.small
      color: Styles._color.colOnLayer1
      text: TimeService.time
    }

    StyledText {
      font.pixelSize: Styles.font.pixelSize.small
      color: Styles._color.colOnLayer1
      text: TimeService.date
    }
  }
}
