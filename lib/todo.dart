import 'dart:convert';

import 'package:chat_app/sreen_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chat_app/my_data.dart';
import 'package:http/http.dart' as http;

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  MyData d = Get.find<MyData>();

  @override
  void initState() {
    super.initState();
    d.getData();
  }

  Future<void> delete(int id) async {
    http.Response response = await http.delete(
      Uri.parse('https://nubbtodoapi.kode4u.tech/api/todos.php'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${d.token}',
      },
      body: jsonEncode({"id": id}),
    );

    d.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "My Tasks",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (d.data.isEmpty) {
          return const Center(child: Text('No data found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: d.data.length,
          itemBuilder: (context, index) {
            final task = d.data[index];

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task["title"]?.toString() ?? "No title",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              task["description"]?.toString() ?? "No category",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.to(ScreenForm(), arguments: {'id': task['id']});
                        },
                        icon: Icon(Icons.edit, color: Colors.amber),
                      ),
                      IconButton(
                        onPressed: () => delete(task['id']),
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Divider(
                    height: 1,
                    color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Get.to(() => ScreenForm(), arguments: {"id": null});
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
    );
  }
}
