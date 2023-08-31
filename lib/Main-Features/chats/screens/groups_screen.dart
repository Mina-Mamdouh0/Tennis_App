import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/Main-Features/chats/widgets/community_message.dart';
import 'package:tennis_app/Main-Features/chats/widgets/my_reply.dart';
import 'package:tennis_app/core/utils/widgets/pop_app_bar.dart';
import 'package:tennis_app/models/chats.dart';
import 'package:tennis_app/models/player.dart'; // Import the ChatMessage model

class GroupChatScreen extends StatefulWidget {
  const GroupChatScreen({Key? key, required this.groupId}) : super(key: key);
  final String groupId;

  @override
  State<GroupChatScreen> createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  String _groupName = ''; // Store group name
  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchGroupDetails(); // Fetch group details when the screen initializes
  }

  void _fetchGroupDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> groupSnapshot =
          await FirebaseFirestore.instance
              .collection('group_chats')
              .doc(widget.groupId)
              .get();

      if (groupSnapshot.exists) {
        setState(() {
          _groupName = groupSnapshot.data()!['groupName'];
        });
      }
    } catch (error) {
      print('Error fetching group details: $error');
    }
  }

  void _sendMessage() async {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('group_chats')
            .doc(widget.groupId)
            .collection('messages')
            .add({
          'content': message, // Use 'content' instead of 'text'
          'senderId': user.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });

        _messageController.clear();
      }
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PoPAppBarWave(
            prefixIcon: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
            text: _groupName,
            suffixIconPath: '',
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('group_chats')
                  .doc(widget.groupId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    ChatMessage chatMessage = ChatMessage.fromSnapshot(
                        messages[index]
                            as DocumentSnapshot<Map<String, dynamic>>);

                    return FutureBuilder<Player?>(
                      future: _fetchPlayerData(chatMessage.senderId),
                      builder: (context, playerSnapshot) {
                        if (playerSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (playerSnapshot.hasData) {
                          final Player? player = playerSnapshot.data;
                          if (player != null) {
                            return chatMessage.senderId == player.playerId
                                ? MyReply(message: chatMessage)
                                : SenderMessage(
                                    message: chatMessage,
                                    player: player,
                                  );
                          }
                        }
                        return Container();
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration:
                        InputDecoration(hintText: 'Type your message...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
