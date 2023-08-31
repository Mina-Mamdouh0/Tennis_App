import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/utils/snackbar.dart';
import '../../generated/l10n.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // EMAIL SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await sendEmailVerification(context);
      await waitForEmailVerification(context);

      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      GoRouter.of(context).push('/createProfile');
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        showSnackBar(context, S.of(context).weak_password);
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, S.of(context).account_already_exists);
      }
      showSnackBar(
          context, e.message!); // Displaying the usual firebase error message
    }
  }

  Future<void> waitForEmailVerification(BuildContext context) async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      while (!currentUser.emailVerified) {
        await Future.delayed(Duration(seconds: 2)); // Wait for 2 seconds
        await currentUser.reload(); // Refresh user data
      }
      showSnackBar(context, S.of(context).email_verified);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackBar(context, S.of(context).email_verification_sent);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Display error message
    }
  }

  // EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      GoRouter.of(context).replace('/home');
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    }
  }

  // GOOGLE SIGN IN
  void signInWithGoogle(BuildContext context) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await FirebaseAuth.instance.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        if (googleUser == null) {
          showSnackBar(context, S.of(context).google_signin_no_user);
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Sign in to Firebase Authentication
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Check if the user is new or existing
        if (userCredential.additionalUserInfo!.isNewUser) {
          GoRouter.of(context).push('/createProfile');
        } else {
          GoRouter.of(context).push('/home');
        }
        // The routing code should be here after successful sign-in
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!); // Displaying the error message
    } catch (e) {
      showSnackBar(
        context,
        '${S.of(context).google_signin_unexpected_error}$e',
      );
    }
  }

  //reset password
  Future<void> sendPasswordResetEmail({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: S.of(context).password_reset_email_sent,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: S.of(context).failed_send_password_reset_email,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      print('Error during sign out: $error');
    }
  }
}
