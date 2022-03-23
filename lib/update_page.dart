import 'package:flutter/material.dart';
import 'package:todoapp/repository.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      firstNameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      lastNameController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      messageController.text = args[3];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(hintText: 'First Name :'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(hintText: 'Last Name :'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: messageController,
              decoration: InputDecoration(hintText: 'Message :'),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.updatePage(
                    args[0],
                    firstNameController.text,
                    lastNameController.text,
                    messageController.text);
                if (response) {
                  Navigator.popAndPushNamed(context, 'home');
                } else {
                  throw Exception('Failed to update data');
                }
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
