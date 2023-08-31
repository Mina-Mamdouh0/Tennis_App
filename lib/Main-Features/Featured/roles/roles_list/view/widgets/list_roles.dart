import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../models/club.dart';
import '../../../../../../models/player.dart';
import '../../../../../../models/roles.dart';
import '../../service/firebase_methods.dart';
import 'build_list_view.dart';

class ListRoles extends StatelessWidget {
  const ListRoles({super.key});

  @override
  Widget build(BuildContext context) {
    String currentUserID = FirebaseAuth.instance.currentUser!.uid;
    return FutureBuilder<Player>(
      future: getPlayerData(currentUserID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Expanded(
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return Text(S.of(context).No_data_found);
        }
        final player = snapshot.data!;
        return FutureBuilder<Club>(
          future: getClubData(player.participatedClubId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Expanded(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError) {
              return Expanded(
                  child: Center(
                      child:
                          Text('${S.of(context).error}: ${snapshot.error}')));
            }
            if (!snapshot.hasData) {
              return Expanded(
                  child: Center(child: Text(S.of(context).No_data_found)));
            }
            final club = snapshot.data!;
            return FutureBuilder<List<Role>>(
              future: getRoles(club.roleIds),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                if (snapshot.hasError) {
                  return Expanded(
                      child: Center(
                          child: Text(
                              '${S.of(context).error}: ${snapshot.error}')));
                }
                if (!snapshot.hasData) {
                  return Expanded(
                      child: Center(child: Text(S.of(context).No_data_found)));
                }
                final roles = snapshot.data!;
                return buildListView(roles);
              },
            );
          },
        );
      },
    );
  }
}
