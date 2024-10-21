import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Services with ChangeNotifier {
  List TodayList = [];
  List AllList = [];
  var apiUrl = 'https://api.nstack.in/v1/todos';

  FetchData() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    Map<String, dynamic> Data = json.decode(response.body);
    AllList = Data["items"];

    final filterList = AllList.where((element) =>
        DateFormat.yMMMMEEEEd().format(DateTime.parse(element["created_at"])) ==
        DateFormat.yMMMMEEEEd().format(DateTime.now())).toList();
    TodayList = filterList;
    notifyListeners();
  }

  Future<void> PostData(
      {required String title,
      required String description,
      required bool iscmplete,
      required BuildContext context}) async {
    final body = {
      "title": title,
      "description": description,
      "is_completed": iscmplete
    };
    var url = Uri.parse(apiUrl);
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Created"),
        backgroundColor: Colors.blue,
      ));
      FetchData();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Not Created",
        ),
        backgroundColor: Colors.red,
      ));
    }
    notifyListeners();
  }

  Future<void> UpdateData(
      {required String noteid,
      required String title,
      required String description,
      required bool iscmplete,
      required BuildContext context}) async {
    String id = noteid;
    final body = {
      "title": title,
      "description": description,
      "is_completed": iscmplete
    };
    var url = Uri.parse('https://api.nstack.in/v1/todos/$id');

    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Updated")));
      FetchData();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Not Updated")));
    }
    notifyListeners();
  }

  Future<void> check(
      {required bool? val,
      required title,
      required des,
      required iscom,
      required noteid}) async {
    String id = noteid;
    final body = {"title": title, "description": des, "is_completed": val};
    var url = Uri.parse('https://api.nstack.in/v1/todos/$id');

    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(body));
    FetchData();
    notifyListeners();
  }

  Future<void> Delete(noteid) async {
    String id = noteid;
    var url = Uri.parse('https://api.nstack.in/v1/todos/$id');
    await http.delete(url);
    FetchData();
    notifyListeners();
  }
}
