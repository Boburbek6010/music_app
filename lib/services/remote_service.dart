import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RemoteConfigService {
  static final remoteConfig = FirebaseRemoteConfig.instance;

  //backgroundColor of Scaffold
  static final Map<String, dynamic> predictableBackground = {
    "red": Colors.red,
    "yellow": Colors.yellow.shade700,
    "blue": Colors.blue.shade800,
    "green": Colors.green.shade800,
    "white": Colors.white,
  };
  static String backgroundColor = "yellow";


  //setting of all problem
  static final Map<String, dynamic> inCaseProblem = {
    "invisible": Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "😡",
              style: TextStyle(fontSize: 50),
            ),
            Text(
              "Shunaqa bo'ladi",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    ),
    "indicator": const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  };

  static Future<void> initConfig() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    await remoteConfig.setDefaults({
      "background_color": "yellow",
      "nervous_problem": "indicator",
    });
    await fetchConfig();
  }

  static Future<String> fetchConfig() async {
    String trouble = "";
    await remoteConfig.fetchAndActivate().then((value) => {
          // Color of Scaffold
          backgroundColor =
              remoteConfig.getString('background_color').isNotEmpty
                  ? remoteConfig.getString('background_color')
                  : 'red',
          debugPrint("BackgroundColor Remote config is worked: $value"),

          // setting of all problem
      trouble = remoteConfig.getString('nervous_problem').isNotEmpty
              ? remoteConfig.getString('nervous_problem')
              : 'indicator',

          //
          // // setting of indicator
          // backgroundColor = remoteConfig.getString('nervous_problem').isNotEmpty
          //     ? remoteConfig.getString('nervous_problem')
          //     : 'indicator',
          // debugPrint("Problem Remote config is worked: $value"),
        },

    );
    return trouble;  }
}
