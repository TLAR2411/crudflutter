import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyData extends GetxController {
  RxString token = ''.obs;
  var data = [].obs;

  Future<void> getData() async {
    if (token.value.isEmpty) {
      print("TOKEN IS EMPTY — SKIPPING API CALL");
      return;
    }

    http.Response response = await http.get(
      Uri.parse('https://nubbtodoapi.kode4u.tech/api/todos.php'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token.value}',
      },
    );

    print(response.body);

    data.value = jsonDecode(response.body)['data'];
  }
}
