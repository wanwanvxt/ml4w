import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.modules.common

MouseArea {
  id: root

  required property var window__
  required property SystemTrayItem trayItem
  acceptedButtons: Qt.LeftButton | Qt.RightButton
  Layout.fillHeight: true
  implicitWidth: Styles.font.pixelSize.large

  onClicked: event => {
    switch (event.button) {
    case Qt.LeftButton:
      console.log("left");
      trayItem.activate();
      break;
    case Qt.RightButton:
      console.log("right");
      if (trayItem.hasMenu)
        trayMenu.open();
      break;
    }
    event.accepted = true;
  }

  QsMenuAnchor {
    id: trayMenu

    menu: root.trayItem.menu
    anchor {
      window: root.window__
      rect.x: root.x + root.window__.width
      rect.y: root.y
      rect.height: root.height
      edges: Edges.Bottom
    }
  }

  IconImage {
    id: trayIcon

    source: root.trayItem.icon
    anchors.centerIn: parent
    width: parent.width
    height: parent.height
  }
}
