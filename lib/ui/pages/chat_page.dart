import 'package:ai_buddy_chatbot/logic_bloc/API_services/chat_service.dart';
import 'package:ai_buddy_chatbot/ui/pages/chat/chat_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic_bloc/chat/chat_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc(ChatService()),
      child: ChatView(),
    );
  }
}
