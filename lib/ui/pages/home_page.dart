import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_bloc.dart';
import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_event.dart';
import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_bloc.dart';
import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_state.dart';
import 'package:ai_buddy_chatbot/ui/pages/home/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceBloc, VoiceState>(
      listener: (context, state) {
        if (state is VoiceRecognized && state.isFinal) {
          context.read<ChatBloc>().add(SendUserMessage(state.recognizedText));
        }

        if (state is VoiceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("🎙️ Voice Error: ${state.error}")),
          );
        }
      },
      child: HomeContent(), // <— whatever your content is
    );
  }
}
