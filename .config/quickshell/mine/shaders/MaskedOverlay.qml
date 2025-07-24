import QtQuick

ShaderEffect {
  property Item overlayItem
  property point overlayPos: Qt.point(overlayItem.x, overlayItem.y)
  property real pMergeCutoff: 0.15
  property point pMergeInset: Qt.point(3 / width, 3 / height)
  property point pOverlayPos: Qt.point(overlayPos.x / width, overlayPos.y / height)
  property point pOverlaySize: Qt.point(overlayItem.width / width, overlayItem.height / height)

  fragmentShader: Qt.resolvedUrl("masked_overlay.frag.qsb")
}
