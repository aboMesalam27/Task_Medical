
// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
String?message;
ProgressDialog({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0)

        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(width: 6.0,),
              //Lottie.asset('assets/images/loading.json',height: 50),
              const SizedBox(width: 26,),
              Text(
               message!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
