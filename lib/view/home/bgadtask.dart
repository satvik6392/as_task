import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundscape/models/song_model.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static List<AudioModel> audioList = [];
  static int? currentIndex;
  // static final _item = MediaItem(
  //   id: 'http://soundscape.boostproductivity.online/api/getmusic/Rain',
  //   album: "Science",
  //   title: "A Salute To Head-Scratching Science",
  //   artist: "Science Friday ",
  //   duration: const Duration(milliseconds: 5739820),

  //   artUri: Uri.parse(
  //       'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  // );
  // static final _item2 = MediaItem(
  //   id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
  //   album: "Science Friday",
  //   title: "A Salute To Head-Scratching Science",
  //   artist: "Science Friday and WNYC Studios",
  //   duration: const Duration(milliseconds: 5739820),
  //   artUri: Uri.parse(
  //       'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  // );

  static final player = AudioPlayer();
  static final player2 = AudioPlayer();

  /// Initialise our audio handler.
  AudioPlayerHandler() {
    // So that our clients (the Flutter UI and the system notification) know
    // what state to display, here we set up our audio handler to broadcast all
    // playback state changes as they happen via playbackState...
    player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // _player2.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... and also the current media item via mediaItem.
    // mediaItem.add(_item);
    // mediaItem.add(_item2);

    // // Load the player.
    
    // _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
    // _player2.setAudioSource(AudioSource.uri(Uri.parse(_item2.id)));
  }

  // In this simple example, we handle only 4 actions: play, pause, seek and
  // stop. Any button press from the Flutter UI, notification, lock screen or
  // headset will be routed through to these 4 methods so that you can handle
  // your audio playback logic in one place.

  @override
  Future<void> play()async {
    // player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // mediaItem.add(kitem);
  player.play();
  player2.play();
  }
// Future<void> setAudioSource(AudioModel audio)async{
//     final kitem = MediaItem(
//     id: audio.assetPath,
//     album: "Tired",
//     title: 'audio.name.toString()',
//     artist: "artist",
//     displayTitle: "Display title",
//     duration: const Duration(milliseconds: 5739820),

//     artUri: Uri.parse(
//         'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//   );
//     // player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     mediaItem.add(kitem);
//     await player.setAudioSource(
//           initialIndex: 0,
//           preload: true,
//           AudioSource.uri(Uri.parse(audio.assetPath)));
//   }

//   Future<void> setAudioSource2(AudioSource audioSource)async{
//     await player2.setAudioSource(audioSource);
//   }
  @override
  Future<void> pause()async{
    player.pause();
    player2.pause();
  }

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> stop() async{
    player.stop();
    player2.stop();
  }
  @override
  Future<void> skipToNext() async{
    player.setAudioSource(
      AudioSource.uri(
        Uri.parse(audioList[0].assetPath),
        tag: MediaItem(id: audioList[0].assetPath, title: audioList[0].name)
      )
    );
    player.play();
    // player.skipToNext();
    // player2.stop();
  }

  /// Transform a just_audio event into an audio_service state.
  ///
  /// This method is used from the constructor. Every event received from the
  /// just_audio player will be transformed into an audio_service state so that
  /// it can be broadcast to audio_service clients.
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[player.processingState]!,
      playing: player.playing,
      updatePosition: player.position,
      bufferedPosition: player.bufferedPosition,
      speed: player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
