pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.modules.common.functions

Singleton {
  id: root

  // https://material-foundation.github.io/material-theme-builder/
  readonly property QtObject m3color: QtObject {
    property color m3_primary: "#94D5A8"
    property color m3_surfaceTint: "#94D5A8"
    property color m3_onPrimary: "#00391E"
    property color m3_primaryContainer: "#0E512F"
    property color m3_onPrimaryContainer: "#B0F1C3"
    property color m3_secondary: "#B6CCB9"
    property color m3_onSecondary: "#213527"
    property color m3_secondaryContainer: "#374B3D"
    property color m3_onSecondaryContainer: "#D1E8D5"
    property color m3_tertiary: "#A3CDDB"
    property color m3_onTertiary: "#023640"
    property color m3_tertiaryContainer: "#214C57"
    property color m3_onTertiaryContainer: "#BEEAF7"
    property color m3_error: "#FFB4AB"
    property color m3_onError: "#690005"
    property color m3_errorContainer: "#93000A"
    property color m3_onErrorContainer: "#FFDAD6"
    property color m3_background: "#0F1511"
    property color m3_onBackground: "#DFE4DD"
    property color m3_surface: "#0F1511"
    property color m3_onSurface: "#DFE4DD"
    property color m3_surfaceVariant: "#414942"
    property color m3_onSurfaceVariant: "#C0C9C0"
    property color m3_outline: "#8A938B"
    property color m3_outlineVariant: "#414942"
    property color m3_shadow: "#000000"
    property color m3_scrim: "#000000"
    property color m3_inverseSurface: "#DFE4DD"
    property color m3_inverseOnSurface: "#2C322D"
    property color m3_inversePrimary: "#2C6A45"
    property color m3_primaryFixed: "#B0F1C3"
    property color m3_onPrimaryFixed: "#00210F"
    property color m3_primaryFixedDim: "#94D5A8"
    property color m3_onPrimaryFixedVariant: "#0E512F"
    property color m3_secondaryFixed: "#D1E8D5"
    property color m3_onSecondaryFixed: "#0C1F13"
    property color m3_secondaryFixedDim: "#B6CCB9"
    property color m3_onSecondaryFixedVariant: "#374B3D"
    property color m3_tertiaryFixed: "#BEEAF7"
    property color m3_onTertiaryFixed: "#001F26"
    property color m3_tertiaryFixedDim: "#A3CDDB"
    property color m3_onTertiaryFixedVariant: "#214C57"
    property color m3_surfaceDim: "#0F1511"
    property color m3_surfaceBright: "#353B36"
    property color m3_surfaceContainerLowest: "#0A0F0C"
    property color m3_surfaceContainerLow: "#181D19"
    property color m3_surfaceContainer: "#1C211D"
    property color m3_surfaceContainerHigh: "#262B27"
    property color m3_surfaceContainerHighest: "#313631"
  }

  readonly property QtObject _color: QtObject {
    property real transparency: 0.05
    property real contentTransparency: 0.55

    property color colSubtext: m3color.m3_outline
    property color colLayer0: ColorUtils.mix(ColorUtils.transparentize(m3color.m3_background, transparency), m3color.m3_primary, 0.99)
    property color colOnLayer0: m3color.m3_onBackground
    property color colLayer0Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.9, contentTransparency))
    property color colLayer0Active: ColorUtils.transparentize(ColorUtils.mix(colLayer0, colOnLayer0, 0.8, contentTransparency))
    property color colLayer1: ColorUtils.transparentize(ColorUtils.mix(m3color.m3_surfaceContainerLow, m3color.m3_background, 0.8), contentTransparency)
    property color colOnLayer1: m3color.m3_onSurfaceVariant
    property color colOnLayer1Inactive: ColorUtils.mix(colOnLayer1, colLayer1, 0.45)
    property color colLayer2: ColorUtils.transparentize(ColorUtils.mix(m3color.m3_surfaceContainer, m3color.m3_surfaceContainerHigh, 0.1), contentTransparency)
    property color colOnLayer2: m3color.m3_onSurface
    property color colOnLayer2Disabled: ColorUtils.mix(colOnLayer2, m3color.m3_background, 0.4)
    property color colLayer3: ColorUtils.transparentize(ColorUtils.mix(m3color.m3_surfaceContainerHigh, m3color.m3_onSurface, 0.96), contentTransparency)
    property color colOnLayer3: m3color.m3_onSurface
    property color colLayer1Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.92), contentTransparency)
    property color colLayer1Active: ColorUtils.transparentize(ColorUtils.mix(colLayer1, colOnLayer1, 0.85), contentTransparency)
    property color colLayer2Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.90), contentTransparency)
    property color colLayer2Active: ColorUtils.transparentize(ColorUtils.mix(colLayer2, colOnLayer2, 0.80), contentTransparency)
    property color colLayer2Disabled: ColorUtils.transparentize(ColorUtils.mix(colLayer2, m3color.m3_background, 0.8), contentTransparency)
    property color colLayer3Hover: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.90), contentTransparency)
    property color colLayer3Active: ColorUtils.transparentize(ColorUtils.mix(colLayer3, colOnLayer3, 0.80), contentTransparency)
    property color colPrimary: m3color.m3_primary
    property color colOnPrimary: m3color.m3_onPrimary
    property color colPrimaryHover: ColorUtils.mix(colPrimary, colLayer1Hover, 0.87)
    property color colPrimaryActive: ColorUtils.mix(colPrimary, colLayer1Active, 0.7)
    property color colPrimaryContainer: m3color.m3_primaryContainer
    property color colPrimaryContainerHover: ColorUtils.mix(colPrimaryContainer, colLayer1Hover, 0.7)
    property color colPrimaryContainerActive: ColorUtils.mix(colPrimaryContainer, colLayer1Active, 0.6)
    property color colOnPrimaryContainer: m3color.m3_onPrimaryContainer
    property color colSecondary: m3color.m3_secondary
    property color colSecondaryHover: ColorUtils.mix(m3color.m3_secondary, colLayer1Hover, 0.85)
    property color colSecondaryActive: ColorUtils.mix(m3color.m3_secondary, colLayer1Active, 0.4)
    property color colSecondaryContainer: m3color.m3_secondaryContainer
    property color colSecondaryContainerHover: ColorUtils.mix(m3color.m3_secondaryContainer, m3color.m3_onSecondaryContainer, 0.90)
    property color colSecondaryContainerActive: ColorUtils.mix(m3color.m3_secondaryContainer, colLayer1Active, 0.54)
    property color colOnSecondaryContainer: m3color.m3_onSecondaryContainer
    property color colSurfaceContainerLow: ColorUtils.transparentize(m3color.m3_surfaceContainerLow, contentTransparency)
    property color colSurfaceContainer: ColorUtils.transparentize(m3color.m3_surfaceContainer, contentTransparency)
    property color colSurfaceContainerHigh: ColorUtils.transparentize(m3color.m3_surfaceContainerHigh, contentTransparency)
    property color colSurfaceContainerHighest: ColorUtils.transparentize(m3color.m3_surfaceContainerHighest, contentTransparency)
    property color colSurfaceContainerHighestHover: ColorUtils.mix(m3color.m3_surfaceContainerHighest, m3color.m3_onSurface, 0.95)
    property color colSurfaceContainerHighestActive: ColorUtils.mix(m3color.m3_surfaceContainerHighest, m3color.m3_onSurface, 0.85)
    property color colTooltip: m3color.m3_inverseSurface
    property color colOnTooltip: m3color.m3_inverseOnSurface
    property color colScrim: ColorUtils.transparentize(m3color.m3_scrim, 0.5)
    property color colShadow: ColorUtils.transparentize(m3color.m3_shadow, 0.7)
    property color colOutlineVariant: m3color.m3_outlineVariant
  }

  readonly property QtObject rounding: QtObject {
    property int full: 9999
    property int extraExtraLarge: 48
    property int extraLargeIncreased: 32
    property int extraLarge: 28
    property int largeIncreased: 20
    property int large: 16
    property int medium: 12
    property int small: 8
    property int extraSmall: 4
    property int none: 0
    property int windowRounding: medium
  }

  readonly property QtObject font: QtObject {
    property QtObject family: QtObject {
      property string main: "Noto Sans"
      property string monospace: "Maple Mono"
      property string iconNerd: "Maple Mono NF"
      property string iconMaterial: "Material Symbols Rounded"
    }

    property QtObject pixelSize: QtObject {
      property int smallest: 10
      property int smaller: 12
      property int small: 14
      property int normal: 16
      property int large: 18
      property int larger: 20
      property int huge: 24
      property int hugeass: 32
    }
  }

  readonly property QtObject size: QtObject {
    id: sizeObj

    property QtObject hyprland: QtObject {
      property int gapsOut: 8
    }

    property QtObject topbar: QtObject {
      property int height: 40
      property int margin: sizeObj.hyprland.gapsOut
      property int spacing: 8
      property int wrapperHeight: height + margin * 2
      property int exclusiveZone: wrapperHeight - margin

      property int windowTitleWidth: 360

      property QtObject workspace: QtObject {
        property int buttonWidth: 26
        property int activeMargin: 2
      }
    }
  }

  readonly property QtObject animationCurve: QtObject {
    property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.90, 1, 1] // Default, 350ms
    property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1.00, 1, 1] // Default, 500ms
    property list<real> expressiveSlowSpatial: [0.39, 1.29, 0.35, 0.98, 1, 1] // Default, 650ms
    property list<real> expressiveEffects: [0.34, 0.80, 0.34, 1.00, 1, 1] // Default, 200ms
    property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
    property list<real> emphasizedFirstHalf: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82]
    property list<real> emphasizedLastHalf: [5 / 24, 0.82, 0.25, 1, 1, 1]
    property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
    property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
    property list<real> standard: [0.2, 0, 0, 1, 1, 1]
    property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
    property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
    property int expressiveFastSpatial_Duration: 350
    property int expressiveDefaultSpatial_Duration: 500
    property int expressiveSlowSpatial_Duration: 650
    property int expressiveEffects_Duration: 200
  }

  readonly property QtObject animation: QtObject {
    property QtObject elementMove: QtObject {
      property int duration: root.animationCurve.expressiveDefaultSpatial_Duration
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.expressiveDefaultSpatial
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMove.duration
          easing.type: root.animation.elementMove.type
          easing.bezierCurve: root.animation.elementMove.bezierCurve
        }
      }
      property Component colorAnimation: Component {
        ColorAnimation {
          duration: root.animation.elementMove.duration
          easing.type: root.animation.elementMove.type
          easing.bezierCurve: root.animation.elementMove.bezierCurve
        }
      }
    }
    property QtObject elementMoveEnter: QtObject {
      property int duration: 400
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.emphasizedDecel
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMoveEnter.duration
          easing.type: root.animation.elementMoveEnter.type
          easing.bezierCurve: root.animation.elementMoveEnter.bezierCurve
        }
      }
    }
    property QtObject elementMoveExit: QtObject {
      property int duration: 200
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.emphasizedAccel
      property int velocity: 650
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMoveExit.duration
          easing.type: root.animation.elementMoveExit.type
          easing.bezierCurve: root.animation.elementMoveExit.bezierCurve
        }
      }
    }
    property QtObject elementMoveFast: QtObject {
      property int duration: root.animationCurve.expressiveEffects_Duration
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.expressiveEffects
      property int velocity: 850
      property Component colorAnimation: Component {
        ColorAnimation {
          duration: root.animation.elementMoveFast.duration
          easing.type: root.animation.elementMoveFast.type
          easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
        }
      }
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.elementMoveFast.duration
          easing.type: root.animation.elementMoveFast.type
          easing.bezierCurve: root.animation.elementMoveFast.bezierCurve
        }
      }
    }

    property QtObject clickBounce: QtObject {
      property int duration: 200
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.expressiveFastSpatial
      property int velocity: 850
      property Component numberAnimation: Component {
        NumberAnimation {
          duration: root.animation.clickBounce.duration
          easing.type: root.animation.clickBounce.type
          easing.bezierCurve: root.animation.clickBounce.bezierCurve
        }
      }
    }
    property QtObject scroll: QtObject {
      property int duration: 400
      property int type: Easing.BezierSpline
      property list<real> bezierCurve: root.animationCurve.standardDecel
    }
    property QtObject menuDecel: QtObject {
      property int duration: 350
      property int type: Easing.OutExpo
    }
  }
}
