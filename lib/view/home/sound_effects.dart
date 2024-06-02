import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundscape/bloc/audio_bloc/bloc/audio_bloc.dart';
import 'package:soundscape/controller/effect_controller.dart';
import 'package:soundscape/myhelper/colors/colors.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:soundscape/myhelper/navigation/navigator.dart';
import 'package:soundscape/myhelper/textstyles/textstyles.dart';
import 'package:soundscape/view/home/bgadtask.dart';

import '../../models/effect_model.dart';

class SoundEffect extends StatefulWidget {
  const SoundEffect({super.key});

  @override
  State<SoundEffect> createState() => _SoundEffectState();
}

class _SoundEffectState extends State<SoundEffect> {
  // List<SoundEffectModel> effects = [];
  // final AudioPlayer _player2 = AudioPlayer();
  // SoundEffectModel? _currentEffect;

  
   Future _playAudio(SoundEffectModel effect) async {
    try {
      print(1);
      // await _player2.setAudioSource(
      //   initialIndex: effect.id,
      //   preload: true,
      //   AudioSource.uri(Uri.parse(effect.assetPath),tag: MediaItem(id: 'effect'+effect.id.toString(), title: effect.name))
      // );
      await AudioPlayerHandler.player2.setUrl(effect.assetPath);
      print(2);

      // setState(() {
      //   _currentIndex = index;
      // });
      setState(() {
        EffectController.currentEffect = effect;
      });
      await AudioPlayerHandler.player2.play();
      print(3);
      print(AudioPlayerHandler.player2.playing);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  void _pauseAudio() async {
    setState(() {});
    EffectController.currentEffect = null;
    await AudioPlayerHandler.player2.pause();
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioBloc()..add(GetEffectEvent()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: MyColors.appBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 174,
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            goBack();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text("SOUND EFFECTS",
                            style: MyTextStyle.headingStyle.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 24)),
                      ],
                    ),
                  ),
                ),
                EffectController.currentEffect!=null ?
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, bottom: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PLAYING",
                        style: MyTextStyle.headingStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(EffectController.currentEffect!.image),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: IconButton(onPressed: (){
                                _pauseAudio();
                              }, icon: Icon(Icons.remove_circle,color: Colors.red,)))
                          ]
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: MyColors.contentTextColor,
                        // height: 2.2,
                        thickness: 2.2,
                      ),
                    ],
                  ),
                ):SizedBox.shrink(),
                BlocConsumer<AudioBloc, AudioState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is EffectSuccess) {
                      // print("state data -> ${state.effectList}");
                      // return SizedBox.shrink();
                      return Column(
                        children: [
                          for (int index = 0;
                              index < state.effectList.length;
                              index++)
                            effectWidget(
                                effects: state.effectList[index], i: index),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )

                // effectWiget(effects: [], i: 1),
                // effectWiget(effects: [], i: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
Widget headingText({required String heading}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Text(
        heading,
        style: MyTextStyle.headingStyle
            .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

Widget effectWidget({required List<SoundEffectModel> effects, required int i}) {
  print(effects);
  return Column(
    children: [
      headingText(heading: ApiUrls.effects[i]),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Container(
          width: double.infinity,
          // height: 250,
          child: GridView.builder(
            shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150.0, // Maximum extent for each item
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: effects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      
                    });
                    _playAudio(effects[index]);
                  },
                  child: Image.asset(effects[index].image));
              }),
        ),
      )
    ],
  );
}

}
