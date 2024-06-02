import 'package:flutter/material.dart';
import 'package:soundscape/myhelper/buttons/buttons.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/view/auth/auth_home.dart';

import '../../myhelper/textstyles/textstyles.dart';

class SingleScreenOnboarding extends StatefulWidget {
  @override
  _SingleScreenOnboardingState createState() => _SingleScreenOnboardingState();
}

class _SingleScreenOnboardingState extends State<SingleScreenOnboarding> {
  final List<String> _imagesPath = [
    'assets/images/onboarding1.png',
    'assets/images/onboarding2.png',
    'assets/images/onboarding3.png'
  ];

  final List<String> _headings = [
    MyStrings.onboarding1Heading,
    MyStrings.onboarding2Heading,
    MyStrings.onboarding3Heading
  ];

  final List<String> _contents = [
    MyStrings.onboarding1Content,
    MyStrings.onboarding2Content,
    MyStrings.onboarding3Content
  ];
  final List<String> _buttonText = [
    'Next',
    'Next',
    'Get Started',
  ];
  int _currentIndex = 0;

  void _nextContent() {
    // print("object");
    setState(() {
      if (_currentIndex < _imagesPath.length - 1) {
        _currentIndex++;
      } else {
        navigatorPushReplace(AuthHomePage());
        // navigatorPush(HomeScreen()); // Optionally reset to the first content
      }
    });
  }

  void _previousContent() {
    // print("object");
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        // navigatorPush(AuthHomePage());
        // navigatorPush(HomeScreen()); // Optionally reset to the first content
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          _nextContent();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          _previousContent();
        }
      },
      child: Scaffold(
        backgroundColor: MyColors.appBackgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Container(
                        height: 227,
                        width: 350,
                        child: Image.asset(
                          _imagesPath[_currentIndex],
                          fit: BoxFit.cover,
                        )),
                  ),
                      const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      _headings[_currentIndex],
                      style: MyTextStyle.headingStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40,),
                  Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        _contents[_currentIndex],
                        style: MyTextStyle.onBoaringContentText,
                        textAlign: TextAlign.center,
                      )),
                      const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (int index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        height: 10.0,
                        width: _currentIndex == index ? 20.0 : 10.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40,),
                  MyButtons.myMainButton(
                      buttonText: _buttonText[_currentIndex],
                      callback: () {
                        _nextContent();
                      }),
                ],
              ),
          ),
        ),
        
      ),
    );
  }
}
