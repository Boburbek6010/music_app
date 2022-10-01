import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/pages/splash_page.dart';
import '../services/remote_service.dart';

class IntroPage extends StatefulWidget {
  static const id = "intro_page";

  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  bool changeEverything = false;

  fetchDataFromCloud()async{
    final instance = FirebaseFirestore.instance;
    const String mainFolder = 'me';
    final DocumentSnapshot<Map<String, dynamic>> query =
    await instance.collection(mainFolder).doc("1").get();
    changeEverything = !query.data()!["isQori"];
    setState(() {});
  }




  String trouble = "indicator";

  void _next() async {
    await Future.delayed(const Duration(seconds: 4));
    changeEverything ?const SizedBox.shrink()
        :_goWelcome();
  }

  void _goWelcome() {
    Navigator.pushReplacementNamed(context, SplashPage.id);
  }

  void fetchData()async{
   trouble = await RemoteConfigService.fetchConfig();
   setState(() {

   });
  }



  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataFromCloud();
    _next();
  }

  @override
  Widget build(BuildContext context) {
    return changeEverything
        ? RemoteConfigService.inCaseProblem[trouble]
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Lottie.asset("assets/lotties/man_staying.json")),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          "Jonli Ijrodagi",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.green.shade700,
                                  // blurRadius: 2,
                                  offset: const Offset(2, 2))
                            ],
                          ),
                        ),
                        Text(
                          "Abdusalomov Ilhomjonning",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.green.shade700,
                                  // blurRadius: 2,
                                  offset: const Offset(2, 2))
                            ],
                          ),
                        ),
                        Text(
                          " sara qo'shiqlar namunasiga",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.green.shade700,
                                  // blurRadius: 2,
                                  offset: const Offset(2, 2))
                            ],
                          ),
                        ),
                        Text(
                          " hush kelibsiz",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                  color: Colors.green.shade700,
                                  // blurRadius: 2,
                                  offset: const Offset(2, 2))
                            ],
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
}
