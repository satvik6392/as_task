class MyStrings{
  /// onboarding screens
  static const String onboarding1Heading = 'EMOTIONALLY BALANCED LIVING';
  static const String onboarding1Content = 'Tailor soundscapes to uplift, relax, or soothe your varying moods. Experience emotional wellness.';
  static const String onboarding2Heading = 'CATER TO YOUR NEEDS';
  static const String onboarding2Content = 'From focused study to tranquil sleep, find the perfect sound for every purpose.';
  static const String onboarding3Heading = 'SOUNDSCAPES ENVIRONMENT';
  static const String onboarding3Content = 'Craft personalized surroundings with layered sounds. Customize your ambient experience.';

  /// auth screens
  static const String authHomeHeading = 'Let’s get started';
  static const String authHomeSubHeading = 'Login or create an account to proceed.';
  static const String signupHeading = 'Create an Account';
  static const String login = 'LOGIN';
  static const String email = "Email ID";
  static const String createPassword = "Create Password";
  static const String enterPassword = "Enter Password";
  static const String forgotPassword = "Forgot Password";
  static const String noAccount = "Don’t have an account? ";
  static const String signup = "Sign-Up.";
  static const String forgotPass = "FORGOT PASSWORD";
  //password reset
  static const String resetMessage = "Password reset link has been sent to your email address.";
  //user info
  static const String loginStatus = 'loginStatus';
  static const String userEmail = 'userEmail';

  // home page content
  static const String homeHeading = 'Listen, Focus, Unwind.';


}


class ApiUrls{
  static const List effects = [
    'SENature',
    'SEInstrumental',
    'SEASMR'
  ];
  static const baseUrl = "http://soundscape.boostproductivity.online/api/getSongs";
  // tried
  static const String getSongs = '$baseUrl/tired';
  static const String getEffects = '$baseUrl/';
}