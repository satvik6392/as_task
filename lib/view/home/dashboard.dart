import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soundscape/bloc/audio_bloc/bloc/audio_bloc.dart';
import 'package:soundscape/models/song_model.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/myhelper/textstyles/textstyles.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundscape/view/home/bgadtask.dart';
import 'package:soundscape/view/home/sound_effects.dart';
import '../auth/auth_home.dart';
import 'package:audio_service/audio_service.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // List<AudioModel> originalList = [];
  bool shuffle = false;
  List<AudioModel> musicList = [];
  // final AudioPlayer AudioPlayerHandler.player = AudioPlayer();
  int? _currentIndex;
  AudioModel? currentSong;
  AudioModel? loopSong;

  @override
  void dispose() {
    AudioPlayerHandler.player.dispose();
    super.dispose();
  }

  StreamSubscription<PlayerState>? playerStateSubscription;

  void _autoNextandLoop() async {
    // Play the audio

    // Listen for player state changes
    playerStateSubscription =
        AudioPlayerHandler.player.playerStateStream.listen((playerState) async {
      // Check if the song has ended
      if (playerState.processingState == ProcessingState.completed) {
        // Check if looping is enabled
        if (loopSong != null) {
          print("coingg herejsdhfkjdfssdnf------------->1");
          // If looping is enabled, seek to the beginning and play again
          AudioPlayerHandler.player.seek(Duration.zero);

          await _playAudio(_currentIndex!);
        }else if(shuffle)
        {
          _playAudio(Random().nextInt(musicList.length));
        } else{
          print(loopSong);
          // If looping is not enabled, play the next song automatically
          _playNext();
        }
      }
    });
  }

  Future _playAudio(int index) async {
    try {
      print(1);
      await AudioPlayerHandler.player.setAudioSource(
          initialIndex: index,
          preload: true,
          AudioSource.uri(Uri.parse(musicList[index].assetPath),
              tag: MediaItem(
                  id: musicList[index].id.toString(),
                  title: musicList[index].name)),);
      // await AudioPlayerHandler.player.setUrl(musicList[index].assetPath);
      print(2);

      setState(() {
        _currentIndex = index;
      });
      setState(() {
        currentSong = musicList[index];
      });
      await AudioPlayerHandler.player.play();
      print(3);
      print(AudioPlayerHandler.player.playing);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _pauseAudio() async {
    setState(() {});
    await AudioPlayerHandler.player.pause();
    if(AudioPlayerHandler.player2.playing)
    {
      await AudioPlayerHandler.player2.pause();
    }
    
  }

  void _resumeAudio() async {
    setState(() {});
    AudioPlayerHandler.player.play();
    AudioPlayerHandler.player2.play();
  }

  // void _loopCurrentSong(int index) async {
  //   // await _playAudio(index);

  //   AudioPlayerHandler.player.playerStateStream.listen((playerState) {
  //     if (playerState.processingState == ProcessingState.completed) {
  //       AudioPlayerHandler.player.seek(Duration.zero);
  //       AudioPlayerHandler.player.play();
  //     }
  //   });
  //   setState(() {
  //     loopSong = musicList[index];
  //   });
  // }

  void _stopLoop() async {
    // await AudioPlayerHandler.player.pause();
    setState(() {
      loopSong = null;
    });
  }
  void _shufflePlay() {
    // originalList = musicList;
    setState(() {
      
    });
    shuffle = !shuffle;
    if(shuffle)
    {
      _playAudio(Random().nextInt(musicList.length));
    }
    // musicList.shuffle();
    // _playAudio(0);
    // setState(() {
    //   _currentIndex = 0;
    // });
  }

  // void _playAll() async {
  //   for (var music in musicList) {
  //     await AudioPlayerHandler.player.setUrl(music.assetPath);
  //     await AudioPlayerHandler.player.play();
  //     await AudioPlayerHandler.player.positionStream
  //         .firstWhere((position) => position == AudioPlayerHandler.player.duration);
  //   }
  // }

  void _playPrevious() {
    setState(() {});
    if (_currentIndex! > 0) {
      _currentIndex = _currentIndex! - 1;
      _playAudio(_currentIndex!);
    }
  }

  void _playNext() {
    setState(() {});
    if(shuffle)
    {
      _playAudio(Random().nextInt(musicList.length));
    }
    else if (_currentIndex! < musicList.length - 1) {
      _currentIndex = _currentIndex! + 1;
      _playAudio(_currentIndex!);
    } else {
      _pauseAudio();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      _autoNextandLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioBloc()..add(GetAudioEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.appBackgroundColor,
          body: Column(
            children: [
              Container(
                height: 174,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF5B5F97),
                      Color(0x005B5F97), // Equivalent to rgba(91, 95, 151, 0)
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/Vector1.png',
                        color: const Color(0xB2FFFFFF),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/Vector2.png',
                        color: const Color(0x4DFFFFFF),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () async {
                          SharedPreferences sp =
                              await SharedPreferences.getInstance();
                          await sp.clear();
                          navigatorPushReplace(const AuthHomePage());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/images/mdi_logout.png",
                            color: const Color(0xCCFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 34,
                      bottom: 12,
                      child: SizedBox(
                        height: 75,
                        width: 75,
                        child: Image.asset(
                          'assets/images/Bitmap.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      bottom: 26,
                      child: Text(
                        "TIRED",
                        style: MyTextStyle.onBoaringContentText.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dashboardButton(
                    text: 'Play all',
                    imgPath: 'assets/images/play_icon.png',
                    color: Colors.white,
                    function: () {
                      _playAudio(0);
                    },
                  ),
                  SizedBox(width: 10),
                  dashboardButton(
                    text: 'Shuffle',
                    imgPath: 'assets/images/suffle_icon.png',
                    color: shuffle ? Colors.blue:Colors.white,
                    function: () {
                      _shufflePlay();
                    },
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<AudioBloc, AudioState>(
                  builder: (context, state) {
                    if (state is AudioLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is AudioSuccess) {
                      final list = state.audioList;
                      musicList = list;
                      AudioPlayerHandler.audioList = list;
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await _playAudio(index);
                            },
                            child: ListTile(
                              title: Text(
                                list[index].name,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text(
                        "Failed",
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  },
                ),
              ),
              currentSong != null
                  ? Container(
                      height: 120,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F2F2F),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Text(
                                    musicList[_currentIndex!].name,
                                    style: MyTextStyle.onBoaringContentText
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      _playPrevious();
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'assets/images/skip-back.png',
                                          fit: BoxFit.cover,
                                          color: (_currentIndex! > 0)
                                              ? Colors.white
                                              : Colors.grey,
                                        ))),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (AudioPlayerHandler.player.playing) {
                                        _pauseAudio();
                                      } else {
                                        _resumeAudio();
                                      }
                                    },
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: AudioPlayerHandler.player.playing
                                            ? Image.asset(
                                                'assets/images/pause.png',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset('assets/images/play_button.png'))),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      _playNext();
                                    },
                                    child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          'assets/images/skip-next.png',
                                          fit: BoxFit.cover,
                                          color: (_currentIndex! >=
                                                  musicList.length - 1)
                                              ? Colors.grey
                                              : Colors.white,
                                        ))),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (loopSong == null) {
                                      loopSong = musicList[_currentIndex!];
                                      print(loopSong);
                                    } else {
                                      loopSong = null;
                                    }
                                    setState(() {});
                                    print("coming herere");
                                    // _autoNextandLoop();
                                  },
                                  child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: Image.asset(
                                        'assets/images/repeat.png',
                                        fit: BoxFit.cover,
                                        color: loopSong != null
                                            ? Colors.blue
                                            : Colors.grey,
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      navigatorPush(SoundEffect());
                                    },
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'assets/images/effects_icon.png',
                                        fit: BoxFit.cover,
                                        color: Colors.white,
                                      ),
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     if (AudioPlayerHandler.player.playing)
                            //       IconButton(
                            //         icon: Icon(Icons.pause),
                            //         onPressed: _pauseAudio,
                            //       ),
                            //     if (!AudioPlayerHandler.player.playing)
                            //       IconButton(
                            //         icon: Icon(Icons.play_arrow),
                            //         onPressed: () => _playAudio(
                            //             'http://soundscape.boostproductivity.online/api/getmusic/Relax-Lofi'),
                            //       ),
                            //   ],
                            // ),
                            StreamBuilder<Duration>(
                              stream: AudioPlayerHandler.player.positionStream,
                              builder: (context, snapshot) {
                                final position = snapshot.data ?? Duration.zero;
                                final duration = AudioPlayerHandler.player.duration;
                                final maxDuration =
                                    duration?.inSeconds.toDouble() ?? 0.0;

                                // If the duration is 0, handle it appropriately to avoid the Slider assertion error
                                if (maxDuration == 0.0) {
                                  return Text(
                                      'Waiting for audio duration...'); // Placeholder or handle appropriately
                                }

                                return Slider(
                                  value: position.inSeconds
                                      .toDouble()
                                      .clamp(0.0, maxDuration),
                                  min: 0.0,
                                  max: maxDuration,
                                  onChanged: (value) async {
                                    await AudioPlayerHandler.player
                                        .seek(Duration(seconds: value.toInt()));
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  // // Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFF2F2F2F),
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(10),
                  //       topRight: Radius.circular(10),
                  //     ),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Text("Song name"),
                  //           ],
                  //         ),
                  //         Text("seekbar"),
                  //       ],
                  //     ),
                  //   ),
                  // )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

Widget dashboardButton({
  required String text,
  required String imgPath,
  required Function function,
  required Color color,
}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      height: 40,
      width: 155,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.headingTextColor, width: 1),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 12,
              width: 10,
              child: Image.asset(imgPath,color: color,),
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: MyTextStyle.onBoaringContentText.copyWith(
                color: color,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
