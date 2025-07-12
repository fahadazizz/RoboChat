import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatService {
  final String apiKey = "";

  ChatService();

  Future<String> getAIResponse(String userMessage) async {
    final url = Uri.parse('https://openrouter.ai/api/v1/chat/completions');

    final body = {
      "model": "deepseek/deepseek-chat-v3-0324:free",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a friendly Robot AI assistant, \n You have two your things to remember. \n  1: Always answer in English \n 2 : is to reply like a real friend in good tone and humanlike manner. Answer shortly and concisely, do not write long answers. If you don't know the answer, say 'I don't know'.: $userMessage",
        },
      ],
    };

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['choices'][0]['message']['content'];
    } else {
      throw Exception('AI API Error: ${response.body}');
    }
  }
}
