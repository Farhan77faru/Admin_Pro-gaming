import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progamingadminapp/constants/constant.dart';
import 'package:progamingadminapp/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:const Text("Notification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _title,
              decoration:const InputDecoration(hintText: "Notification Title"),
            ),
           const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _body,
              decoration: const InputDecoration(hintText: "Notification body"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_body.text.isNotEmpty && _title.text.isNotEmpty) {
                    sendNotification(
                        appProvider.getUsersToken, _title.text, _body.text);
                    Navigator.of(context).pop();
                    _title.clear();
                    _body.clear();
                  } else {
                    // ShowMessage("Fill the Details");
                  }
                },
                child: const Text("Send Notification!"))
          ],
        ),
      ),
    );
  }
}

Future<void> sendNotification(
    List<String?> userToken, String title, String body) async {
  List<String> newAllUserToken = [];
  List<String> allUserToken = [];

  for (var element in userToken) {
    if (element != null || element != "") {
      newAllUserToken.add(element!);
    }
  }
  allUserToken = newAllUserToken;
  const String serverKey =
      'AAAAWJFIYCU:APA91bFtS3uH4Twaa3bg0yZlYBKUH6exqLj2j4Uk7VTdNkfeuMIVgSpQA_r8EEAOCwSob4sajFTKxuBLsGEIlx5AjUXTt7yFayPkpFEoCwWUB-XeX017e6ROeathQ6PJQeGjiwaGGxvE';

  const String firebaseUrl = "https://fcm.googleapis.com/fcm/send";

  final Map<String, String> headers = {
    "Content-Type": 'application/json',
    "Authorization": 'key=$serverKey',
  };

  final Map<String, dynamic> notification = {"title": title, "body": body};

  final Map<String, dynamic> requestBody = {
    "notification": notification,
    "priority": 'high',
    'registration_ids': allUserToken
  };
  final String encodedBody = jsonEncode(requestBody);

  final http.Response response = await http.post(
    Uri.parse(firebaseUrl),
    headers: headers,
    body: encodedBody,
  );

  if (response.statusCode == 200) {
    ShowMessage('notification sent succesfully');
  } else {
    ShowMessage('notification sending failed with status');
  }
}
