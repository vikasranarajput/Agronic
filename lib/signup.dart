import 'package:flutter/material.dart';
import 'package:agriculture/reusable_widget';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:agriculture/Login.dart';
import 'Home.dart';

class Sign_Up extends StatefulWidget {
  const Sign_Up({super.key});

  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
              right: 20,
              left: 20,
              bottom: 20),
          child: Column(
            children: [
              logo('assets/Icon.png'),
              textField(
                  'Name', Icons.person_2_outlined, false, _nameController),
              textField('Email', Icons.person, false, _emailController),
              SizedBox(height: 10),
              textField('Password', Icons.lock, true, _passwordController),
              SizedBox(
                height: 10,
              ),
              elevatedButton(context, false, () {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text)
                    .then((value) {
                  print("Created New Account");
                  Navigator.pop((context),
                      MaterialPageRoute(builder: (context) => Home()));
                }).onError((error, stackTrace) {
                  print("Error ${error.toString()}");
                });
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do have an account?'),
                  textButton(false, () {
                    Navigator.pop(context,
                        MaterialPageRoute(builder: (context) => Sign_In()));
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
