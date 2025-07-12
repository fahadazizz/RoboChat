abstract class VoiceState {}

class VoiceInitial extends VoiceState {}

class VoiceListening extends VoiceState {}

class VoiceRecognized extends VoiceState {
  final String recognizedText;
  final bool isFinal;

  VoiceRecognized(this.recognizedText, {this.isFinal = false});
}

class VoiceError extends VoiceState {
  final String error;

  VoiceError(this.error);
}
