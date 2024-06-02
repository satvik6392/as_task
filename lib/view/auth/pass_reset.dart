import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import '../../bloc/auth_bloc/bloc/auth_bloc.dart';
import '../../myhelper/colors/colors.dart';
import '../../myhelper/constants/constants_strings.dart';
import '../../myhelper/textstyles/textstyles.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        backgroundColor: MyColors.appBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 55),
                  child: GestureDetector(
                    onTap: () {
                      goBack();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: MyColors.headingTextColor,
                            width: 1.7,
                          )),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: MyColors.headingTextColor,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'assets/images/leaf.png',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.0, left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    MyStrings.forgotPass,
                    textAlign: TextAlign.left,
                    style: MyTextStyle.headingStyle
                        .copyWith(fontSize: 28, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if(state is SendFailed)
                  {
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
                },
                builder: (context, state) {
                  if (state is SendingResetMail) {
                    return const Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top :40.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if(state is SentSuccess)
                  {
                    return Padding(
                      padding: const EdgeInsets.only(left: 30.0,right: 30,top:80),
                      child: Text('Password reset link has been sent to your email address.',style: MyTextStyle.headingStyle.copyWith(fontSize: 18,fontWeight: FontWeight.w500),),
                    );
                  }
                  return Form(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 76),
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
                            height: 43,
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(color: Colors.white),
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
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          const SizedBox(
                            height: 131,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: (){
                                if(_emailController.text.isNotEmpty)
                                {
                                   context.read<AuthBloc>().add(PasswordResetEvent(email: _emailController.text));
                                }
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
                                    borderRadius: BorderRadius.circular(30)),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: MyColors.headingTextColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
