import 'package:equatable/equatable.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

abstract class ChatState extends Equatable {
  final List<ChatMessage> messages;
  const ChatState(this.messages);

  @override
  List<Object?> get props => [messages];
}

class ChatInitial extends ChatState {
  const ChatInitial() : super(const []);
}

class ChatLoading extends ChatState {
  const ChatLoading(List<ChatMessage> messages) : super(messages);
}

class ChatLoaded extends ChatState {
  const ChatLoaded(List<ChatMessage> messages) : super(messages);
}

class ChatError extends ChatState {
  final String error;
  const ChatError(List<ChatMessage> messages, this.error) : super(messages);

  @override
  List<Object?> get props => [messages, error];
}
