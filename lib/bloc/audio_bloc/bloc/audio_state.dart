part of 'audio_bloc.dart';

sealed class AudioState {}

final class AudioInitial extends AudioState {}

class AudioLoading extends AudioState{}
class AudioFailed extends AudioState{}

class AudioSuccess extends AudioState{
  List<AudioModel> audioList;
  AudioSuccess({required this.audioList});
}

/// effects
class EffectLoading extends AudioState{}
class EffectFailed extends AudioState{}

class EffectSuccess extends AudioState{
  List<List<SoundEffectModel>> effectList;
  EffectSuccess({required this.effectList});
}
