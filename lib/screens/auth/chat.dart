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
      _messages.add(ChatMessage(
        text: message,
        isUser: true,
      ));
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('https://anti.digicopy.me/chat/ai_response'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'query': message,
          'target_socket_id': 'your_socket_id_here'
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _messages.add(ChatMessage(
            text: data['message'] ?? 'No response received',
            isUser: false,
          ));
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(
            text: 'Error: Failed to get response',
            isUser: false,
          ));
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'Error: $e',
          isUser: false,
        ));
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
      appBar: AppBar(
        title: Text('Chat with Sundane'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: _messages.length,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return _buildMessageBubble(_messages[index]);
                  },
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              _buildMessageInput(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getTopContainer() {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: hexToColor("#C58346"))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TALKING TO SUNDANE".toUpperCase(),
            style: CustomTextStyle.text_600(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _getIndividualCard(String imageName, String name) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: hexToColor("#EBCCB9"),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Image.asset(
                  'assets/$imageName.png',
                  height: 80,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      name,
                      style: CustomTextStyle.text_600(fontSize: 18),
                    )),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          Icons.favorite,
                          color: hexToColor("#D6253F"),
                          size: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: CircleAvatar(
                        backgroundColor: hexToColor("#C58346"),
                        radius: 15,
                        child: Icon(
                          Icons.thumb_down_sharp,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButton(String label, Color bgColor, Color textColor,
      {bool fullWidth = false}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
        },
        child: Text(
          label,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                textInputAction: TextInputAction.send,
                onSubmitted: (text) => _sendMessage(text),
              ),
            ),
            SizedBox(width: 8),
            CircleAvatar(
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
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.black : Colors.grey[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black,
          ),
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
          style: TextStyle(fontSize: 9),
          maxLines: isExpanded ? null : 2,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        ),
        if (shouldTruncate) // Show 'Read more' only if truncation is needed
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? 'Read less' : 'Read more',
              style: const TextStyle(color: Colors.blue, fontSize: 9),
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
      ),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return RadialGradient(
            colors: [
              Colors.orange.withOpacity(0.7),
              Colors.transparent,
            ],
            center: Alignment.center,
            radius: 1.2,  
            stops: [0.6, 1.0], 
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcOver,
        child: const Icon(Icons.mic, color: Colors.white, size: 40),
      ),
    );
  }
}
