import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/music_model.dart';
import 'home_page.dart';

class PlayerPage extends StatefulWidget {
  static const id = "/player_page";

  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
    audioPlayer.dispose();
  }

  Future<void> nextSeek() async {
    await assetsAudioPlayer.seekBy(const Duration(seconds: 10));
  }

  Future<void> prevSeek() async {
    await assetsAudioPlayer.seekBy(const Duration(seconds: -10));
  }

  void goBack(){
    Navigator.of(context).pushNamed(HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          //image
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(-1, -0.7),
                  child: IconButton(
                    splashColor: Colors.white,
                    color: Colors.white,
                    splashRadius: 25,
                    onPressed: goBack,
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 40,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints.expand(),
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/images/background_person.svg")),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 15,
                          color: Colors.black,
                          blurRadius: 60,
                          // blurStyle: BlurStyle.outer,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(500),
                          bottomLeft: Radius.circular(500))),
                ),
              ],
            ),
          ),

          //name
          Expanded(
            flex: 1,
            child: nameOfSong(
              oldMusicIndex != null
                  ? musics[oldMusicIndex!]
                  : Music("", "", "assetMusic"),
            ),
          ),

          //indicator
          Expanded(
            child: StreamBuilder<DurationState>(
              // stream: _durationState,
              builder: (context, snapshot) {

                final durationState = snapshot.data;
                final progress = durationState?.progress ?? Duration.zero;
                final buffered = durationState?.buffered ?? Duration.zero;
                final total = durationState?.total ?? Duration.zero;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.bottomCenter,
                  child: ProgressBar(
                    thumbGlowRadius: 35,
                    thumbRadius: 15,
                    thumbColor: Colors.blue.shade900,
                    bufferedBarColor: Colors.indigo,
                    progressBarColor: Colors.indigo,
                    baseBarColor: Colors.indigoAccent,
                    progress: progress,
                    buffered: buffered,
                    total: total,
                    onSeek: (duration) {
                      print('User selected a new time: $duration');
                    },
                  ),
                );
              },
            ),
          ),

          //Navigator Bar
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 60),
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width,
                  child: bottomShowBar(
                    oldMusicIndex != null
                        ? musics[oldMusicIndex!]
                        : Music("", "", "assetMusic"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget nameOfSong(Music music) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        music.title,
        style: const TextStyle(
          fontSize: 26,
          letterSpacing: 2,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomShowBar(Music music) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              assetsAudioPlayer.shuffle;
            },
            icon: const Icon(
              CupertinoIcons.backward_end,
              color: Colors.white,
            ),
          ),
          IconButton(
              color: Colors.red,
              splashColor: Colors.blue,
              onPressed: () => prevSeek(),
              icon: const Icon(CupertinoIcons.backward_fill,
                  color: Colors.white)),
          FloatingActionButton(
            child: !isPause
                ? const Icon(
                    Icons.play_arrow,
                    size: 35,
                  )
                : const Icon(
                    Icons.pause,
                    size: 35,
                  ),
            onPressed: () {
              setState(() {});
              isPause = !isPause;
              assetsAudioPlayer.playOrPause();
            },
          ),
          IconButton(
              color: Colors.red,
              splashColor: Colors.blue,
              onPressed: () => nextSeek(),
              icon: const Icon(
                CupertinoIcons.forward_fill,
                color: Colors.white,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.forward_end,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
class DurationState {
  // DurationState({required this.progress, required this.buffered});
  final Duration progress = Duration(seconds: 7);
  final Duration buffered = Duration(seconds: 3);
  final Duration total = Duration(seconds: 10);
}
