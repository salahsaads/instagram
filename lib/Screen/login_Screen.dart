
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/Screen/Sign_up_Screen.dart';
import 'package:instagram/Screen/bottonBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  void login({required String emailAddress, required String password}) async {
    setState(() {
      isloading = true;
    });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
           Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BouttonBar(),
          ));


      setState(() {
        isloading = false;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: height * .1,
          ),
          const Text(
            'instagram',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          SizedBox(
            height: height * .05,
          ),
          Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    controller: email,

                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'please enter a vaild email';
                      }
                    },
                    decoration: const InputDecoration(
                        hintText: 'email',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  TextFormField(
                    controller: password,
                    // ignore: body_might_complete_normally_nullable
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Password';
                      }
                    },
                    decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.visibility_off),
                        hintText: 'password',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                ],
              )),
          SizedBox(
            height: height * .05,
          ),
          GestureDetector(
            onTap: () {
              formkey.currentState!.save();
              if (formkey.currentState!.validate()) {
                login(emailAddress: email.text, password: password.text);
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: height * .05,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: isloading == true
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Login',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const Sign_up()));
              },
              child: const Text(
                'don`t you have an account?',
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    )));
  }
}
