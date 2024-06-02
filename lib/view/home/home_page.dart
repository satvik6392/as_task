
// not in use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/myhelper/textstyles/textstyles.dart';
import 'package:soundscape/view/auth/auth_home.dart';

import '../../myhelper/constants/constants_strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.appBackgroundColor,
      body: Column(
        children: [
          Container(
            height: 145,
            width: double.infinity,
             decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF5B5F97),
                  Color(0x005B5F97),  // Equivalent to rgba(91, 95, 151, 0)
                ],
                stops: [0.0, 1.0],
                
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30,left: 30),
                child: Text(MyStrings.homeHeading,style: MyTextStyle.headingStyle.copyWith(fontSize: 24,fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: GestureDetector(
              onTap: () async{
                SharedPreferences sp = await SharedPreferences.getInstance();
                await sp.clear();
                navigatorPushReplace(const AuthHomePage());
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.headingTextColor,
                    width: 1,
                  
                  )
                  ,borderRadius: BorderRadius.circular(40)
                ),
                height: 45,
                width: 330,
                child: Center(child: Text("Logout",style: MyTextStyle.headingStyle.copyWith(fontSize: 20,fontWeight: FontWeight.w500),),),
              ),
            ),
          )
        ],
      )
    );
  }
}