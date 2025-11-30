import 'dart:convert';

import 'package:chat_app/my_data.dart';
import 'package:chat_app/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  Register({super.key});

  MyData d = Get.find<MyData>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> regitster() async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    http.Response response = await http.post(
      Uri.parse('https://nubbtodoapi.kode4u.tech/api/auth.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'action': 'register',
        'username': username,
        'password': password,
      }),
    );

    final data = jsonDecode(response.body);
    d.token.value = data['token'];
    print(data['token']);

    Get.to(Todo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Register",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Username",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      142,
                      142,
                      142,
                    ).withOpacity(0.2),
                    blurRadius: 1.4,
                    spreadRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "What is the task?",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 118, 118, 118),
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Password",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(
                      255,
                      142,
                      142,
                      142,
                    ).withOpacity(0.2),
                    blurRadius: 1.4,
                    spreadRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "e.g. Work, Home, Personal",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 118, 118, 118),
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 62, 95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: regitster,
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
