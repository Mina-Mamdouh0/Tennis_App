import '../../../../models/club.dart';
import '../../../../models/player.dart';

abstract class ClubManagementState {}

class ClubManagementInitial extends ClubManagementState {}

class ClubManagementLoading extends ClubManagementState {}

class ClubManagementLoaded extends ClubManagementState {
  final Club club; // Add the club data
  final List<Player> members;

  ClubManagementLoaded({required this.club, required this.members});
}

class ClubManagementError extends ClubManagementState {
  final String errorMessage;

  ClubManagementError(this.errorMessage);
}
