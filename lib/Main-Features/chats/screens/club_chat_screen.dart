import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../generated/l10n.dart';
import '../../../models/chats.dart';
import '../../../models/player.dart';
import '../widgets/community_message.dart';
import '../widgets/my_reply.dart';

class ClubChatScreen extends StatefulWidget {
  @override
  _ClubChatScreenState createState() => _ClubChatScreenState();
}

class _ClubChatScreenState extends State<ClubChatScreen> {
  Stream<List<ChatMessage>> _chatStream =
      Stream.value([]); // Initialize with an empty list
  final TextEditingController _messageController = TextEditingController();
  String currentUserID = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    // Fetch the chat messages stream based on the clubChatId
    CollectionReference playersCollection =
        FirebaseFirestore.instance.collection('players');
    playersCollection.doc(currentUserID).get().then((playerSnapshot) {
      String clubId = playerSnapshot['participatedClubId'] as String? ?? '';
      CollectionReference clubsCollection =
          FirebaseFirestore.instance.collection('clubs');
      clubsCollection.doc(clubId).get().then((clubSnapshot) {
        String clubChatId = clubSnapshot['clubChatId'] as String? ?? '';
        CollectionReference chatCollection =
            FirebaseFirestore.instance.collection('chats');
        _chatStream = chatCollection
            .doc(clubChatId)
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .map((querySnapshot) => querySnapshot.docs
                .map((doc) => ChatMessage.fromSnapshot(doc))
                .toList());
        setState(() {
          // Trigger a rebuild of the widget to display the fetched messages
        });
      });
    });
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
      body: SizedBox(
        child: StreamBuilder<List<ChatMessage>>(
          stream: _chatStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<ChatMessage> messages = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 70.0),
                physics: const BouncingScrollPhysics(),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final ChatMessage message = messages[index];
                  print(messages.length);
                  return FutureBuilder<Player?>(
                    future: _fetchPlayerData(message.senderId),
                    builder: (context, playerSnapshot) {
                      if (playerSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (playerSnapshot.hasData) {
                        final Player? player = playerSnapshot.data;
                        if (player != null) {
                          return message.senderId == currentUserID
                              ? MyReply(message: message)
                              : SenderMessage(
                                  message: message,
                                  player: player,
                                );
                        }
                      }
                      return Container();
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      bottomSheet: _buildMessageInput(),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              color: const Color(0xFF00344E),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              onPressed: _sendMessage,
              icon: const Icon(Icons.send),
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

      CollectionReference playersCollection =
          FirebaseFirestore.instance.collection('players');
      playersCollection.doc(currentUserID).get().then((playerSnapshot) {
        String clubId = playerSnapshot['participatedClubId'] as String? ?? '';
        if (clubId.isNotEmpty) {
          CollectionReference clubsCollection =
              FirebaseFirestore.instance.collection('clubs');
          clubsCollection.doc(clubId).get().then((clubSnapshot) {
            String clubChatId = clubSnapshot['clubChatId'] as String? ?? '';
            if (clubChatId.isNotEmpty) {
              CollectionReference chatCollection =
                  FirebaseFirestore.instance.collection('chats');
              chatCollection.doc(clubChatId).collection('messages').add({
                'senderId': currentUserID,
                'content': messageContent,
                'timestamp': FieldValue.serverTimestamp(),
              }).then((_) {
                // Message sent successfully, clear the text
              }).catchError((error) => print('Error sending message: $error'));
            } else {
              print('No clubChatId found for the current user\'s club.');
            }
          }).catchError((error) => print('Error fetching club data: $error'));
        } else {
          print('No clubId found for the current user.');
        }
      }).catchError((error) => print('Error fetching user data: $error'));
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
