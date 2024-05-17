import 'package:flutter/material.dart';
import 'package:instagram/Screen/bottonBar.dart';
import 'package:instagram/Screen/login_Screen.dart';

class Sign_up extends StatelessWidget {
  Sign_up({super.key});
  final formkey = GlobalKey<FormState>();
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
            Text(
              'instagram',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            SizedBox(
              height: height * .05,
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 36,
                ),
                Positioned(
                    top: 25,
                    left: 25,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    )),
              ],
            ),
            SizedBox(
              height: height * .05,
            ),
            Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your username ';
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'name',
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    TextFormField(
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
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return 'please enter a vaild   Password';
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BouttonBar()));
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: height * .05,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Sing Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text(
                  'do you have an account?',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        ),
      ),
    ));
  }
}
