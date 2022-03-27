import 'package:applicatioin_task/all_screens/register_screen.dart';
import 'package:applicatioin_task/model/doctor.dart';
import 'package:applicatioin_task/widgets/components.dart';
import 'package:applicatioin_task/widgets/prograss_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String idScreen = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var passwordController = TextEditingController();

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 35.0,
              ),
              Image.asset(
                'assets/images/Medicine-login.png',
                height: 250,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Welcome To Medical Center',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: color3),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(fontSize: 14),
                          hintStyle: TextStyle(color: grey, fontSize: 10)),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10)),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    RaisedButton(
                      elevation: 0,
                      color: color4,
                      textColor: Colors.white,
                      child: const SizedBox(
                        height: 60,
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      onPressed: () {
                        LoginAuthUser(context);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Do\'t have account ? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RegisterScreen.idScreen);
                          },
                          child: Text(
                            'Register now',
                            style: TextStyle(color: color5),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth? firebaseAuth = FirebaseAuth.instance;

  void LoginAuthUser(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: 'Authenticating,please wait..',
            ),
        barrierDismissible: false);

    final UserCredential firebaseUser = await (firebaseAuth!
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .catchError((error) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'error>>>$error');
    }));
    final User? user = firebaseAuth?.currentUser;
    final uid = user?.uid;
    if (firebaseUser != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'error ');
    }
  }

}
