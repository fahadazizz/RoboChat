import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_bloc.dart';
import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_event.dart';
import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_state.dart';
import 'package:ai_buddy_chatbot/core/constant/app_assets.dart';
import 'package:ai_buddy_chatbot/core/constant/app_text_style.dart';
import 'package:ai_buddy_chatbot/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceBloc, VoiceState>(
      builder: (context, state) {
        final isListening = state is VoiceListening;
        final text = state is VoiceRecognized ? state.recognizedText : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text("RoboChat"),
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: const Icon(Icons.sunny),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ✅ Display recognized text above robot
                if (text != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      text,
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    final bloc = context.read<VoiceBloc>();
                    final currentState = bloc.state;

                    if (currentState is VoiceListening) {
                      bloc.add(StopListening());
                    } else {
                      bloc.add(StartListening());
                    }
                  },
                  child: Lottie.asset(
                    isListening
                        ? AppAssets.robotListening
                        : AppAssets.robotIdle,
                    height: 250,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  isListening ? "Listening..." : "Tap the Robot to Talk",
                  style: AppTextStyles.headline.copyWith(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
