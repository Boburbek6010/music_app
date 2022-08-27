import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_app/pages/sign_in_page.dart';

import '../services/auth_services.dart';
import '../services/db_service.dart';
import '../services/util_service.dart';
class SignUpPage extends StatefulWidget {
  static const id = "/sign_up_page";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;


  void _signUp(){
    String firstName = firstnameController.text.trim();
    String lastName = lastnameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = "$firstName $lastName";

    if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty){
      Utils.fireSnackBar("Fill all gaps first", context);
      return;
    }

    isLoading = true;
    setState(() {});

    AuthService.signUpUser(context, email, password, name).then((user) => _checkNewUser(user));
  }


  void _checkNewUser(User? user)async{
    if(user != null){
      await PrefService.savaData(user.uid);
      if(mounted)Navigator.pushReplacementNamed(context, SignInPage.id);
    }else{
      Utils.fireSnackBar("Check your data and try again", context);
    }
    isLoading = false;
    setState(() {});
  }

  void _catchError(){
    Utils.fireSnackBar("Smth went wrong", context);
    isLoading = false;
    setState(() {});
  }

  void _goSignIn(){
    Navigator.pushReplacementNamed(context,SignInPage.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.yellow.shade700,
                      Colors.red.shade900
                    ]
                ),
              ),
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                          )
                        ]
                    ),
                    child: Column(
                      children: [
                        // #name
                        TextField(
                          controller: firstnameController,
                          decoration: const InputDecoration(
                            hintText: "Firstname",
                          ),
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20,),

                        //last name
                        TextField(
                          controller: lastnameController,
                          decoration: const InputDecoration(
                            hintText: "Lastname",
                          ),
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20,),

                        //email
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                          ),
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20,),

                        //password
                        TextField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password",
                          ),
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          // obscureText: true,
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30,),
                  // #sign_in
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      ),
                        minimumSize: const Size(double.infinity, 50)
                    ),
                    child: const Text("Sign Up", style: TextStyle(fontSize: 16),),
                  ),
                  const SizedBox(height: 20,),

                  // #sign_up
                  RichText(
                    text:  TextSpan(
                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                        children: [
                          const TextSpan(
                            text: "Already have an account?  ",
                          ),
                          TextSpan(
                            style: const TextStyle(color: Colors.white),
                            text: "Sign In",
                            recognizer: TapGestureRecognizer()..onTap = _goSignIn,
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ),

          Visibility(
            visible: isLoading,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
