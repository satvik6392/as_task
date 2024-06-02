import 'dart:convert';

import 'package:soundscape/models/effect_model.dart';
import 'package:soundscape/myhelper/constants/constants_strings.dart';
import 'package:http/http.dart' as http;
// import 'package:soundscape/view/home/%E1%B9%A3ound_effect.dart';

import '../models/song_model.dart';

class ApiServices{
  static Future<dynamic> getAudio()async{
    const url = ApiUrls.getSongs;
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200)
      {
       final data = jsonDecode(response.body)['data'];
        List<AudioModel> audioList = [];
        data.forEach((jsonItem) {
          audioList.add(AudioModel.fromJson(jsonItem));
        }); 
        return audioList;
      }else{
        print(response.statusCode);
        return null;
      }
    }catch(err)
    {
      print(err);
      return null;
    }
  }

  static Future<dynamic> getSoundEffect() async{
    const url = ApiUrls.getEffects;
    List<List<SoundEffectModel>> effectList = [];
    for(var item in ApiUrls.effects)
    {
      try{
      final response = await http.get(Uri.parse(url+item));
      if(response.statusCode == 200)
      {
       final data = jsonDecode(response.body)['data'];
        List<SoundEffectModel> soundeffects = [];
        data.forEach((jsonItem) {
          soundeffects.add(SoundEffectModel.fromJson(jsonItem));
        }); 
        print('respones -> ${response.statusCode}');
        print('list ->$soundeffects');
        effectList.add(soundeffects);
        print('effectList $item -> $effectList');
        // return audioList;
      }else{
        // print('respones -> ${response.statusCode}');
        effectList.add([]);
        // print(effectList);
        // print(response.statusCode);
        // return null;
      }
    }catch(err)
    {
      print(err);
      // return null;
    }
    }
    return effectList;
  }
}