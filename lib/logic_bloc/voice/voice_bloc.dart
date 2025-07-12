import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'voice_event.dart';
import 'voice_state.dart';

class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  final SpeechToText _speech = SpeechToText();

  VoiceBloc() : super(VoiceInitial()) {
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<SpeechRecognized>(_onSpeechRecognized);
  }

  Future<void> _onStartListening(
    StartListening event,
    Emitter<VoiceState> emit,
  ) async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) {
          // ❌ Removed auto-stop from status
          print("🔊 Status changed: $status");
        },
        onError: (error) {
          emit(VoiceError("Speech error: ${error.errorMsg}"));
        },
      );

      if (!available) {
        emit(VoiceError("Speech recognition not available"));
        return;
      }

      emit(VoiceListening());

      await _speech.listen(
        onResult: (result) {
          print("🎙 Recognized: ${result.recognizedWords}");
          // ❌ Do NOT stop automatically
          add(
            SpeechRecognized(
              result.recognizedWords,
              isFinal: result.finalResult,
            ),
          );
        },
        localeId: 'en_US',
        listenMode: ListenMode.dictation, // ✅ Allows longer sessions
      );
    } catch (e) {
      emit(VoiceError("Error starting mic: $e"));
    }
  }

  Future<void> _onStopListening(
    StopListening event,
    Emitter<VoiceState> emit,
  ) async {
    try {
      await _speech.stop();
      emit(VoiceInitial());
    } catch (e) {
      emit(VoiceError("Error stopping mic: $e"));
    }
  }

  void _onSpeechRecognized(SpeechRecognized event, Emitter<VoiceState> emit) {
    emit(VoiceRecognized(event.recognizedText, isFinal: event.isFinal));
  }
}
