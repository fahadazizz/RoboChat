import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_bloc.dart';
import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_event.dart';
import 'package:ai_buddy_chatbot/logic_bloc/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final msg = _controller.text.trim();
    if (msg.isNotEmpty) {
      context.read<ChatBloc>().add(SendUserMessage(msg));
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Widget _buildMessageBubble(String text, bool isUser, {bool animate = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? Theme.of(context).colorScheme.primary.withOpacity(0.85)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: animate
            ? AnimatedTextKit(
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    text,
                    speed: const Duration(milliseconds: 30),
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isUser ? Colors.white : Colors.black87,
                ),
              ),
      ),
    );
  }

  Widget _buildTypingDots() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(),
            const SizedBox(width: 4),
            _dot(delay: 100),
            const SizedBox(width: 4),
            _dot(delay: 200),
          ],
        ),
      ),
    );
  }

  Widget _dot({int delay = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 8.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(offset: Offset(0, -value), child: child);
      },
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
      onEnd: () {
        setState(() {}); // loop animation
      },
    );
  }

  Widget _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          "❌ Error: $message",
          style: TextStyle(color: Colors.red.shade600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat with AI")),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                final messages = state.messages;

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length + (state is ChatLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length && state is ChatLoading) {
                      return _buildTypingDots();
                    }

                    final msg = messages[index];
                    final isLast = index == messages.length - 1;
                    final shouldAnimate =
                        isLast && !msg.isUser && state is ChatLoaded;

                    return _buildMessageBubble(
                      msg.text,
                      msg.isUser,
                      animate: shouldAnimate,
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatError) {
                return _buildError(state.error);
              }
              return const SizedBox.shrink();
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
