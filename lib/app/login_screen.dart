import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  bool login = true;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (firebaseAuth.currentUser != null) {
      Future.delayed(Duration(milliseconds: 100), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomeScreem()),
            (route) => false);
      });
    }
  }

  // false == sign up
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (str) {
                email = str;
              },
              decoration: InputDecoration(
                  hintText: "Email id", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              onChanged: (str) {
                password = str;
              },
              decoration: InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(login ? "Login" : "Sign up"),
                Switch(
                    value: login,
                    onChanged: (stat) {
                      login = stat;
                      setState(() {});
                    }),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  if (login) {
                    signIn();
                  } else {
                    signUp();
                  }
                },
                child: Text(login ? "Login" : "Sign up"))
          ],
        ),
      ),
    );
  }

  signIn() async {
    try {
      UserCredential userCredentials = await firebaseAuth
          .signInWithEmailAndPassword(email: email!, password: password!);

      if (userCredentials != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign in success")));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomeScreem()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign in failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign in failed ${e.toString()}")));
    }
  }

  signUp() async {
    try {
      UserCredential userCredentials = await firebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: password!);

      if (userCredentials != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign up success")));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => HomeScreem()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Sign up failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign up failed ${e.toString()}")));
    }
  }
}
