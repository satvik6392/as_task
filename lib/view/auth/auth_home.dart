import 'package:flutter/material.dart';
import 'package:soundscape/myhelper/buttons/buttons.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/myhelper/textstyles/textstyles.dart';
import 'package:soundscape/view/auth/login_signup.dart';

class AuthHomePage extends StatefulWidget {
  const AuthHomePage({super.key});

  @override
  State<AuthHomePage> createState() => _AuthHomePageState();
}

class _AuthHomePageState extends State<AuthHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 249,
                width: 232,
                child: Image.asset('assets/images/app_logo.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top:21.0),
                child: Text(MyStrings.authHomeHeading,style: MyTextStyle.headingStyle.copyWith(fontWeight: FontWeight.w400),),
              ),
              const Padding(
                padding: EdgeInsets.only(top:51.0),
                child: Text(MyStrings.authHomeSubHeading,style: MyTextStyle.onBoaringContentText,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.0),
                child: MyButtons.myMainButton(buttonText: 'Sign-Up',callback: (){
                  navigatorPush(AuthLoginSignUp(isLogin: false,));
                },padding: const EdgeInsets.only(left: 20,right: 20)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 21.0),
                child: MyButtons.myMainButton(buttonText: 'Login',callback: (){
                  navigatorPush(AuthLoginSignUp(isLogin: true,));
                },padding: const EdgeInsets.only(left: 20,right: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}