import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/models/music_model.dart';
import 'package:music_app/pages/player_page.dart';
import '../services/remote_service.dart';


class HomePage extends StatefulWidget {
  static const id = "/home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

bool isPause = false;
bool isPlaying = false;
int? oldMusicIndex;
 final musics = [
  Music("09:26", "Aziz do'stlarim", "assets/audios/dostlarim.mp3"),
  Music("08:22", "Diydalar", "assets/audios/diydalar.mp3"),
  Music("09:07", "Bobo dehqon", "assets/audios/dehqon.mp3"),
  Music("07:53", "Do'st bo'lsang", "assets/audios/dostbolsang.mp3"),
  Music("05:01", "Eshigingdan", "assets/audios/eshigingdan.mp3"),
  Music("05:38", "Gul bo'ylari", "assets/audios/gulboylari.mp3"),
  Music("04:39", "Mandini sandin o'zga", "assets/audios/mandinozga.mp3"),
  Music("10:04", "O'ldirur", "assets/audios/O'ltirur.mp3"),
  Music("04:56", "Oq qayin", "assets/audios/oqqayin.mp3"),
  Music("06:16", "Otam", "assets/audios/otem.mp3"),
  Music("09:32", "Sadogangman", "assets/audios/sadogangman.mp3"),
  Music("06:23", "Aziz Odamlar", "assets/audios/azizodamlar.mp3"),
  Music("04:54", "Iqboling", "assets/audios/iqboling.mp3"),
  Music("05:00", "Nodira", "assets/audios/nodira.mp3"),
  Music("04:52", "Yorim Bo'lsang", "assets/audios/yorimbo'lsang.mp3"),
  Music("04:24", "Ota Ona", "assets/audios/otaona.mp3"),
  Music("05:18", "Tamanno", "assets/audios/tamanno.mp3"),
  Music("05:39", "Yana bahor", "assets/audios/yanabahor.mp3"),
];

class _HomePageState extends State<HomePage> {


  final assetsAudioPlayer = AssetsAudioPlayer.withId("0");
  AudioPlayer audioPlayer = AudioPlayer();
  bool changeBackground = false;


  @override
  void initState() {
    super.initState();
    _goInfo();
  }

  void _goInfo()async{
    await RemoteConfigService.initConfig();
  }


  // @override
  // void dispose() {
  //   super.dispose();
  //   assetsAudioPlayer.dispose();
  //   audioPlayer.dispose();
  // }

  void nextSeek() async {
    await assetsAudioPlayer.seekBy(const Duration(seconds: 10));
  }

  void prevSeek() async {
    await assetsAudioPlayer.seekBy(const Duration(seconds: -10));
  }

  void _playingSongs(String assetsPath, {int? index}) {
    isPause = isPause ? index != oldMusicIndex : true;
    oldMusicIndex = index;
    setState(() {});
    isPause
        ? assetsAudioPlayer.open(Audio(assetsPath),
            showNotification: true,
            notificationSettings: const NotificationSettings())
        : assetsAudioPlayer.stop();
    goPlayer();
  }

  void goPlayer() {
    Navigator.of(context).pushNamed(PlayerPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: changeBackground
                ? RemoteConfigService
                    .predictableBackground[RemoteConfigService.backgroundColor]
                : Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              toolbarHeight: 40,
              title: const Text("Jonli Ijro"),
              backgroundColor: Colors.blue.withOpacity(0.5),
            ),
            body: Stack(
              children: [
                Container(
                  decoration: !changeBackground ? const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/background_person.svg')),
                  )
                  :const BoxDecoration(),
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 13,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: List.generate(
                              musics.length,
                              (index) => items1(music: musics[index], index: index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget items1({required Music music, required int index}) {
    return AnimatedContainer(
      height: 60,
      margin: const EdgeInsets.all(20),
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 30,
          spreadRadius: 5,
          offset: const Offset(0, 0),
          color: Colors.black.withOpacity(0.7),
        ),
      ]),
      child: MaterialButton(
        splashColor: Colors.lightBlueAccent.shade700,
        padding: const EdgeInsets.only(left: 30, right: 30),
        shape: const StadiumBorder(),
        onPressed: () => _playingSongs(music.assetMusic, index: index),
        color: Colors.lightBlueAccent.withOpacity(0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              music.title,
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(music.length),
          ],
        ),
      ),
    );
  }
}
