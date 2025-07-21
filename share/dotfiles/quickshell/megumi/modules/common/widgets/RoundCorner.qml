import QtQuick
import qs.modules.common

Item {
  id: root

  enum CornerEnum {
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight
  }

  property list<int> corners: [RoundCorner.CornerEnum.TopLeft]
  property int size: 10
  property color color: "#000000"

  onColorChanged: {
    canvas.requestPaint();
  }
  onCornersChanged: {
    canvas.requestPaint();
  }

  implicitWidth: size
  implicitHeight: size

  Canvas {
    id: canvas

    anchors.fill: parent
    antialiasing: true

    onPaint: {
      const ctx = getContext("2d");
      const w = canvas.width;
      const h = canvas.height;
      const r = root.size;
      const c = root.corners;

      ctx.clearRect(0, 0, w, h);
      ctx.beginPath();

      ctx.moveTo(c.includes(root.CornerEnum.TopLeft) ? r : 0, 0);

      ctx.lineTo(c.includes(root.CornerEnum.TopRight) ? w - r : w, 0);
      if (c.includes(root.CornerEnum.TopRight))
        ctx.quadraticCurveTo(w, 0, w, r);
      else
        ctx.lineTo(w, 0);

      ctx.lineTo(w, c.includes(root.CornerEnum.BottomRight) ? h - r : h);
      if (c.includes(root.CornerEnum.BottomRight))
        ctx.quadraticCurveTo(w, h, w - r, h);
      else
        ctx.lineTo(w, h);

      ctx.lineTo(c.includes(root.CornerEnum.BottomLeft) ? r : 0, h);
      if (c.includes(root.CornerEnum.BottomLeft))
        ctx.quadraticCurveTo(0, h, 0, h - r);
      else
        ctx.lineTo(0, h);

      ctx.lineTo(0, c.includes(root.CornerEnum.TopLeft) ? r : 0);
      if (c.includes(root.CornerEnum.TopLeft))
        ctx.quadraticCurveTo(0, 0, r, 0);
      else
        ctx.lineTo(0, 0);

      ctx.closePath();
      ctx.fillStyle = root.color;
      ctx.fill();
    }
  }

  Behavior on size {
    animation: Styles.animation.elementMoveFast.numberAnimation.createObject(this)
  }
}
