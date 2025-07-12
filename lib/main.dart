import 'package:ai_buddy_chatbot/core/theme/theme_cubit.dart';
import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_bloc.dart';
import 'package:ai_buddy_chatbot/logic_bloc/API_services/chat_service.dart';
import 'package:ai_buddy_chatbot/logic_bloc/voice/voice_bloc.dart';
import 'package:ai_buddy_chatbot/ui/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider(create: (_) => ThemeCubit(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<VoiceBloc>(create: (context) => VoiceBloc()),
        BlocProvider<ChatBloc>(create: (context) => ChatBloc(ChatService())),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            themeMode: themeMode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: const MainPage(),
          );
        },
      ),
    );
  }
}
