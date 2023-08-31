import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../services/auth_methods.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoadingState());
      await FirebaseAuthMethods().loginWithEmail(
        email: email,
        password: password,
        context: context,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoadingState());

      // await sendEmailVerification(context);

      await FirebaseAuthMethods().signUpWithEmail(
        email: email,
        password: password,
        context: context,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  //reset password
  Future<void> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoadingState());
      await FirebaseAuthMethods().sendPasswordResetEmail(
        email: email,
        context: context,
      );
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      emit(GooglLoadingState());
      FirebaseAuthMethods().signInWithGoogle(context);
      emit(GooglSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(GooglErrorState(e.message.toString()));
    }
  }
}
