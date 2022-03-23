import 'package:flutter/material.dart';
import 'package:todoapp/repository.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final messageController = TextEditingController();
  Repository repository = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Page'),
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
                bool response = await repository.createData(
                    firstNameController.text,
                    lastNameController.text,
                    messageController.text);
                if (response) {
                  Navigator.popAndPushNamed(context, 'home');
                } else {
                  throw Exception('Failed to create data');
                }
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
