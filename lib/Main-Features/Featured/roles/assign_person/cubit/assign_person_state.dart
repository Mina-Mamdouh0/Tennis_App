// States
abstract class AssignPersonState {}

class AssignPersonInitial extends AssignPersonState {}

class AssignPersonLoading extends AssignPersonState {}

class AssignPersonError extends AssignPersonState {
  final String message;

  AssignPersonError(this.message);
}

class AssignPersonSuccess extends AssignPersonState {
  final String message;

  AssignPersonSuccess(this.message);
}

class AssignPersonFetchedRoleNames extends AssignPersonState {
  final List<String> roleNames;

  AssignPersonFetchedRoleNames(this.roleNames);
}

class AssignPersonSelectedRoles extends AssignPersonState {
  final List<String> selectedRoles;

  AssignPersonSelectedRoles(this.selectedRoles);
}
