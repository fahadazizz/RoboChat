abstract class VoiceEvent {}

class StartListening extends VoiceEvent {}

class StopListening extends VoiceEvent {}

class SpeechRecognized extends VoiceEvent {
  final String recognizedText;
  final bool isFinal;

  SpeechRecognized(this.recognizedText, {this.isFinal = false});
}

class SpeechErrorOccurred extends VoiceEvent {
  final String message;

  SpeechErrorOccurred(this.message);
}
