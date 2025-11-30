import 'dart:convert';

import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_data.dart';
import 'package:http/http.dart' as http;
// import ''

class ScreenForm extends StatefulWidget {
  ScreenForm({super.key});
  MyData d = Get.find<MyData>();
  @override
  State<ScreenForm> createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  dynamic id;
  String? selectedPriority;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  Future<void> create() async {
    final title = titleController.text;
    final date = dateController.text;
    final description = descriptionController.text;
    final priority = priorityController.text;

    http.Response response = await http.post(
      Uri.parse('https://nubbtodoapi.kode4u.tech/api/todos.php'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.d.token}',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'date': date,
        'priority': priority,
      }),
    );
    Get.back();
    widget.d.getData();
  }

  Future<void> getDataToEdit() async {
    http.Response response = await http.get(
      Uri.parse('https://nubbtodoapi.kode4u.tech/api/todos.php?id=${id['id']}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${widget.d.token}',
      },
    );

    final getData = jsonDecode(response.body);

    titleController.text = getData['data']['title'];
    descriptionController.text = getData['data']['description'];
    dateController.text = getData['data']['date'];
    selectedPriority = getData['data']['priority'];
  }

  @override
  void initState() {
    super.initState();
    id = Get.arguments;
    if (id != null && id['id'] != null) {
      getDataToEdit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add New Task",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Title",
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
                controller: titleController,
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
              "Description",
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
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: "Description",
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
              "Date",
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
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Date",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 118, 118, 118),
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    dateController.text = pickedDate.toString().split(" ")[0];
                  }
                },
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Priority",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              width: double.infinity,
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
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),

                value: selectedPriority,
                hint: Text("Select Priority"),
                items: ["low", "medium", "high"]
                    .map(
                      (item) =>
                          DropdownMenuItem(value: item, child: Text(item)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPriority = value;
                    priorityController.text =
                        value!; // <-- update your controller
                  });
                },
              ),
            ),
            const SizedBox(height: 30),

            const Spacer(),
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
                onPressed: create,
                child: const Text(
                  "Add Task",
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
