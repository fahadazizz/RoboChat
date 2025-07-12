import 'package:ai_buddy_chatbot/logic_bloc/API_services/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc(this.chatService) : super(const ChatInitial()) {
    on<SendUserMessage>(_onSendUserMessage);
    on<ReceiveAIResponse>(_onReceiveAIResponse);
    on<ChatErrorOccurred>(_onError);
  }

  Future<void> _onSendUserMessage(
    SendUserMessage event,
    Emitter<ChatState> emit,
  ) async {
    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: event.message, isUser: true));
    emit(ChatLoading(messages));

    try {
      final aiReply = await chatService.getAIResponse(event.message);
      add(ReceiveAIResponse(aiReply));
    } catch (e) {
      add(ChatErrorOccurred(e.toString()));
    }
  }

  void _onReceiveAIResponse(ReceiveAIResponse event, Emitter<ChatState> emit) {
    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: event.message, isUser: false));
    emit(ChatLoaded(messages));
  }

  void _onError(ChatErrorOccurred event, Emitter<ChatState> emit) {
    emit(ChatError(state.messages, event.error));
  }
}
