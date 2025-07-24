pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
  id: root
  readonly property PwNode sink: Pipewire.defaultAudioSink
  readonly property PwNode source: Pipewire.defaultAudioSource
  readonly property var volume: sink?.audio.volume
  readonly property var muted: sink?.audio.muted

  readonly property var micMuted: source?.audio.muted
  readonly property var micVolume: source?.audio.volume
  readonly property string micIcon: (this.micMuted)? "󰍭" : "󰍬"
  readonly property string volIcon: { 
    (muted)? "󰝟" :
    (volume > 0.5)? "󰕾" :
    (volume > 0.01)? "󰖀" : "󰕿"
  }
  PwObjectTracker { objects: [ root.sink, root.source ] }

  function wheelAction(event: WheelEvent) {
     root.sink.audio.volume = Math.min(Math.max((root.volume + Math.sign(event.angleDelta.y) * 0.01), 0.0), 1.3)
  }

  function micWheelAction(event: WheelEvent) {
     root.source.audio.volume = Math.min(Math.max((root.micVolume + Math.sign(event.angleDelta.y) * 0.01), 0.0), 1.3)
  }
}
