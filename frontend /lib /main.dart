import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For jsonDecode

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sehat | Your Health Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LLMChatPage(),
    );
  }
}

class LLMChatPage extends StatefulWidget {
  const LLMChatPage({super.key});

  @override
  State<LLMChatPage> createState() => _LLMChatPageState();
}

class _LLMChatPageState extends State<LLMChatPage> {
  final TextEditingController _controller = TextEditingController();
  String _responseText = "";
  bool _isLoading = false;

  Future<void> generateText(String prompt) async {
    const apiUrl = "http://127.0.0.1:8000/generate"; // For Android Emulator (use localhost for iOS simulator)
    
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": prompt, "max_length": 50}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _responseText = data["generated_text"];
        });
      } else {
        setState(() {
          _responseText = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _responseText = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talk to Your Health Assistant!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter a prompt'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                generateText(_controller.text);
              },
              child: const Text('Generate'),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : Text(_responseText),
          ],
        ),
      ),
    );
  }
}
