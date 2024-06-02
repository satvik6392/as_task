import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/myhelper/textstyles/textstyles.dart';
import 'package:soundscape/view/auth/pass_reset.dart';
import 'package:soundscape/view/home/dashboard.dart';

import '../../bloc/auth_bloc/bloc/auth_bloc.dart';

// ignore: must_be_immutable
class AuthLoginSignUp extends StatefulWidget {
  bool isLogin;
  AuthLoginSignUp({super.key, required this.isLogin});

  @override
  State<AuthLoginSignUp> createState() => _AuthLoginSignUpState();
}

class _AuthLoginSignUpState extends State<AuthLoginSignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: MyColors.appBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 85.0,
                  ),
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/images/leaf.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.0, left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.isLogin ? MyStrings.login : MyStrings.signupHeading,
                    textAlign: TextAlign.left,
                    style: MyTextStyle.headingStyle
                        .copyWith(fontSize: 28, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 65),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          MyStrings.email,
                          style: MyTextStyle.headingStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Type here...",
                            hintStyle: const TextStyle(
                              color: MyColors.headingTextColor,
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: MyColors.headingTextColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Simple email validation
                            String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
                            RegExp regex = RegExp(pattern);
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              _emailError = null;
                            });
                          },
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 29.0, bottom: 8.0),
                        child: Text(
                          widget.isLogin
                              ? MyStrings.enterPassword
                              : MyStrings.createPassword,
                          style: MyTextStyle.headingStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: TextFormField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Type here...",
                            hintStyle: const TextStyle(
                              color: MyColors.headingTextColor,
                              fontWeight: FontWeight.w100,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: MyColors.headingTextColor,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            setState(() {
                              _passwordError = null;
                            });
                          },
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(
                        height: 24,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginFailed) {
                            final snackBar = SnackBar(
                              content: Text('Failed'),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.all(16.0),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          if (state is LoginSuccess) {
                            navigatorPushReplace(const Dashboard());
                          }
                        },
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  widget.isLogin
                                      ? context.read<AuthBloc>().add(LoginEvent(
                                          email: _emailController.text,
                                          password: _passwordController.text))
                                      : context.read<AuthBloc>().add(
                                          SignUpEvent(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text));
                                } else {}
                              },
                              child: Container(
                                height: 44,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: MyColors.appBackgroundColor,
                                  border: Border.all(
                                    color: MyColors.headingTextColor,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: MyColors.headingTextColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 176,
                      ),
                      widget.isLogin
                          ? GestureDetector(
                              onTap: () {
                                navigatorPush(PasswordReset());
                              },
                              child: Center(
                                  child: Text(
                                MyStrings.forgotPassword,
                                style: MyTextStyle.headingStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    decorationColor: MyColors.headingTextColor),
                              )),
                            )
                          : const SizedBox.shrink(),
                      widget.isLogin
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.isLogin = false;
                                });
                              },
                              child: Center(
                                child: RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                      text: MyStrings.noAccount,
                                      style: MyTextStyle.headingStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: MyStrings.signup,
                                      style: MyTextStyle.headingStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              MyColors.headingTextColor))
                                ])),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.isLogin = true;
                                });
                              },
                              child: Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "Already have an account? ",
                                      style: MyTextStyle.headingStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Login.",
                                      style: MyTextStyle.headingStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
