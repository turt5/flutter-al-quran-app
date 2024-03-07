// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// final player = AudioPlayer();

// void playAudio(
//     int index, Map<String, dynamic> audioSrc, BuildContext context) async {
//   String url = audioSrc['audio'];
//   print("URL: $url");
//   try {
//     await player.play(UrlSource(
//         "https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3"));
//   } catch (e) {
//     String error = e.toString();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: new Text(error),
//       ),
//     );
//   }
// }

// void stopAudio() async {
//   await player.stop();
// }
