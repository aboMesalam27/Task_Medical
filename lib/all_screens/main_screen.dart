import 'dart:math';

import 'package:applicatioin_task/main.dart';
import 'package:applicatioin_task/model/doctor.dart';
import 'package:applicatioin_task/widgets/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = 'mainScreen';
  Patient? patient;

  //MainScreen();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    userRef.child(FirebaseAuth.instance.currentUser!.uid).once().then((snap) {
      if (snap.value != null) {
        var data = snap.value;
        Patient patient = Patient.fromJson(data);

        setState(() {
          widget.patient = patient;
        });

        Fluttertoast.showToast(msg: 'Logged-in ');
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: white,
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 165,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/81.png',
                        height: 65,
                        width: 65,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.patient?.name}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text('${widget.patient?.email}')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                    'The ${widget.patient?.medicalCenter.name} opening at ${widget.patient?.medicalCenter.openingTime} and closing at ${widget.patient?.medicalCenter.closingTime}'),
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.idScreen, (route) => false);
                },
                child: const ListTile(
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: widget.patient == null
          ? null
          : AppBar(
              backgroundColor: Colors.blue.shade800,
              elevation: 0,
              title: Text(widget.patient!.medicalCenter.name),
            ),
      body: widget.patient == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(5),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        color: color1,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, color: Colors.blue.shade700),
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundColor: color2,
                                  child: Image.asset(
                                    'assets/images/doctor.png',
                                    height: 50,
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.patient!.name),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(widget.patient!.phone),
                                ],
                              )
                            ],
                          ),
                        )),
                  ),
                  ...widget.patient!.medicalCenter.doctors
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: Colors.blue.shade700),
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                                Colors.blue.shade700,
                                            child: Image.asset(
                                              'assets/images/doctor.png',
                                              height: 50,
                                            )),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.name),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(e.address),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
    );
  }
}
