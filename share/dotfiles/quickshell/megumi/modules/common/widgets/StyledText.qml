import QtQuick
import qs.modules.common

Text {
  renderType: Text.NativeRendering
  verticalAlignment: Text.AlignVCenter
  font {
    hintingPreference: Font.PreferFullHinting
    family: Styles.font.family.main
    pixelSize: Styles.font.pixelSize.small
  }
  color: Styles.m3color.m3_onBackground
  linkColor: Styles.m3color.m3_primary
}
