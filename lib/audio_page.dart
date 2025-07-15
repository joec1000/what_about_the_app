import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late final AnimationController _animationController;
  late final Animation<double> _rotationAnimation;
  late final AnimationController _warningController;
  late final Animation<double> _warningRotation;
  late final Animation<double> _warningOpacity;

  final List<double> _playSpeeds = [0.25, 0.5, 1.0, 2.0];
  int _playSpeedIndex = 2; // Index of initial playback speed (1.0)
  double _playSpeed = 1.0;
  bool isPlaying = false;
  bool _warningActive = false;

  @override
  void initState() {
    super.initState();
    _playSpeed = _playSpeeds[_playSpeedIndex];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _warningController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _warningRotation = Tween<double>(begin: 0, end: 1).animate(_warningController);
    _warningOpacity = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(parent: _warningController, curve: Curves.easeInOut),
    );
  }

  void _playAudio() async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('what_about.mp3'));
    await _audioPlayer.setPlaybackRate(_playSpeed);
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        _animationController.stop();
        _animationController.reset();
      });
    });

    setState(() {
      isPlaying = true;
    });
    _animationController.repeat();
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    _animationController.stop();
    _animationController.reset();
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

  void _toggleWarning() {
    setState(() {
      _warningActive = !_warningActive;
      if (_warningActive) {
        _warningController.repeat(reverse: true);
      } else {
        _warningController.stop();
        _warningController.reset();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _warningController.dispose();
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
                  children: [
                    const Center(
                      child: Icon(
                        Icons.phone_android,
                        size: 175,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: RotationTransition(
                        turns: _rotationAnimation,
                        child: const Icon(
                          Icons.help,
                          size: 50,
                          color: Colors.white,
                        ),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleWarning,
              child: Text(_warningActive ? 'Stop Warning' : 'Start Warning'),
            ),
            const SizedBox(height: 20),
            if (_warningActive)
              FadeTransition(
                opacity: _warningOpacity,
                child: RotationTransition(
                  turns: _warningRotation,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Warning!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
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
