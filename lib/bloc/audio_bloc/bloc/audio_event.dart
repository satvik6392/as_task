part of 'audio_bloc.dart';


sealed class AudioEvent {}

class GetAudioEvent extends AudioEvent{}

class GetEffectEvent extends AudioEvent{}