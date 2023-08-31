// message_input.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../generated/l10n.dart';
import '../../../models/chats.dart';
import '../screens/private_chat.dart';

class MessageInput extends StatefulWidget {
  final String currentUserId;
  final String otherPlayerId;

  MessageInput({required this.currentUserId, required this.otherPlayerId});

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _textController = TextEditingController();

  // Assuming you have the generateChatId function defined somewhere.

  void _sendMessage() async {
    final String content = _textController.text.trim();
    _textController.clear();

    if (content.isNotEmpty) {
      final chatId = generateChatId(widget.currentUserId, widget.otherPlayerId);
      final chatRef =
          FirebaseFirestore.instance.collection('chats').doc(chatId);

      // Check if the chat with the given chatId already exists
      final chatSnapshot = await chatRef.get();
      if (!chatSnapshot.exists) {
        final newMessage = ChatMessage(
          messageId: '',
          senderId: widget.currentUserId,
          receiverId: widget.otherPlayerId,
          content: content,
          timestamp: Timestamp.now(),
        );

        await chatRef.collection('messages').add(newMessage.toJson());

        // Update the chatIds list for both players
        await FirebaseFirestore.instance
            .collection('players')
            .doc(widget.currentUserId)
            .update({
          'chatIds': FieldValue.arrayUnion([chatId]),
        });

        await FirebaseFirestore.instance
            .collection('players')
            .doc(widget.otherPlayerId)
            .update({
          'chatIds': FieldValue.arrayUnion([chatId]),
        });
      } else {
        // Chat already exists, do something (e.g., display a message to the user).
        print('Chat already exists with ID: $chatId');
      }

      // Clear the text input field after sending the message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 0.05, color: Color(0xFF9A9A9A)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26313131),
                      blurRadius: 10,
                      offset: Offset(-5, 5),
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: S.of(context).enter_your_message,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00344E),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _sendMessage,
                icon: Icon(Icons.send),
                color: Colors.white,
                iconSize: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
