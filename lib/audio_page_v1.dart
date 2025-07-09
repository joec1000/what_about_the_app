import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<double> _playSpeeds = [0.25, 0.5, 1.0, 2.0];
  int _playSpeedIndex = 2; // Index of initial playback speed (1.0)
  double _playSpeed = 1.0;
  bool isPlaying = false;

  void _playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('what_about.mp3'));
    await _audioPlayer.setPlaybackRate(_playSpeed);
    setState(() {
      isPlaying = true;
    });
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void _toggleSpeed() async {
    _playSpeedIndex = (_playSpeedIndex + 1) % _playSpeeds.length;
    setState(() {
      _playSpeed = _playSpeeds[_playSpeedIndex];
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What About'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 70.0, right: 70.0, bottom: 40.0),
              child: Image.asset('images/sh_logo.png'),
            ),
            GestureDetector(
              onTap: _playAudio,
              onLongPress: _toggleSpeed,
              child: Container(
                width: 250,
                height: 250,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    Center(
                      child: Icon(
                        Icons.phone_android,
                        size: 175,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Icon(
                        Icons.help,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _playAudio,
              child: Text(
                'Tap to Play Audio (${_playSpeed ?? '1'}x)',
                style: const TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isPlaying ? _stopAudio : _playAudio,
        backgroundColor: Colors.blue,
        child: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
      ),
    );
  }
}
