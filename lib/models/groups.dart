import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChats {
  final String messageId;
  final String senderId;
  final String content;
  final Timestamp timestamp;
  final List<String> participatedUserIds;
  final String? photoURL;
  final String groupName; // New field for group name

  GroupChats({
    required this.messageId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.participatedUserIds,
    this.photoURL,
    required this.groupName, // Initialize the group name
  });

  // Convert message to JSON
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'senderId': senderId,
      'content': content,
      'groupImageURL': photoURL,
      'timestamp': timestamp,
      'participatedUserIds': participatedUserIds,
      'groupName': groupName, // Include group name in JSON
    };
  }

  // Factory method to create a message from Firestore snapshot
  factory GroupChats.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw ArgumentError("Invalid data for ChatMessage from DocumentSnapshot");
    }

    return GroupChats(
      messageId: snapshot.id,
      senderId: data['senderId'] as String? ?? '',
      content: data['content'] as String? ?? '',
      timestamp: data['timestamp'] as Timestamp? ?? Timestamp.now(),
      participatedUserIds: List<String>.from(data['participatedUserIds'] ?? []),
      photoURL: data['groupImageURL'] as String?,
      groupName: data['groupName'] as String? ?? '', // Get group name from data
    );
  }

  // Factory method to create a message from map (JSON) data
  factory GroupChats.fromMap(Map<String, dynamic> map) {
    return GroupChats(
      messageId: map['messageId'] as String? ?? '',
      senderId: map['senderId'] as String? ?? '',
      content: map['content'] as String? ?? '',
      timestamp: map['timestamp'] as Timestamp? ?? Timestamp.now(),
      participatedUserIds: List<String>.from(map['participatedUserIds'] ?? []),
      photoURL: map['groupImageURL'] as String?,
      groupName: map['groupName'] as String? ?? '', // Get group name from map
    );
  }
}
