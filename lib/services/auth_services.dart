// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:music_app/pages/sign_in_page.dart';
// import 'package:music_app/pages/splash_page.dart';
// import 'package:music_app/services/util_service.dart';
//
// import '../pages/sign_up_page.dart';
// import 'db_service.dart';
//
//
// class AuthService{
//   static final _auth = FirebaseAuth.instance;
//
//   static Future<User?>signUpUser(BuildContext context, String email, String password, String name)async{
//     try{
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       var user = credential.user;
//       await _auth.currentUser?.updateDisplayName(name);
//       return user;
//     }catch(e){
//       debugPrint(e.toString());
//       Utils.fireSnackBar(e.toString(), context);
//     }
//     return null;
//   }
//
//
//   static void checkLogin(){
//     StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.active) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final user = snapshot.data;
//         if (user != null &&
//             FirebaseAuth.instance.currentUser?.emailVerified == true) {
//           print("user is logged in");
//           print(user);
//           return SplashPage();
//         } else {
//           print("user is not logged in");
//           return SignInPage();
//         }
//       },
//     );
//   }
//
//
//   static Future<User?>signInUser(BuildContext context, String email, String password)async{
//     try{
//       UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return credential.user;
//     }catch(e){
//       debugPrint(e.toString());
//       Utils.fireSnackBar(e.toString(), context);
//     }
//     return null;
//   }
//
//
//   static Future<void>signOutUser(BuildContext context)async{
//     await _auth.signOut();
//     PrefService.removeData().then((value) {});
//     Utils.fireSnackBar("You have logged Out", context);
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
//   }
//
//
// }