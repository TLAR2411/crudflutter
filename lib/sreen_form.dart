import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_data.dart';
// import ''

class ScreenForm extends StatelessWidget {
  ScreenForm({super.key});

  final MyData d = Get.find<MyData>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final RxBool isMark = false.obs;

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
              "Category",
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
                controller: categoryController,
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

            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mark as Done",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                    activeThumbColor: Colors.blue,
                    value: isMark.value,
                    onChanged: (value) => isMark.value = value,
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  d.data.add({
                    "title": titleController.text,
                    "category": categoryController.text,
                    "isMark": isMark.value,
                  });
                  // print(d.data);
                  Get.off(MyApp()); // go back to home
                },
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
