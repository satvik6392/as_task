import 'package:bloc/bloc.dart';
import 'package:soundscape/services/api_services.dart';

import '../../../models/effect_model.dart';
import '../../../models/song_model.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc() : super(AudioInitial()) {
    on<GetAudioEvent>((event,emit)async{
     emit(AudioLoading());
     final data = await ApiServices.getAudio();
     if(data == null)
     {
      emit(AudioFailed());
     }else{
      emit(AudioSuccess(audioList: data));
     }
    });

     on<GetEffectEvent>((event,emit)async{
     emit(EffectLoading());
     final data = await ApiServices.getSoundEffect();
     if(data == null)
     {
      print("coming here");
      emit(EffectFailed());
     }else{
      emit(EffectSuccess(effectList: data));
     }
    });
  }
}
