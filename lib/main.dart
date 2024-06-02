
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:soundscape/view/home/bgadtask.dart';
import 'package:soundscape/view/home/dashboard.dart';
import 'package:soundscape/view/onboarding/onboard.dart';
import 'package:audio_service/audio_service.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

late AudioHandler _audioHandler;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyCLGUAxMv7Rk961UoWPnD8103mk_y_exJk',
            appId: 'com.example.soundscape',
            messagingSenderId: 'messagingSenderId',
            projectId: 'taskas-21090'));
  } catch (err) {
    print(err);
  }
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',

  //   androidNotificationOngoing: true,
  //   notificationColor: Colors.black,
  // );
  await AudioService.init(
    builder: () => AudioPlayerHandler(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      notificationColor: Colors.white
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool(MyStrings.loginStatus) ?? false;
  runApp(MyApp(loginStatus: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool loginStatus;
  static final navigatorKey = GlobalKey<NavigatorState>();
  const MyApp({super.key,required this.loginStatus});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Sound Scape',
      // home: Dashboard(),
      home: loginStatus == false ? SingleScreenOnboarding() : const Dashboard(),
    );
  }
}

//// test code
// ignore_for_file: public_member_api_docs

// FOR MORE EXAMPLES, VISIT THE GITHUB REPOSITORY AT:
//
//  https://github.com/ryanheise/audio_service
//
// This example implements a minimal audio handler that renders the current
// media item and playback state to the system notification and responds to 4
// media actions:
//
// - play
// - pause
// - seek
// - stop
//
// To run this example, use:
//
// flutter run

// import 'dart:async';
// import 'package:audio_service/audio_service.dart';
// // import 'package:audio_service_example/common.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart';

// // You might want to provide this using dependency injection rather than a
// // global variable.
// late AudioHandler _audioHandler;

// Future<void> main() async {
//   _audioHandler = await AudioService.init(
//     builder: () => AudioPlayerHandler(),
//     config: const AudioServiceConfig(
//       androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio',
//       androidNotificationChannelName: 'Audio playback',
//       androidNotificationOngoing: true,
//     ),
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Audio Service Demo',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Audio Service Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Show media item title
//             StreamBuilder<MediaItem?>(
//               stream: _audioHandler.mediaItem,
//               builder: (context, snapshot) {
//                 final mediaItem = snapshot.data;
//                 return Text(mediaItem?.title ?? '');
//               },
//             ),
//             // Play/pause/stop buttons.
//             StreamBuilder<bool>(
//               stream: _audioHandler.playbackState
//                   .map((state) => state.playing)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final playing = snapshot.data ?? false;
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _button(Icons.fast_rewind, _audioHandler.rewind),
//                     if (playing)
//                       _button(Icons.pause, _audioHandler.pause)
//                     else
//                       _button(Icons.play_arrow, _audioHandler.play),
//                     _button(Icons.stop, _audioHandler.stop),
//                     _button(Icons.fast_forward, _audioHandler.fastForward),
//                   ],
//                 );
//               },
//             ),
//             // A seek bar.
//             StreamBuilder<MediaState>(
//               stream: _mediaStateStream,
//               builder: (context, snapshot) {
//                 final mediaState = snapshot.data;
//                 return Slider(
//                   value: mediaState?.position.inSeconds.toDouble() ??
//                       Duration.zero.inSeconds.toDouble(),
//                   min: 0.0,
//                   max: mediaState?.mediaItem?.duration?.inSeconds.toDouble() ??
//                       Duration.zero.inSeconds.toDouble(),
//                   onChanged: (value) async {
//                     await _audioHandler.seek(Duration(seconds: value.toInt()));
//                   },
//                 );
//                 // return SeekBar(
//                 //   duration: mediaState?.mediaItem?.duration ?? Duration.zero,
//                 //   position: mediaState?.position ?? Duration.zero,
//                 //   onChangeEnd: (newPosition) {
//                 //     _audioHandler.seek(newPosition);
//                 //   },
//                 // );
//               },
//             ),
//             // Display the processing state.
//             StreamBuilder<AudioProcessingState>(
//               stream: _audioHandler.playbackState
//                   .map((state) => state.processingState)
//                   .distinct(),
//               builder: (context, snapshot) {
//                 final processingState =
//                     snapshot.data ?? AudioProcessingState.idle;
//                 return Text(
//                     // ignore: deprecated_member_use
//                     "Processing state: ${describeEnum(processingState)}");
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// A stream reporting the combined state of the current media item and its
//   /// current position.
//   Stream<MediaState> get _mediaStateStream =>
//       Rx.combineLatest2<MediaItem?, Duration, MediaState>(
//           _audioHandler.mediaItem,
//           AudioService.position,
//           (mediaItem, position) => MediaState(mediaItem, position));

//   IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
//         icon: Icon(iconData),
//         iconSize: 64.0,
//         onPressed: onPressed,
//       );
// }

// class MediaState {
//   final MediaItem? mediaItem;
//   final Duration position;

//   MediaState(this.mediaItem, this.position);
// }

// /// An [AudioHandler] for playing a single item.
// class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
//   static final _item = MediaItem(
//     id: 'http://soundscape.boostproductivity.online/api/getmusic/Rain',
//     album: "Science Friday",
//     title: "A Salute To Head-Scratching Science",
//     artist: "Science Friday and WNYC Studios",
//     duration: const Duration(milliseconds: 5739820),

//     artUri: Uri.parse(
//         'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//   );
//   static final _item2 = MediaItem(
//     id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
//     album: "Science Friday",
//     title: "A Salute To Head-Scratching Science",
//     artist: "Science Friday and WNYC Studios",
//     duration: const Duration(milliseconds: 5739820),
//     artUri: Uri.parse(
//         'https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
//   );

//   final _player = AudioPlayer();
//   final _player2 = AudioPlayer();

//   /// Initialise our audio handler.
//   AudioPlayerHandler() {
//     // So that our clients (the Flutter UI and the system notification) know
//     // what state to display, here we set up our audio handler to broadcast all
//     // playback state changes as they happen via playbackState...
//     _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     // _player2.playbackEventStream.map(_transformEvent).pipe(playbackState);
//     // ... and also the current media item via mediaItem.
//     mediaItem.add(_item);
//     mediaItem.add(_item2);

//     // Load the player.
    
//     _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
//     _player2.setAudioSource(AudioSource.uri(Uri.parse(_item2.id)));
//   }

//   // In this simple example, we handle only 4 actions: play, pause, seek and
//   // stop. Any button press from the Flutter UI, notification, lock screen or
//   // headset will be routed through to these 4 methods so that you can handle
//   // your audio playback logic in one place.

//   @override
//   Future<void> play()async {
//   _player.play();
//   _player2.play();
//   }

//   @override
//   Future<void> pause()async{
//     _player.pause();
//     _player2.pause();
//   }

//   @override
//   Future<void> seek(Duration position) => _player.seek(position);

//   @override
//   Future<void> stop() => _player.stop();

//   /// Transform a just_audio event into an audio_service state.
//   ///
//   /// This method is used from the constructor. Every event received from the
//   /// just_audio player will be transformed into an audio_service state so that
//   /// it can be broadcast to audio_service clients.
//   PlaybackState _transformEvent(PlaybackEvent event) {
//     return PlaybackState(
//       controls: [
//         MediaControl.rewind,
//         if (_player.playing) MediaControl.pause else MediaControl.play,
//         MediaControl.stop,
//         MediaControl.fastForward,
//       ],
//       systemActions: const {
//         MediaAction.seek,
//         MediaAction.seekForward,
//         MediaAction.seekBackward,
//       },
//       androidCompactActionIndices: const [0, 1, 3],
//       processingState: const {
//         ProcessingState.idle: AudioProcessingState.idle,
//         ProcessingState.loading: AudioProcessingState.loading,
//         ProcessingState.buffering: AudioProcessingState.buffering,
//         ProcessingState.ready: AudioProcessingState.ready,
//         ProcessingState.completed: AudioProcessingState.completed,
//       }[_player.processingState]!,
//       playing: _player.playing,
//       updatePosition: _player.position,
//       bufferedPosition: _player.bufferedPosition,
//       speed: _player.speed,
//       queueIndex: event.currentIndex,
//     );
//   }
// }
