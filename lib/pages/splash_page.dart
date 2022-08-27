import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/pages/home_page.dart';

import '../services/util_service.dart';

class SplashPage extends StatefulWidget {
  static const id = '/splash_page';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  void message(){
    Utils.fireSnackBar("Siz ro'yxatdan o'tgansiz", context);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      message();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ilhomjon Abdusalomov qo'shiqlari"),
        // backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.yellowAccent
            ]
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Lottie.asset("assets/lotties/splash_music.json")
            ),
            const SizedBox(height: 50,),
            MaterialButton(
              height: 50,
              minWidth: 130,
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
              },
              shape: const StadiumBorder(),
              color: Colors.indigo.shade400,
              splashColor: Colors.purple,
              child: const Text("Next"),
            )
          ],
        ),
      ),
    );
  }
}
