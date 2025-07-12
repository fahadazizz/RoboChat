import 'package:ai_buddy_chatbot/core/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final isDark = themeMode == ThemeMode.dark;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(
                leading: const Icon(Icons.brightness_6),
                title: const Text("Dark Mode"),
                trailing: Switch.adaptive(
                  value: isDark,
                  onChanged: (_) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text("Privacy Policy"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Privacy Policy"),
                      content: const Text("We do not collect personal data."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About"),
                subtitle: const Text("AI Buddy v1.0.0"),
              ),
            ],
          );
        },
      ),
    );
  }
}
