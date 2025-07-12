import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendUserMessage extends ChatEvent {
  final String message;
  SendUserMessage(this.message);

  @override
  List<Object?> get props => [message];
}

class ReceiveAIResponse extends ChatEvent {
  final String message;
  ReceiveAIResponse(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatErrorOccurred extends ChatEvent {
  final String error;
  ChatErrorOccurred(this.error);

  @override
  List<Object?> get props => [error];
}
