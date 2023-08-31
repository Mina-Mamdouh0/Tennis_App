import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../generated/l10n.dart';
import '../../../models/chats.dart';
import '../../../models/player.dart';
import '../widgets/community_message.dart';
import '../widgets/my_reply.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _messageController = TextEditingController();
  Future<Player?> _fetchPlayerData(String playerId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
          await FirebaseFirestore.instance
              .collection('players')
              .doc(playerId)
              .get();
      if (playerSnapshot.exists) {
        return Player.fromSnapshot(playerSnapshot);
      }
      return null; // Return null if the player does not exist.
    } catch (error) {
      print('Error fetching player data: $error');
      return null;
    }
  }

  String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _buildChatMessages(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('global-chat')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<ChatMessage> messages = snapshot.data!.docs
              .map((doc) => ChatMessage.fromSnapshot(doc))
              .toList();
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final ChatMessage message = messages[index];

              // Fetch player data for the sender
              Future<Player?> playerFuture = _fetchPlayerData(message.senderId);

              return FutureBuilder<Player?>(
                future: playerFuture,
                builder: (context, playerSnapshot) {
                  if (playerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    // While player data is loading, show a loading indicator
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (playerSnapshot.hasData) {
                    final Player senderPlayer = playerSnapshot.data!;

                    return message.senderId == currentUserID
                        ? MyReply(message: message)
                        : SenderMessage(
                            message: message,
                            player: senderPlayer,
                          );
                  } else {
                    // Handle the case when player data is not available or an error occurs
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text('Sent by: ${message.senderId}'),
                      // Add more details or custom UI elements as needed
                    );
                  }
                },
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.05, color: Color(0xFF9A9A9A)),
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
                controller: _messageController,
                decoration:
                    InputDecoration(hintText: S.of(context).enter_your_message),
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
    );
  }

  void _sendMessage() {
    String messageContent = _messageController.text.trim();
    _messageController.clear();

    if (messageContent.isNotEmpty) {
      String currentUserID = FirebaseAuth.instance.currentUser!.uid;

      CollectionReference chatCollection =
          FirebaseFirestore.instance.collection('global-chat');
      chatCollection.add({
        'senderId': currentUserID,
        'content': messageContent,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((_) {
        // Message sent successfully, do any additional actions if needed
      }).catchError((error) => print('Error sending message: $error'));
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
