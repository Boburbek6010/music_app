// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:music_app/pages/sign_up_page.dart';
// import 'package:music_app/pages/splash_page.dart';
// import '../services/auth_services.dart';
// import '../services/db_service.dart';
// import '../services/util_service.dart';
// import 'home_page.dart';
// import 'intro_page.dart';
// class SignInPage extends StatefulWidget {
//   static const id = "/sign_in_page";
//   const SignInPage({Key? key}) : super(key: key);
//
//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignInPage> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool isLoading = false;
//
//   void _doRegister() {
//     print("doRegister");
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     if (email.isEmpty || password.isEmpty) {
//       Utils.fireSnackBar("Please fill all gaps first", context);
//       return;
//     }
//     setState(() {});
//     isLoading = true;
//     AuthService.signInUser(context, email, password).then((user) => _checkUser(user));
//   }
//
//   void _checkUser(User? user) async {
//     print("checkUser");
//     if (user != null) {
//       await PrefService.savaData(user.uid);
//       if (mounted) Navigator.pushReplacementNamed(context, HomePage.id);
//     } else {
//       Utils.fireSnackBar("Check your data and try again", context);
//     }
//     isLoading = false;
//     setState(() {});
//   }
//
//   void _goSignUp() {
//     print("goSignUp");
//     Navigator.pushReplacementNamed(context, SignUpPage.id);
//   }
//
//   static void checkLogin(){
//     print("check user");
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
//   @override
//   void initState() {
//     print("init state");
//     checkLogin();
//     // AuthService.checkLogin();
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState != ConnectionState.active) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         final user = snapshot.data;
//         if (user != null &&
//             FirebaseAuth.instance.currentUser?.emailVerified != true) {
//           print("user is logged in");
//           print(user);
//           return const SplashPage();
//         } else {
//           print("user is not logged in");
//           return Scaffold(
//             body: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           colors: [
//                             Colors.yellow.shade700,
//                             Colors.red.shade900
//                           ]
//                       ),
//                     ),
//                     height: MediaQuery.of(context).size.height,
//                     padding: const EdgeInsets.all(45),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             alignment: Alignment.topRight,
//                             margin: const EdgeInsets.only(top: 20, bottom: 50),
//                             child: TextButton(
//                               style: ButtonStyle(
//                                 // elevation: MaterialStateProperty.all(15),
//                                   minimumSize: MaterialStateProperty.all(const Size(80, 0)),
//                                   backgroundColor: MaterialStateProperty.all(Colors.transparent)
//                               ),
//                               onPressed: (){
//                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashPage()));
//                               },
//                               child: const Text("Skip", style: TextStyle(
//                                   fontSize: 17
//                               ),),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 5,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//
//                               Container(
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   // color: Colors.red,
//                                     borderRadius: BorderRadius.circular(30),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                         color: Colors.white,
//                                       )
//                                     ]
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     // #email
//                                     TextField(
//                                       controller: emailController,
//                                       decoration: const InputDecoration(
//                                         hintText: "Email",
//                                       ),
//                                       style: const TextStyle(fontSize: 18, color: Colors.black),
//                                       keyboardType: TextInputType.emailAddress,
//                                       textInputAction: TextInputAction.next,
//                                     ),
//                                     const SizedBox(height: 20,),
//
//                                     // #password
//                                     TextField(
//                                       controller: passwordController,
//                                       decoration: const InputDecoration(
//                                         hintText: "Password",
//                                       ),
//                                       style: const TextStyle(fontSize: 18, color: Colors.black),
//                                       keyboardType: TextInputType.visiblePassword,
//                                       textInputAction: TextInputAction.done,
//                                       obscureText: true,
//                                     ),
//                                     const SizedBox(height: 20,),
//                                   ],
//                                 ),
//                               ),
//
//                               const SizedBox(height: 30,),
//                               // #sign_in
//                               ElevatedButton(
//                                 onPressed: _doRegister,
//                                 style: ElevatedButton.styleFrom(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(30)
//                                     ),
//                                     minimumSize: const Size(double.infinity, 50)
//                                 ),
//                                 child: const Text("Sign In", style: TextStyle(fontSize: 16),),
//                               ),
//                               const SizedBox(height: 20,),
//
//                               // #sign_up
//                               RichText(
//                                 text: TextSpan(
//                                     style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
//                                     children: [
//                                       const TextSpan(
//                                         text: "Don't have an account?  ",
//                                       ),
//                                       TextSpan(
//                                         style: const TextStyle(color: Colors.white),
//                                         text: "Sign Up",
//                                         recognizer: TapGestureRecognizer()..onTap = _goSignUp,
//                                       ),
//                                     ]
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Visibility(
//                   visible: isLoading,
//                   child: const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }
