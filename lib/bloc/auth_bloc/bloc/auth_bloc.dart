import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundscape/services/fireabase_services.dart';

import '../../../myhelper/constants/constants_strings.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async{
      final sp = await SharedPreferences.getInstance();
      emit(LoginLoading());
      final response = await FirebaseServices().signInWithEmailPassword(event.email, event.password);
      if(response == null)
      {
        print('response -> null');
        emit(LoginFailed());
      }else{
        await sp.setBool(MyStrings.loginStatus,true);
        await sp.setString(MyStrings.userEmail,event.email);
        print('response -> $response');
        emit(LoginSuccess());
      }
    });
  
    on<SignUpEvent>((event, emit) async{
      final sp = await SharedPreferences.getInstance();
      emit(LoginLoading());
      final response = await FirebaseServices().signUpWithEmailPassword(event.email, event.password);
      
      if(response == null)
      {
        print('response -> null');
        emit(LoginFailed());
      }else{
        await sp.setBool(MyStrings.loginStatus,true);
        await sp.setString(MyStrings.userEmail,event.email);
      emit(LoginSuccess());
      }
    });

    on<PasswordResetEvent>((event,emit)async{
      emit(SendingResetMail());
      final response = await FirebaseServices().sendPasswordResetEmail(event.email);
      if(response  == null)
      {
        emit(SendFailed());
      }else{
        emit(SentSuccess());
      }
    });
  }
}
