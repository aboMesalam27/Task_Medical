import 'package:applicatioin_task/model/doctor.dart';
import 'package:applicatioin_task/widgets/components.dart';
import 'package:applicatioin_task/widgets/prograss_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String idScreen = 'register';
  static User? user;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 0.0,
              ),
              Image.asset(
                'assets/images/Health professional team-rafiki.png',
                height: 180,
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 0.0,
                    ),
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10)),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10)),
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Phone',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10)),
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
                      height: 25.0,
                    ),
                    DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          // Icon(
                          //   Icons.list,
                          //   size: 16,
                          //   color: Colors.yellow,
                          // ),
                          // SizedBox(
                          //   width: 4,
                          // ),
                          Expanded(
                            child: Text(
                              'Select Your Medical Center',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: data
                          .map((item) => DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      icon: null,
                      iconSize: 14,
                      iconEnabledColor: Colors.grey,
                      iconDisabledColor: Colors.grey,
                      buttonHeight: 60,
                      buttonWidth: 300,
                      buttonPadding: const EdgeInsets.only(left: 24, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.blueAccent.shade700,
                      ),
                      buttonElevation: 5,
                      itemHeight: 50,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: const EdgeInsets.all(10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.blue,
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(0),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(50, 10),
                    ),
                    const SizedBox(height: 40,),
                    buildButton(
                        elevation: 0.0,
                        color: color4,
                        textColor: white,
                        text: 'Create Account',
                        onPressed: () {
                          if (nameController.text.length < 4) {
                            Fluttertoast.showToast(msg: 'Name must');
                          } else if (!emailController.text.contains('@')) {
                          } else if (phoneController.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'phone must');
                          } else if (passwordController.text.length < 7) {
                            Fluttertoast.showToast(msg: 'password must');
                          } else {
                            RegisterNewUser(context, selectedValue!);
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ? '),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              LoginScreen.idScreen,
                            );
                          },
                          child: Text(
                            'Login Here',
                            style: TextStyle(color:color4),
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

  // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
  void RegisterNewUser(BuildContext context, String center) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: 'Registering,please wait..',
            ),
        barrierDismissible: false);

    final UserCredential firebaseUser = await (firebaseAuth!
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .catchError((error) {
      Fluttertoast.showToast(msg: 'error>>>$error');
    }));

    if (firebaseUser != null) {
      Map userDataMap = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'medicalCenter': center
      };
      final User? user = firebaseAuth?.currentUser;
      final uid = user?.uid;

      userRef.child(uid!).set(userDataMap);
      Fluttertoast.showToast(msg: 'Done');
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.idScreen, (route) => false);
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(msg: 'New user account has ');
    }
  }
}
