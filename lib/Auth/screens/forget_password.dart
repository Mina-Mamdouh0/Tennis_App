import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/widgets/custom_button.dart';
import '../../core/utils/snackbar.dart';
import '../../core/utils/widgets/clipper.dart';
import '../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';
import '../../core/utils/widgets/input_feild.dart';
import '../widgets/waveClipperScreen.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    void passwordRest() async {
      await authCubit.sendPasswordResetEmail(
          email: emailController.text, context: context);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthErrorState) {
          showSnackBar(context, state.error); // Displaying the error message
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    WaveClipperScreen(
                      widgetHeight: screenHeight * .5,
                      svgImage: SvgPicture.asset('assets/images/auth1.svg'),
                      text: S.of(context).forgot_password_header,
                    ),
                    Opacity(
                      opacity: 0.1,
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: ClipPath(
                          clipper: WaveClipper(),
                          child: Container(
                            color: Colors.black,
                            height: screenHeight * 0.507,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * .1,
                        ),
                        Text(
                          S.of(context).enter_email,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * .05, vertical: 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).email,
                              style: const TextStyle(
                                color: Color(0xFF797979),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        MyInputText(
                          controller: emailController,
                          hintText: S.of(context).email_address,
                          icon: Icons.email_outlined,
                          obscureText: false,
                        ),
                        SizedBox(
                          height: screenHeight * .02,
                        ),
                      ],
                    ),
                  ),
                ),
                BottomSheetContainer(
                  buttonText: S.of(context).reset_password,
                  onPressed: () {
                    passwordRest();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
