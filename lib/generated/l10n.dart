// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `You have been invited to join\nthis club through an\ninvitation link.`
  String get invitationText {
    return Intl.message(
      'You have been invited to join\nthis club through an\ninvitation link.',
      name: 'invitationText',
      desc: '',
      args: [],
    );
  }

  /// `Join Club`
  String get joinClub {
    return Intl.message(
      'Join Club',
      name: 'joinClub',
      desc: '',
      args: [],
    );
  }

  /// `Total Members`
  String get totalMembers {
    return Intl.message(
      'Total Members',
      name: 'totalMembers',
      desc: '',
      args: [],
    );
  }

  /// `Match Played`
  String get matchPlayed {
    return Intl.message(
      'Match Played',
      name: 'matchPlayed',
      desc: '',
      args: [],
    );
  }

  /// `Total Wins`
  String get totalWins {
    return Intl.message(
      'Total Wins',
      name: 'totalWins',
      desc: '',
      args: [],
    );
  }

  /// `Courts own`
  String get courtsOwn {
    return Intl.message(
      'Courts own',
      name: 'courtsOwn',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Create\nYour Profile`
  String get createProfile {
    return Intl.message(
      'Create\nYour Profile',
      name: 'createProfile',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Singles`
  String get singles {
    return Intl.message(
      'Singles',
      name: 'singles',
      desc: '',
      args: [],
    );
  }

  /// `Doubles`
  String get doubles {
    return Intl.message(
      'Doubles',
      name: 'doubles',
      desc: '',
      args: [],
    );
  }

  /// `Set Profile Picture`
  String get setProfilePicture {
    return Intl.message(
      'Set Profile Picture',
      name: 'setProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Type your name here`
  String get typeYourName {
    return Intl.message(
      'Type your name here',
      name: 'typeYourName',
      desc: '',
      args: [],
    );
  }

  /// `Player Name`
  String get playerName {
    return Intl.message(
      'Player Name',
      name: 'playerName',
      desc: '',
      args: [],
    );
  }

  /// `Type your phone number here`
  String get typeYourPhoneNumber {
    return Intl.message(
      'Type your phone number here',
      name: 'typeYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Type your age here`
  String get typeYourAge {
    return Intl.message(
      'Type your age here',
      name: 'typeYourAge',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `Type your Preferred Playing time here`
  String get typeYourPreferredPlayingTime {
    return Intl.message(
      'Type your Preferred Playing time here',
      name: 'typeYourPreferredPlayingTime',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Playing time`
  String get preferredPlayingTime {
    return Intl.message(
      'Preferred Playing time',
      name: 'preferredPlayingTime',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to your profile`
  String get sign_in_to_profile {
    return Intl.message(
      'Sign in to your profile',
      name: 'sign_in_to_profile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgot_password {
    return Intl.message(
      'Forgot your password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your\npassword?`
  String get forgot_password_header {
    return Intl.message(
      'Forgot your\npassword?',
      name: 'forgot_password_header',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get sign_in {
    return Intl.message(
      'SIGN IN',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Create your Basic Profile`
  String get create_basic_profile {
    return Intl.message(
      'Create your Basic Profile',
      name: 'create_basic_profile',
      desc: '',
      args: [],
    );
  }

  /// `SIGN UP`
  String get sign_up {
    return Intl.message(
      'SIGN UP',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enter_email {
    return Intl.message(
      'Enter Your Email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `The password provided is too weak.`
  String get weak_password {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get account_already_exists {
    return Intl.message(
      'The account already exists for that email.',
      name: 'account_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `Email verification sent!`
  String get email_verification_sent {
    return Intl.message(
      'Email verification sent!',
      name: 'email_verification_sent',
      desc: '',
      args: [],
    );
  }

  /// `Google Sign-In: No user selected`
  String get google_signin_no_user {
    return Intl.message(
      'Google Sign-In: No user selected',
      name: 'google_signin_no_user',
      desc: '',
      args: [],
    );
  }

  /// `Google Sign-In: Failed to authenticate user`
  String get google_signin_failed {
    return Intl.message(
      'Google Sign-In: Failed to authenticate user',
      name: 'google_signin_failed',
      desc: '',
      args: [],
    );
  }

  /// `Google Sign-In: Unexpected error occurred`
  String get google_signin_unexpected_error {
    return Intl.message(
      'Google Sign-In: Unexpected error occurred',
      name: 'google_signin_unexpected_error',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent`
  String get password_reset_email_sent {
    return Intl.message(
      'Password reset email sent',
      name: 'password_reset_email_sent',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send password reset email`
  String get failed_send_password_reset_email {
    return Intl.message(
      'Failed to send password reset email',
      name: 'failed_send_password_reset_email',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Create Your Profile`
  String get onboarding_header1 {
    return Intl.message(
      'Create Your Profile',
      name: 'onboarding_header1',
      desc: '',
      args: [],
    );
  }

  /// `Court Booking`
  String get onboarding_header2 {
    return Intl.message(
      'Court Booking',
      name: 'onboarding_header2',
      desc: '',
      args: [],
    );
  }

  /// `Match Making`
  String get onboarding_header3 {
    return Intl.message(
      'Match Making',
      name: 'onboarding_header3',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get onboarding_header4 {
    return Intl.message(
      'Notifications',
      name: 'onboarding_header4',
      desc: '',
      args: [],
    );
  }

  /// `Each club member can create an\nindividual profile and include\ninformation about their strength \n and playing type.`
  String get onboarding_detail1 {
    return Intl.message(
      'Each club member can create an\nindividual profile and include\ninformation about their strength \n and playing type.',
      name: 'onboarding_detail1',
      desc: '',
      args: [],
    );
  }

  /// `This feature allows club members to\nreserve tennis courts. They can\nview free times and make \nbookings easily.`
  String get onboarding_detail2 {
    return Intl.message(
      'This feature allows club members to\nreserve tennis courts. They can\nview free times and make \nbookings easily.',
      name: 'onboarding_detail2',
      desc: '',
      args: [],
    );
  }

  /// `You can find players who are interested\nin playing at a specific time or\nhave a similar skill level\n as you.`
  String get onboarding_detail3 {
    return Intl.message(
      'You can find players who are interested\nin playing at a specific time or\nhave a similar skill level\n as you.',
      name: 'onboarding_detail3',
      desc: '',
      args: [],
    );
  }

  /// `You can access information regarding\nupcoming tournaments, events,\ngame updates, or important\nclub announcements.`
  String get onboarding_detail4 {
    return Intl.message(
      'You can access information regarding\nupcoming tournaments, events,\ngame updates, or important\nclub announcements.',
      name: 'onboarding_detail4',
      desc: '',
      args: [],
    );
  }

  /// `No chats found.`
  String get no_chats_found {
    return Intl.message(
      'No chats found.',
      name: 'no_chats_found',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Receiver player data not found.`
  String get receiver_data_not_found {
    return Intl.message(
      'Receiver player data not found.',
      name: 'receiver_data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Players Search`
  String get players_search {
    return Intl.message(
      'Players Search',
      name: 'players_search',
      desc: '',
      args: [],
    );
  }

  /// `Search players...`
  String get search_players {
    return Intl.message(
      'Search players...',
      name: 'search_players',
      desc: '',
      args: [],
    );
  }

  /// `No players found`
  String get no_players_found {
    return Intl.message(
      'No players found',
      name: 'no_players_found',
      desc: '',
      args: [],
    );
  }

  /// `No matching players found`
  String get no_matching_players_found {
    return Intl.message(
      'No matching players found',
      name: 'no_matching_players_found',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get min {
    return Intl.message(
      'min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Type your message...`
  String get enter_your_message {
    return Intl.message(
      'Type your message...',
      name: 'enter_your_message',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Community`
  String get community {
    return Intl.message(
      'Community',
      name: 'community',
      desc: '',
      args: [],
    );
  }

  /// `Club`
  String get club {
    return Intl.message(
      'Club',
      name: 'club',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Set Reminder`
  String get set_reminder {
    return Intl.message(
      'Set Reminder',
      name: 'set_reminder',
      desc: '',
      args: [],
    );
  }

  /// `At`
  String get at {
    return Intl.message(
      'At',
      name: 'at',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Sunny`
  String get sunny {
    return Intl.message(
      'Sunny',
      name: 'sunny',
      desc: '',
      args: [],
    );
  }

  /// `Total Members`
  String get total_members {
    return Intl.message(
      'Total Members',
      name: 'total_members',
      desc: '',
      args: [],
    );
  }

  /// `Your Club`
  String get your_club {
    return Intl.message(
      'Your Club',
      name: 'your_club',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching club data.`
  String get error_fetching_club_data {
    return Intl.message(
      'Error fetching club data.',
      name: 'error_fetching_club_data',
      desc: '',
      args: [],
    );
  }

  /// `Club’s Upcoming events`
  String get clubs_upcoming_events {
    return Intl.message(
      'Club’s Upcoming events',
      name: 'clubs_upcoming_events',
      desc: '',
      args: [],
    );
  }

  /// `Club’s Players Ranking`
  String get clubs_players_ranking {
    return Intl.message(
      'Club’s Players Ranking',
      name: 'clubs_players_ranking',
      desc: '',
      args: [],
    );
  }

  /// `Available Courts`
  String get available_courts {
    return Intl.message(
      'Available Courts',
      name: 'available_courts',
      desc: '',
      args: [],
    );
  }

  /// `Announcements`
  String get announcements {
    return Intl.message(
      'Announcements',
      name: 'announcements',
      desc: '',
      args: [],
    );
  }

  /// `Create Event`
  String get create_event {
    return Intl.message(
      'Create Event',
      name: 'create_event',
      desc: '',
      args: [],
    );
  }

  /// `Find Partner`
  String get find_partner {
    return Intl.message(
      'Find Partner',
      name: 'find_partner',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `You have been invited to join\nthis club through an\ninvitation link.`
  String get invitation_text {
    return Intl.message(
      'You have been invited to join\nthis club through an\ninvitation link.',
      name: 'invitation_text',
      desc: '',
      args: [],
    );
  }

  /// `No player data available`
  String get No_player_data_available {
    return Intl.message(
      'No player data available',
      name: 'No_player_data_available',
      desc: '',
      args: [],
    );
  }

  /// `Player data not found`
  String get Player_data_not_found {
    return Intl.message(
      'Player data not found',
      name: 'Player_data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `No club invitations found`
  String get No_club_invitations_found {
    return Intl.message(
      'No club invitations found',
      name: 'No_club_invitations_found',
      desc: '',
      args: [],
    );
  }

  /// `Player removed from the club`
  String get Player_removed_from_the_club {
    return Intl.message(
      'Player removed from the club',
      name: 'Player_removed_from_the_club',
      desc: '',
      args: [],
    );
  }

  /// `Player is not a member of the club`
  String get Player_is_not_a_member_of_the_club {
    return Intl.message(
      'Player is not a member of the club',
      name: 'Player_is_not_a_member_of_the_club',
      desc: '',
      args: [],
    );
  }

  /// `Club data not found`
  String get Club_data_not_found {
    return Intl.message(
      'Club data not found',
      name: 'Club_data_not_found',
      desc: '',
      args: [],
    );
  }

  /// `User not logged in`
  String get User_not_logged_in {
    return Intl.message(
      'User not logged in',
      name: 'User_not_logged_in',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Error_removing_player_from_club._Please_try_again_later.' key

  /// `Please enter the member name`
  String get Please_enter_the_member_name {
    return Intl.message(
      'Please enter the member name',
      name: 'Please_enter_the_member_name',
      desc: '',
      args: [],
    );
  }

  /// `Player not found with the given name`
  String get Player_not_found_with_the_given_name {
    return Intl.message(
      'Player not found with the given name',
      name: 'Player_not_found_with_the_given_name',
      desc: '',
      args: [],
    );
  }

  /// `Roles assigned successfully`
  String get Roles_assigned_successfully {
    return Intl.message(
      'Roles assigned successfully',
      name: 'Roles_assigned_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error assigning roles. Please try again later.`
  String get Error_assigning_roles_Please_try_again_later {
    return Intl.message(
      'Error assigning roles. Please try again later.',
      name: 'Error_assigning_roles_Please_try_again_later',
      desc: '',
      args: [],
    );
  }

  /// `Management`
  String get Management {
    return Intl.message(
      'Management',
      name: 'Management',
      desc: '',
      args: [],
    );
  }

  /// `Skill level`
  String get Skill_level {
    return Intl.message(
      'Skill level',
      name: 'Skill_level',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get Membership {
    return Intl.message(
      'Membership',
      name: 'Membership',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get Clear {
    return Intl.message(
      'Clear',
      name: 'Clear',
      desc: '',
      args: [],
    );
  }

  /// `Player type`
  String get Player_type {
    return Intl.message(
      'Player type',
      name: 'Player_type',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get Role {
    return Intl.message(
      'Role',
      name: 'Role',
      desc: '',
      args: [],
    );
  }

  /// `Instructions`
  String get Instructions {
    return Intl.message(
      'Instructions',
      name: 'Instructions',
      desc: '',
      args: [],
    );
  }

  /// `Remove Member?`
  String get Remove_Member {
    return Intl.message(
      'Remove Member?',
      name: 'Remove_Member',
      desc: '',
      args: [],
    );
  }

  /// `Send Invitations`
  String get Send_Invitations {
    return Intl.message(
      'Send Invitations',
      name: 'Send_Invitations',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any members.`
  String get You_dont_have_any_members {
    return Intl.message(
      'You don\'t have any members.',
      name: 'You_dont_have_any_members',
      desc: '',
      args: [],
    );
  }

  /// `No Role Assigned`
  String get No_Role_Assigned {
    return Intl.message(
      'No Role Assigned',
      name: 'No_Role_Assigned',
      desc: '',
      args: [],
    );
  }

  /// `Assign Role`
  String get Assign_Role {
    return Intl.message(
      'Assign Role',
      name: 'Assign_Role',
      desc: '',
      args: [],
    );
  }

  /// `Assign Player Skill Level`
  String get Assign_Player_Skill_Level {
    return Intl.message(
      'Assign Player Skill Level',
      name: 'Assign_Player_Skill_Level',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Remove_Member?' key

  /// `Update Player`
  String get Update_Player {
    return Intl.message(
      'Update Player',
      name: 'Update_Player',
      desc: '',
      args: [],
    );
  }

  /// `Matched Played `
  String get Matched_Played {
    return Intl.message(
      'Matched Played ',
      name: 'Matched_Played',
      desc: '',
      args: [],
    );
  }

  /// `Total Win `
  String get Total_Win {
    return Intl.message(
      'Total Win ',
      name: 'Total_Win',
      desc: '',
      args: [],
    );
  }

  /// `Player type `
  String get Player_type_ {
    return Intl.message(
      'Player type ',
      name: 'Player_type_',
      desc: '',
      args: [],
    );
  }

  /// `Birth date `
  String get Birth_date_ {
    return Intl.message(
      'Birth date ',
      name: 'Birth_date_',
      desc: '',
      args: [],
    );
  }

  /// `Manage Members`
  String get Manage_Members {
    return Intl.message(
      'Manage Members',
      name: 'Manage_Members',
      desc: '',
      args: [],
    );
  }

  /// `Invite Members`
  String get Invite_Members {
    return Intl.message(
      'Invite Members',
      name: 'Invite_Members',
      desc: '',
      args: [],
    );
  }

  /// `Set the rules for members`
  String get Set_the_rules_for_members {
    return Intl.message(
      'Set the rules for members',
      name: 'Set_the_rules_for_members',
      desc: '',
      args: [],
    );
  }

  /// `Age restriction`
  String get Age_restriction {
    return Intl.message(
      'Age restriction',
      name: 'Age_restriction',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get Set {
    return Intl.message(
      'Set',
      name: 'Set',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Updated_successfully!' key

  /// `Loading...`
  String get Loading {
    return Intl.message(
      'Loading...',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `Above 20`
  String get Above_20 {
    return Intl.message(
      'Above 20',
      name: 'Above_20',
      desc: '',
      args: [],
    );
  }

  /// `Above 18`
  String get Above_18 {
    return Intl.message(
      'Above 18',
      name: 'Above_18',
      desc: '',
      args: [],
    );
  }

  /// `Everyone`
  String get Everyone {
    return Intl.message(
      'Everyone',
      name: 'Everyone',
      desc: '',
      args: [],
    );
  }

  /// `Club Type`
  String get Club_Type {
    return Intl.message(
      'Club Type',
      name: 'Club_Type',
      desc: '',
      args: [],
    );
  }

  /// `Create Club`
  String get Create_Club {
    return Intl.message(
      'Create Club',
      name: 'Create_Club',
      desc: '',
      args: [],
    );
  }

  /// `Set Club Picture`
  String get Set_Club_Picture {
    return Intl.message(
      'Set Club Picture',
      name: 'Set_Club_Picture',
      desc: '',
      args: [],
    );
  }

  /// `Type club name here`
  String get Type_club_name_here {
    return Intl.message(
      'Type club name here',
      name: 'Type_club_name_here',
      desc: '',
      args: [],
    );
  }

  /// `Club Name`
  String get Club_Name {
    return Intl.message(
      'Club Name',
      name: 'Club_Name',
      desc: '',
      args: [],
    );
  }

  /// `Type your name here`
  String get Type_your_name_here {
    return Intl.message(
      'Type your name here',
      name: 'Type_your_name_here',
      desc: '',
      args: [],
    );
  }

  /// `Club admin`
  String get Club_admin {
    return Intl.message(
      'Club admin',
      name: 'Club_admin',
      desc: '',
      args: [],
    );
  }

  /// `Type id here`
  String get Type_id_here {
    return Intl.message(
      'Type id here',
      name: 'Type_id_here',
      desc: '',
      args: [],
    );
  }

  /// `National Id number`
  String get National_Id_number {
    return Intl.message(
      'National Id number',
      name: 'National_Id_number',
      desc: '',
      args: [],
    );
  }

  /// `Type your Phone number here`
  String get Type_your_Phone_number_here {
    return Intl.message(
      'Type your Phone number here',
      name: 'Type_your_Phone_number_here',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get Phone_number {
    return Intl.message(
      'Phone number',
      name: 'Phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Type Club Address here`
  String get Type_Club_Address_here {
    return Intl.message(
      'Type Club Address here',
      name: 'Type_Club_Address_here',
      desc: '',
      args: [],
    );
  }

  /// `Club Address`
  String get Club_Address {
    return Intl.message(
      'Club Address',
      name: 'Club_Address',
      desc: '',
      args: [],
    );
  }

  /// `Type Your Email here`
  String get Type_Your_Email_here {
    return Intl.message(
      'Type Your Email here',
      name: 'Type_Your_Email_here',
      desc: '',
      args: [],
    );
  }

  /// `Your Email`
  String get Your_Email {
    return Intl.message(
      'Your Email',
      name: 'Your_Email',
      desc: '',
      args: [],
    );
  }

  /// `Type Number of Courts Own`
  String get Type_Number_of_Courts_Own {
    return Intl.message(
      'Type Number of Courts Own',
      name: 'Type_Number_of_Courts_Own',
      desc: '',
      args: [],
    );
  }

  /// `Your Courts Own`
  String get Your_Courts_Own {
    return Intl.message(
      'Your Courts Own',
      name: 'Your_Courts_Own',
      desc: '',
      args: [],
    );
  }

  /// `Rules and regulations`
  String get Rules_and_regulations {
    return Intl.message(
      'Rules and regulations',
      name: 'Rules_and_regulations',
      desc: '',
      args: [],
    );
  }

  /// `Briefly describe your club’s rule and regulations`
  String get Briefly_describe_your_clubs_rule_and_regulations {
    return Intl.message(
      'Briefly describe your club’s rule and regulations',
      name: 'Briefly_describe_your_clubs_rule_and_regulations',
      desc: '',
      args: [],
    );
  }

  /// `Find Court`
  String get Find_Court {
    return Intl.message(
      'Find Court',
      name: 'Find_Court',
      desc: '',
      args: [],
    );
  }

  /// `Courts`
  String get Courts {
    return Intl.message(
      'Courts',
      name: 'Courts',
      desc: '',
      args: [],
    );
  }

  /// `Create Court`
  String get Create_Court {
    return Intl.message(
      'Create Court',
      name: 'Create_Court',
      desc: '',
      args: [],
    );
  }

  /// `Set Court Picture`
  String get Set_Court_Picture {
    return Intl.message(
      'Set Court Picture',
      name: 'Set_Court_Picture',
      desc: '',
      args: [],
    );
  }

  /// `Type Court Name here`
  String get Type_Court_Name_here {
    return Intl.message(
      'Type Court Name here',
      name: 'Type_Court_Name_here',
      desc: '',
      args: [],
    );
  }

  /// `Court Name`
  String get Court_Name {
    return Intl.message(
      'Court Name',
      name: 'Court_Name',
      desc: '',
      args: [],
    );
  }

  /// `Type your phone number here`
  String get Type_your_phone_number_here {
    return Intl.message(
      'Type your phone number here',
      name: 'Type_your_phone_number_here',
      desc: '',
      args: [],
    );
  }

  /// `Your Phone`
  String get Your_Phone {
    return Intl.message(
      'Your Phone',
      name: 'Your_Phone',
      desc: '',
      args: [],
    );
  }

  /// `Start Date and Time`
  String get Start_Date_and_Time {
    return Intl.message(
      'Start Date and Time',
      name: 'Start_Date_and_Time',
      desc: '',
      args: [],
    );
  }

  /// `Select start date and time`
  String get Select_start_date_and_time {
    return Intl.message(
      'Select start date and time',
      name: 'Select_start_date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `End Date and time`
  String get End_Date_and_time {
    return Intl.message(
      'End Date and time',
      name: 'End_Date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Select end date and time`
  String get Select_end_date_and_time {
    return Intl.message(
      'Select end date and time',
      name: 'Select_end_date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Type Court Address here`
  String get Type_Court_Address_here {
    return Intl.message(
      'Type Court Address here',
      name: 'Type_Court_Address_here',
      desc: '',
      args: [],
    );
  }

  /// `Court Address`
  String get Court_Address {
    return Intl.message(
      'Court Address',
      name: 'Court_Address',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get Create {
    return Intl.message(
      'Create',
      name: 'Create',
      desc: '',
      args: [],
    );
  }

  /// `Club name for hosting the event`
  String get Club_name_for_hosting_the_event {
    return Intl.message(
      'Club name for hosting the event',
      name: 'Club_name_for_hosting_the_event',
      desc: '',
      args: [],
    );
  }

  /// `Tournament`
  String get Tournament {
    return Intl.message(
      'Tournament',
      name: 'Tournament',
      desc: '',
      args: [],
    );
  }

  /// `One Day`
  String get One_Day {
    return Intl.message(
      'One Day',
      name: 'One_Day',
      desc: '',
      args: [],
    );
  }

  /// `Challenge`
  String get Challenge {
    return Intl.message(
      'Challenge',
      name: 'Challenge',
      desc: '',
      args: [],
    );
  }

  /// `Competition`
  String get Competition {
    return Intl.message(
      'Competition',
      name: 'Competition',
      desc: '',
      args: [],
    );
  }

  /// `Friendly Match`
  String get Friendly_Match {
    return Intl.message(
      'Friendly Match',
      name: 'Friendly_Match',
      desc: '',
      args: [],
    );
  }

  /// `Daily Training`
  String get Daily_Training {
    return Intl.message(
      'Daily Training',
      name: 'Daily_Training',
      desc: '',
      args: [],
    );
  }

  /// `Party Event`
  String get Party_Event {
    return Intl.message(
      'Party Event',
      name: 'Party_Event',
      desc: '',
      args: [],
    );
  }

  /// `Training Plan`
  String get Training_Plan {
    return Intl.message(
      'Training Plan',
      name: 'Training_Plan',
      desc: '',
      args: [],
    );
  }

  /// `Event Type`
  String get Event_Type {
    return Intl.message(
      'Event Type',
      name: 'Event_Type',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid date and time`
  String get Please_enter_a_valid_date_and_time {
    return Intl.message(
      'Please enter a valid date and time',
      name: 'Please_enter_a_valid_date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Create Event`
  String get Create_Event {
    return Intl.message(
      'Create Event',
      name: 'Create_Event',
      desc: '',
      args: [],
    );
  }

  /// `Set Event Picture`
  String get Set_Event_Picture {
    return Intl.message(
      'Set Event Picture',
      name: 'Set_Event_Picture',
      desc: '',
      args: [],
    );
  }

  /// `Type event name here`
  String get Type_event_name_here {
    return Intl.message(
      'Type event name here',
      name: 'Type_event_name_here',
      desc: '',
      args: [],
    );
  }

  /// `Event Name`
  String get Event_Name {
    return Intl.message(
      'Event Name',
      name: 'Event_Name',
      desc: '',
      args: [],
    );
  }

  /// `Event Start`
  String get Event_Start {
    return Intl.message(
      'Event Start',
      name: 'Event_Start',
      desc: '',
      args: [],
    );
  }

  /// `Event End`
  String get Event_End {
    return Intl.message(
      'Event End',
      name: 'Event_End',
      desc: '',
      args: [],
    );
  }

  /// `Type Event address here`
  String get Type_Event_address_here {
    return Intl.message(
      'Type Event address here',
      name: 'Type_Event_address_here',
      desc: '',
      args: [],
    );
  }

  /// `Event Address`
  String get Event_Address {
    return Intl.message(
      'Event Address',
      name: 'Event_Address',
      desc: '',
      args: [],
    );
  }

  /// `Type Court name here`
  String get Type_Court_name_here {
    return Intl.message(
      'Type Court name here',
      name: 'Type_Court_name_here',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Briefly_describe_your_clubs_Instructions_here...' key

  /// `Player level`
  String get Player_level {
    return Intl.message(
      'Player level',
      name: 'Player_level',
      desc: '',
      args: [],
    );
  }

  /// `You can set a skill level requirement for players, allowing\nonly those whose skill level matches the requirement\nyou have set to participate.`
  String
      get You_can_set_a_skill_level_requirement_for_players_allowing_only_those_whose_skill_level_matches_the_requirement_you_have_set_to_participate {
    return Intl.message(
      'You can set a skill level requirement for players, allowing\nonly those whose skill level matches the requirement\nyou have set to participate.',
      name:
          'You_can_set_a_skill_level_requirement_for_players_allowing_only_those_whose_skill_level_matches_the_requirement_you_have_set_to_participate',
      desc: '',
      args: [],
    );
  }

  /// `Create \nYour Profile`
  String get Create_Your_Profile {
    return Intl.message(
      'Create \nYour Profile',
      name: 'Create_Your_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid date`
  String get Please_enter_a_valid_date {
    return Intl.message(
      'Please enter a valid date',
      name: 'Please_enter_a_valid_date',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid time`
  String get Please_enter_a_valid_time {
    return Intl.message(
      'Please enter a valid time',
      name: 'Please_enter_a_valid_time',
      desc: '',
      args: [],
    );
  }

  /// `Select Date of Birth`
  String get Select_Date_of_Birth {
    return Intl.message(
      'Select Date of Birth',
      name: 'Select_Date_of_Birth',
      desc: '',
      args: [],
    );
  }

  /// `Your Age`
  String get Your_Age {
    return Intl.message(
      'Your Age',
      name: 'Your_Age',
      desc: '',
      args: [],
    );
  }

  /// `Event Calendar`
  String get Event_Calendar {
    return Intl.message(
      'Event Calendar',
      name: 'Event_Calendar',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get Daily {
    return Intl.message(
      'Daily',
      name: 'Daily',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get Schedule {
    return Intl.message(
      'Schedule',
      name: 'Schedule',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get Monthly {
    return Intl.message(
      'Monthly',
      name: 'Monthly',
      desc: '',
      args: [],
    );
  }

  /// `No events found.`
  String get No_events_found {
    return Intl.message(
      'No events found.',
      name: 'No_events_found',
      desc: '',
      args: [],
    );
  }

  /// `Find Match`
  String get Find_Match {
    return Intl.message(
      'Find Match',
      name: 'Find_Match',
      desc: '',
      args: [],
    );
  }

  /// `Your Requirements`
  String get Your_Requirements {
    return Intl.message(
      'Your Requirements',
      name: 'Your_Requirements',
      desc: '',
      args: [],
    );
  }

  /// `People’ Requirements`
  String get People_Requirements {
    return Intl.message(
      'People’ Requirements',
      name: 'People_Requirements',
      desc: '',
      args: [],
    );
  }

  /// `No matches available now.`
  String get No_matches_available_now {
    return Intl.message(
      'No matches available now.',
      name: 'No_matches_available_now',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get You {
    return Intl.message(
      'You',
      name: 'You',
      desc: '',
      args: [],
    );
  }

  /// `Opponent`
  String get Opponent {
    return Intl.message(
      'Opponent',
      name: 'Opponent',
      desc: '',
      args: [],
    );
  }

  /// `Match data saved successfully!`
  String get Match_data_saved_successfully {
    return Intl.message(
      'Match data saved successfully!',
      name: 'Match_data_saved_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error occurred while saving match data!`
  String get Error_occurred_while_saving_match_data {
    return Intl.message(
      'Error occurred while saving match data!',
      name: 'Error_occurred_while_saving_match_data',
      desc: '',
      args: [],
    );
  }

  /// `Play`
  String get Play {
    return Intl.message(
      'Play',
      name: 'Play',
      desc: '',
      args: [],
    );
  }

  /// `Player Type `
  String get Player_Type {
    return Intl.message(
      'Player Type ',
      name: 'Player_Type',
      desc: '',
      args: [],
    );
  }

  /// `Address `
  String get Address {
    return Intl.message(
      'Address ',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Date `
  String get Date_ {
    return Intl.message(
      'Date ',
      name: 'Date_',
      desc: '',
      args: [],
    );
  }

  /// `Preferred time  `
  String get Preferred_time_ {
    return Intl.message(
      'Preferred time  ',
      name: 'Preferred_time_',
      desc: '',
      args: [],
    );
  }

  /// `Set Requirements`
  String get set_requirements {
    return Intl.message(
      'Set Requirements',
      name: 'set_requirements',
      desc: '',
      args: [],
    );
  }

  /// `Find`
  String get Find {
    return Intl.message(
      'Find',
      name: 'Find',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a club`
  String get Please_choose_a_club {
    return Intl.message(
      'Please choose a club',
      name: 'Please_choose_a_club',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Club`
  String get Club {
    return Intl.message(
      'Club',
      name: 'Club',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get Chat {
    return Intl.message(
      'Chat',
      name: 'Chat',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get Menu {
    return Intl.message(
      'Menu',
      name: 'Menu',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Playing time`
  String get Preferred_Playing_time {
    return Intl.message(
      'Preferred Playing time',
      name: 'Preferred_Playing_time',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get Date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'Date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Match Played`
  String get Match_Played {
    return Intl.message(
      'Match Played',
      name: 'Match_Played',
      desc: '',
      args: [],
    );
  }

  /// `In Club Ranking`
  String get In_Club_Ranking {
    return Intl.message(
      'In Club Ranking',
      name: 'In_Club_Ranking',
      desc: '',
      args: [],
    );
  }

  /// `Your Club`
  String get Your_Club {
    return Intl.message(
      'Your Club',
      name: 'Your_Club',
      desc: '',
      args: [],
    );
  }

  /// `No Club Data`
  String get No_Club_Data {
    return Intl.message(
      'No Club Data',
      name: 'No_Club_Data',
      desc: '',
      args: [],
    );
  }

  /// `Your Strength`
  String get Your_Strength {
    return Intl.message(
      'Your Strength',
      name: 'Your_Strength',
      desc: '',
      args: [],
    );
  }

  /// `Your strength will be determined based on your playing record,\nand your performance may impact your strength rating.`
  String
      get Your_strength_will_be_determined_based_on_your_playing_record_and_your_performance_may_impact_your_strength_rating {
    return Intl.message(
      'Your strength will be determined based on your playing record,\nand your performance may impact your strength rating.',
      name:
          'Your_strength_will_be_determined_based_on_your_playing_record_and_your_performance_may_impact_your_strength_rating',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching user data.`
  String get Error_fetching_user_data {
    return Intl.message(
      'Error fetching user data.',
      name: 'Error_fetching_user_data',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get Your_Profile {
    return Intl.message(
      'Your Profile',
      name: 'Your_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one role`
  String get Please_select_at_least_one_role {
    return Intl.message(
      'Please select at least one role',
      name: 'Please_select_at_least_one_role',
      desc: '',
      args: [],
    );
  }

  /// `Assign Person`
  String get Assign_Person {
    return Intl.message(
      'Assign Person',
      name: 'Assign_Person',
      desc: '',
      args: [],
    );
  }

  /// `Select Person`
  String get Select_Person {
    return Intl.message(
      'Select Person',
      name: 'Select_Person',
      desc: '',
      args: [],
    );
  }

  /// `Assign Roles`
  String get Assign_Roles {
    return Intl.message(
      'Assign Roles',
      name: 'Assign_Roles',
      desc: '',
      args: [],
    );
  }

  /// `Send invitation`
  String get Send_invitation {
    return Intl.message(
      'Send invitation',
      name: 'Send_invitation',
      desc: '',
      args: [],
    );
  }

  /// `Create Events`
  String get Create_Events {
    return Intl.message(
      'Create Events',
      name: 'Create_Events',
      desc: '',
      args: [],
    );
  }

  /// `Create tennis courts`
  String get Create_tennis_courts {
    return Intl.message(
      'Create tennis courts',
      name: 'Create_tennis_courts',
      desc: '',
      args: [],
    );
  }

  /// `Create offers`
  String get Create_offers {
    return Intl.message(
      'Create offers',
      name: 'Create_offers',
      desc: '',
      args: [],
    );
  }

  /// `Edit club`
  String get Edit_club {
    return Intl.message(
      'Edit club',
      name: 'Edit_club',
      desc: '',
      args: [],
    );
  }

  /// `Delete club`
  String get Delete_club {
    return Intl.message(
      'Delete club',
      name: 'Delete_club',
      desc: '',
      args: [],
    );
  }

  /// `Edit members`
  String get Edit_members {
    return Intl.message(
      'Edit members',
      name: 'Edit_members',
      desc: '',
      args: [],
    );
  }

  /// `Delete members`
  String get Delete_members {
    return Intl.message(
      'Delete members',
      name: 'Delete_members',
      desc: '',
      args: [],
    );
  }

  /// `Create Training`
  String get Create_Training {
    return Intl.message(
      'Create Training',
      name: 'Create_Training',
      desc: '',
      args: [],
    );
  }

  /// `Set up leagues`
  String get Set_up_leagues {
    return Intl.message(
      'Set up leagues',
      name: 'Set_up_leagues',
      desc: '',
      args: [],
    );
  }

  /// `Create Roles`
  String get Create_Roles {
    return Intl.message(
      'Create Roles',
      name: 'Create_Roles',
      desc: '',
      args: [],
    );
  }

  /// `Roles`
  String get Roles {
    return Intl.message(
      'Roles',
      name: 'Roles',
      desc: '',
      args: [],
    );
  }

  /// `Role Details`
  String get Role_Details {
    return Intl.message(
      'Role Details',
      name: 'Role_Details',
      desc: '',
      args: [],
    );
  }

  /// `You can add more rights to a role.`
  String get You_can_add_more_rights_to_a_role {
    return Intl.message(
      'You can add more rights to a role.',
      name: 'You_can_add_more_rights_to_a_role',
      desc: '',
      args: [],
    );
  }

  /// `Update Role`
  String get Update_Role {
    return Intl.message(
      'Update Role',
      name: 'Update_Role',
      desc: '',
      args: [],
    );
  }

  /// `Create Role`
  String get Create_Role {
    return Intl.message(
      'Create Role',
      name: 'Create_Role',
      desc: '',
      args: [],
    );
  }

  /// `Describe Role type here`
  String get Describe_Role_type_here {
    return Intl.message(
      'Describe Role type here',
      name: 'Describe_Role_type_here',
      desc: '',
      args: [],
    );
  }

  /// `Rights`
  String get Rights {
    return Intl.message(
      'Rights',
      name: 'Rights',
      desc: '',
      args: [],
    );
  }

  /// `Role Created`
  String get Role_Created {
    return Intl.message(
      'Role Created',
      name: 'Role_Created',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Role_has_been_created_successfully.' key

  /// `Error creating role`
  String get Error_creating_role {
    return Intl.message(
      'Error creating role',
      name: 'Error_creating_role',
      desc: '',
      args: [],
    );
  }

  /// `Roles list`
  String get Roles_list {
    return Intl.message(
      'Roles list',
      name: 'Roles_list',
      desc: '',
      args: [],
    );
  }

  /// `Assign Roles to a Person`
  String get Assign_Roles_to_a_Person {
    return Intl.message(
      'Assign Roles to a Person',
      name: 'Assign_Roles_to_a_Person',
      desc: '',
      args: [],
    );
  }

  /// `Describe Rights`
  String get Describe_Rights {
    return Intl.message(
      'Describe Rights',
      name: 'Describe_Rights',
      desc: '',
      args: [],
    );
  }

  /// `No data found`
  String get No_data_found {
    return Intl.message(
      'No data found',
      name: 'No_data_found',
      desc: '',
      args: [],
    );
  }

  /// `Set Reminder`
  String get Set_Reminder {
    return Intl.message(
      'Set Reminder',
      name: 'Set_Reminder',
      desc: '',
      args: [],
    );
  }

  /// `Your event will start now`
  String get your_event_will_start_now {
    return Intl.message(
      'Your event will start now',
      name: 'your_event_will_start_now',
      desc: '',
      args: [],
    );
  }

  /// `No Reversed Courts`
  String get No_Reversed_Courts {
    return Intl.message(
      'No Reversed Courts',
      name: 'No_Reversed_Courts',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching court data`
  String get Error_fetching_court_data {
    return Intl.message(
      'Error fetching court data',
      name: 'Error_fetching_court_data',
      desc: '',
      args: [],
    );
  }

  /// `No court data available`
  String get No_court_data_available {
    return Intl.message(
      'No court data available',
      name: 'No_court_data_available',
      desc: '',
      args: [],
    );
  }

  /// `Click to Reverse Court`
  String get Click_to_Reverse_Court {
    return Intl.message(
      'Click to Reverse Court',
      name: 'Click_to_Reverse_Court',
      desc: '',
      args: [],
    );
  }

  /// `You Don't have Events`
  String get You_Dont_have_Events {
    return Intl.message(
      'You Don\'t have Events',
      name: 'You_Dont_have_Events',
      desc: '',
      args: [],
    );
  }

  /// `Register for events on the Club page`
  String get Register_for_events_on_the_Club_page {
    return Intl.message(
      'Register for events on the Club page',
      name: 'Register_for_events_on_the_Club_page',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching event data`
  String get Error_fetching_event_data {
    return Intl.message(
      'Error fetching event data',
      name: 'Error_fetching_event_data',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching player data`
  String get Error_fetching_player_data {
    return Intl.message(
      'Error fetching player data',
      name: 'Error_fetching_player_data',
      desc: '',
      args: [],
    );
  }

  /// `Register Done`
  String get Register_Done {
    return Intl.message(
      'Register Done',
      name: 'Register_Done',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching match data`
  String get Error_fetching_match_data {
    return Intl.message(
      'Error fetching match data',
      name: 'Error_fetching_match_data',
      desc: '',
      args: [],
    );
  }

  /// `You Don't have Matches`
  String get You_Dont_have_Matches {
    return Intl.message(
      'You Don\'t have Matches',
      name: 'You_Dont_have_Matches',
      desc: '',
      args: [],
    );
  }

  /// `Click to Find Your Partner`
  String get Click_to_Find_Your_Partner {
    return Intl.message(
      'Click to Find Your Partner',
      name: 'Click_to_Find_Your_Partner',
      desc: '',
      args: [],
    );
  }

  /// `No matches`
  String get No_matches {
    return Intl.message(
      'No matches',
      name: 'No_matches',
      desc: '',
      args: [],
    );
  }

  /// `Your Upcoming Events`
  String get Your_Upcoming_Events {
    return Intl.message(
      'Your Upcoming Events',
      name: 'Your_Upcoming_Events',
      desc: '',
      args: [],
    );
  }

  /// `Your Reversed Courts`
  String get Your_Reversed_Courts {
    return Intl.message(
      'Your Reversed Courts',
      name: 'Your_Reversed_Courts',
      desc: '',
      args: [],
    );
  }

  /// `Your Upcoming Matches`
  String get Your_Upcoming_Matches {
    return Intl.message(
      'Your Upcoming Matches',
      name: 'Your_Upcoming_Matches',
      desc: '',
      args: [],
    );
  }

  /// `Find Partner`
  String get Find_Partner {
    return Intl.message(
      'Find Partner',
      name: 'Find_Partner',
      desc: '',
      args: [],
    );
  }

  /// `Member administration`
  String get Member_administration {
    return Intl.message(
      'Member administration',
      name: 'Member_administration',
      desc: '',
      args: [],
    );
  }

  /// `Create a role`
  String get Create_a_role {
    return Intl.message(
      'Create a role',
      name: 'Create_a_role',
      desc: '',
      args: [],
    );
  }

  /// `Tournament management`
  String get Tournament_management {
    return Intl.message(
      'Tournament management',
      name: 'Tournament_management',
      desc: '',
      args: [],
    );
  }

  /// `Your Membership`
  String get Your_Membership {
    return Intl.message(
      'Your Membership',
      name: 'Your_Membership',
      desc: '',
      args: [],
    );
  }

  /// `From :`
  String get From_ {
    return Intl.message(
      'From :',
      name: 'From_',
      desc: '',
      args: [],
    );
  }

  /// `To :`
  String get To_ {
    return Intl.message(
      'To :',
      name: 'To_',
      desc: '',
      args: [],
    );
  }

  /// `Address :`
  String get Address_ {
    return Intl.message(
      'Address :',
      name: 'Address_',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching data`
  String get Error_fetching_data {
    return Intl.message(
      'Error fetching data',
      name: 'Error_fetching_data',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get No_data_available {
    return Intl.message(
      'No data available',
      name: 'No_data_available',
      desc: '',
      args: [],
    );
  }

  /// `Get Reserved`
  String get Get_Reserved {
    return Intl.message(
      'Get Reserved',
      name: 'Get_Reserved',
      desc: '',
      args: [],
    );
  }

  /// `Occupied`
  String get Occupied {
    return Intl.message(
      'Occupied',
      name: 'Occupied',
      desc: '',
      args: [],
    );
  }

  /// `Your Single Matches`
  String get Your_Upcoming_Single_Matches_Club {
    return Intl.message(
      'Your Single Matches',
      name: 'Your_Upcoming_Single_Matches_Club',
      desc: '',
      args: [],
    );
  }

  /// `Your Double Matches`
  String get Your_Upcoming_Double_Matches_Club {
    return Intl.message(
      'Your Double Matches',
      name: 'Your_Upcoming_Double_Matches_Club',
      desc: '',
      args: [],
    );
  }

  /// `Club’s Single Matches`
  String get available_single_matches {
    return Intl.message(
      'Club’s Single Matches',
      name: 'available_single_matches',
      desc: '',
      args: [],
    );
  }

  /// `Club’s Double Matches`
  String get available_double_matches {
    return Intl.message(
      'Club’s Double Matches',
      name: 'available_double_matches',
      desc: '',
      args: [],
    );
  }

  /// `Single Tournaments`
  String get SingleTournaments {
    return Intl.message(
      'Single Tournaments',
      name: 'SingleTournaments',
      desc: '',
      args: [],
    );
  }

  /// `Double Tournaments`
  String get DoubleTournaments {
    return Intl.message(
      'Double Tournaments',
      name: 'DoubleTournaments',
      desc: '',
      args: [],
    );
  }

  /// `Enter Results`
  String get Enter_Results {
    return Intl.message(
      'Enter Results',
      name: 'Enter_Results',
      desc: '',
      args: [],
    );
  }

  /// `Email verified`
  String get email_verified {
    return Intl.message(
      'Email verified',
      name: 'email_verified',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Select Players`
  String get select_players {
    return Intl.message(
      'Select Players',
      name: 'select_players',
      desc: '',
      args: [],
    );
  }

  String get set_group_image {
    return Intl.message(
      'Set Group Image',
      name: 'set_group_image',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
