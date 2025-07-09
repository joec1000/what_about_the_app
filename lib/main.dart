import 'package:flutter/material.dart';
import 'package:what_about/audio_page.dart';

void main() => runApp(AudioApp());

class AudioApp extends StatelessWidget {
  const AudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPage(),
    );
  }
}
