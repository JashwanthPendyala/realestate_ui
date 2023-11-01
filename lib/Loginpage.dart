
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newapp/Landingpage.dart';
import 'package:newapp/registration.dart';
import 'package:http/http.dart' as http;
class Loginpage extends StatefulWidget {
  const Loginpage({Key? key});

  @override
  State<Loginpage> createState() => _Loginpage();
}

class _Loginpage extends State<Loginpage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: screenWidth * 0.5,
                  height: screenHeight * 0.5,
                  child: Image.asset(
                    "assets/images/man.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.5,
                  child: Image.asset(
                    "assets/images/syslock.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 50,
                width: screenWidth * 0.8,
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Enter Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                height: 50,
                width: screenWidth * 0.8,
                child: Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: screenWidth * 0.8,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                  onPressed: () async {
                    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                      var result = await verifyUser(emailController.text, passwordController.text);
                      print(result); // Print the result of the API call
                      if (result == 200) {
                        print("Successfully logged in");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Landingpage()),
                        );
                      } else {
                        print("Failed to log in");
                      }
                    }
                  },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                "Don't have an account? Register",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<int> verifyUser(String email, String password) async {
  var url = Uri.parse('http://192.168.6.137:8080/login/validateCustomer'); // Replace with your API endpoint
int statusCode =0;
  try {
    var response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    statusCode = response.statusCode;
    return response.statusCode;
  } catch (e) {
    // Exception occurred during the API call
    return statusCode;
  }
}