import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';



class AudioPlayerWidget extends StatefulWidget {
  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playAudio(String audioUrl) async {
    try {
      
      await _player.setUrl(audioUrl);
      // await _player.setUrl(audioUrl);
      await _player.play();
    } catch (e) {
      print("coming here00------------------------------------------->");
      print('Error playing audio: $e');
    }
  }

  void _pauseAudio() async {
    await _player.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () => _playAudio('http://soundscape.boostproductivity.online/api/getmusic/Relax-Lofi'),
          ),
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: _pauseAudio,
          ),
        ],
      ),
    );
  }
}



