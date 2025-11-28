import 'package:chat_app/my_data.dart';
import 'package:chat_app/sreen_form.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  MyData d = MyData();
  Get.put(d);

  runApp(DevicePreview(builder: (context) => MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final d = Get.find<MyData>();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              final isMark = task["isMark"] == true;
              final category = task["category"] ?? "";

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // Category color box
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isMark ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Title & Category
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
                                task["category"]?.toString() ?? "No category",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Check icon
                        IconButton(
                          icon: Icon(
                            isMark ? Icons.check_circle : Icons.circle_rounded,
                            color: isMark
                                ? Colors.green
                                : const Color.fromARGB(255, 138, 202, 255),

                            size: 30,
                          ),
                          onPressed: () {
                            final current =
                                d.data[index]['isMark'] as bool? ?? false;
                            d.data[index]['isMark'] = !current;
                            d.data.refresh();
                          },
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit, color: Colors.amber),
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
            Get.to(() => ScreenForm());
          },
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
    );
  }
}
