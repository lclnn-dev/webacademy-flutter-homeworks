import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat-bot',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> _messages = [];

  Future<String> simulateChatResponse(String userText) async {
    final lowerMsg = userText.toLowerCase();

    if (lowerMsg.contains('яка погода')) {
      await Future.delayed(const Duration(seconds: 5));
      final randomTemp = Random().nextInt(25) - 5;
      return 'Зараз температура: $randomTemp';
    }

    final delay = 2 + Random().nextInt(3); // 2-4 сек
    await Future.delayed(Duration(seconds: delay));

    if (lowerMsg.contains('погано')) {
      throw Exception('Щось пішло не так! Спробуйте ще раз.');
    }

    if (lowerMsg.contains('добре')) {
      return 'Я радий, що вам подобається!';
    }

    return 'Хм...';
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userText = _controller.text.trim();
    _controller.clear();

    setState(() {
      _messages.add(_ChatMessage(text: userText, isUser: true));
    });

    try {
      final response = await simulateChatResponse(userText);

      setState(() {
        _messages.add(_ChatMessage(text: response, isUser: false));
      });
    } catch (e) {
      final String errorMsg = e.toString().replaceFirst('Exception: ', '',);
      setState(() {
        _messages.add(_ChatMessage(text: errorMsg, isUser: false, isError: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat-bot'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final _ChatMessage msg = _messages[index];

                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: msg.isError
                              ? Row(mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.error_outline),
                                    Text(msg.text)
                                  ],
                                )
                              : Text(msg.text)),
                    );
                  })),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Напишіть питтання...',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  final bool isError;

  _ChatMessage({
    required this.text,
    required this.isUser,
    this.isError = false,
  });
}
