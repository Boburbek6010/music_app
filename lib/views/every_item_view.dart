import '../models/music_model.dart';
import 'package:flutter/material.dart';

class MusicView extends StatelessWidget {
  const MusicView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Music? music;
    return Container(
      height: 70,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
