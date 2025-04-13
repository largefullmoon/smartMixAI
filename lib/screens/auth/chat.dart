import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sample/common/widgets/appbar.dart';
import 'package:sample/screens/auths/register.dart';
import 'package:sample/styles.dart';
import 'package:sample/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: message, isUser: true));
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://anti.digicopy.me/chat/ai_response'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'query': message, 'target_socket_id': 'your_socket_id_here'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages.add(ChatMessage(
              text: data['message'] ?? 'No response received', isUser: false));
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(
              text: 'Error: Failed to get response', isUser: false));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(text: 'Error: $e', isUser: false));
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Chat with Sundane',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_messages[_messages.length - 1 - index]);
                  },
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.all(12),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              _buildMessageInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (text) => _sendMessage(text),
              ),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black,
              child: IconButton(
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: () => _sendMessage(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final alignment = message.isUser ? Alignment.centerRight : Alignment.centerLeft;
    final color = message.isUser ? Colors.black : Colors.white;
    final textColor = message.isUser ? Colors.white : Colors.black;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 0),
            bottomRight: Radius.circular(message.isUser ? 0 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Text(
          message.text,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLength;

  const ReadMoreText({super.key, required this.text, this.maxLength = 90});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    bool shouldTruncate = widget.text.length > widget.maxLength;
    String displayText = (shouldTruncate && !isExpanded)
        ? '${widget.text.substring(0, widget.maxLength)}...'
        : widget.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(fontSize: 12, color: Colors.black87),
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (shouldTruncate)
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                isExpanded ? 'Read less' : 'Read more',
                style: TextStyle(color: Colors.blueAccent, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

class MicButtonWithGlow extends StatelessWidget {
  const MicButtonWithGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown[700],
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Icon(Icons.mic, color: Colors.white, size: 40),
    );
  }
}
