import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:tennis_app/core/methodes/firebase_methodes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tennis_app/core/utils/widgets/text_field.dart';

import '../../../core/utils/widgets/pop_app_bar.dart';
import '../../../generated/l10n.dart';
import '../../../models/player.dart';
import '../../Featured/create_profile/widgets/profile_image.dart';
import '../widgets/group_player_card.dart';
import 'groups_screen.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  bool isLoading = false;

  List<String> selectedMemberIds = [];
  List<Player> members = [];
  String groupName = '';
  Uint8List? _selectedImageBytes;
  final TextEditingController groupNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchClubMembers();
  }

  void fetchClubMembers() async {
    Method method = Method();
    Player player = await method.getCurrentUser();
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('clubs')
        .doc(player.participatedClubId)
        .get();
    if (snapshot.exists) {
      List<String> memberIds = List<String>.from(snapshot.data()!['memberIds']);

      List<Player> fetchedMembers =
          await Future.wait(memberIds.map((memberId) async {
        DocumentSnapshot<Map<String, dynamic>> playerSnapshot =
            await FirebaseFirestore.instance
                .collection('players')
                .doc(memberId)
                .get();
        return Player.fromSnapshot(playerSnapshot);
      }));

      setState(() {
        members = fetchedMembers;
      });
    }
  }

  void _toggleMemberSelection(String memberId) {
    setState(() {
      if (selectedMemberIds.contains(memberId)) {
        selectedMemberIds.remove(memberId);
      } else {
        selectedMemberIds.add(memberId);
      }
    });
  }

  void _createGroupChat() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    if (selectedMemberIds.isNotEmpty) {
      Method method = Method();
      Player currentUser = await method.getCurrentUser();

      List<String> participantIds = List.from(selectedMemberIds);
      participantIds
          .add(currentUser.playerId); // Include current user in participants

      // Create a new group chat document in Firestore
      DocumentReference groupChatRef =
          await FirebaseFirestore.instance.collection('group_chats').add({
        'participants': participantIds,
        'createdBy': currentUser.playerId,
        'timestamp': FieldValue.serverTimestamp(),
        'groupName': groupNameController.text,
      });

      // Update all participated players with the new group ID
      for (String playerId in participantIds) {
        await FirebaseFirestore.instance
            .collection('players')
            .doc(playerId)
            .update({
          'groupIds': FieldValue.arrayUnion([groupChatRef.id]),
        });
      }
      if (_selectedImageBytes != null) {
        firebase_storage.Reference storageReference = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('group_chats')
            .child(groupChatRef.id)
            .child('group-image.jpg');

        firebase_storage.UploadTask uploadTask =
            storageReference.putData(_selectedImageBytes!);
        firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Update the group chat document with the image URL
        await groupChatRef.update({'groupImageURL': imageUrl});
      }

      setState(() {
        isLoading = false; // Hide loading indicator
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroupChatScreen(groupId: groupChatRef.id),
        ),
      );
    } else {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Form(
        key: formKey,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator()) // Show loading indicator
            : Column(
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
                    text: S.of(context).select_players,
                    suffixIconPath: '',
                  ),
                  ProfileImage(
                    onImageSelected: (File imageFile) {
                      _selectedImageBytes = imageFile.readAsBytesSync();
                    },
                  ),
                  SizedBox(height: screenHeight * .01),
                  Text(
                    S.of(context).set_group_image,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: screenHeight * .03),
                  InputTextWithHint(
                    hint: S.of(context).Type_club_name_here,
                    text: S.of(context).Club_Name,
                    controller: groupNameController,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        final member = members[index];
                        final isSelected =
                            selectedMemberIds.contains(member.playerId);

                        return ListTile(
                          subtitle: GroupPlayerCard(
                            player: member,
                          ),
                          leading: Checkbox(
                            activeColor: const Color.fromARGB(255, 34, 47, 53),
                            value: isSelected,
                            onChanged: (value) =>
                                _toggleMemberSelection(member.playerId),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 34, 47, 53),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _createGroupChat();
          }
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
