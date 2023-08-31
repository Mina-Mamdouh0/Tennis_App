import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/utils/snackbar.dart';
import '../cubit/auth_cubit.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    void signGooglIn() async {
      await authCubit.signInWithGoogle(context);
    }

    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      if (state is GooglLoadingState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is GooglErrorState) {
        showSnackBar(context, state.error); // Displaying the error message
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              iconSize: 70,
              onPressed: () {},
              icon: const Icon(
                Icons.facebook_rounded,
                color: Colors.blue,
              )),
          IconButton(
              iconSize: 70,
              onPressed: () async {
                signGooglIn();
              },
              icon: Container(
                child: SvgPicture.asset(
                  'assets/images/google.svg',
                  height: 55,
                ),
              ))
        ],
      );
    });
  }
}
