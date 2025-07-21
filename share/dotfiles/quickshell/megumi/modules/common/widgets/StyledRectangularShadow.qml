import QtQuick.Effects
import qs.modules.common

RectangularShadow {
  required property var target
  anchors.fill: target
  radius: target.radius
  blur: 6
  offset: Qt.vector2d(0.0, 1.0)
  spread: 4
  color: Styles._color.colShadow
  cached: true
}
