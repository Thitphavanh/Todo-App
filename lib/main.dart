import 'package:flutter/material.dart';
import 'package:todoapp/create_page.dart';
import 'package:todoapp/person.dart';
import 'package:todoapp/repository.dart';
import 'package:todoapp/update_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      routes: {
        'home': (context) => HomePage(),
        'create': (context) => CreatePage(),
        'update': (context) => UpdatePage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repository repository = Repository();
  List<Person> listPerson = [];

  getData() async {
    listPerson = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API'),
      ),
      body: ListView.builder(
        itemCount: listPerson.length,
        itemBuilder: (context, index) {
          Person person = listPerson[index];
          return InkWell(
            onTap: () {
              Navigator.popAndPushNamed(context, 'update', arguments: [
                person.id,
                person.firstName,
                person.lastName,
                person.message,
              ]);
            },
            child: Dismissible(
              key: Key(person.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.red,
                ),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Delete Data'),
                        content: Text('Are you sure to delete data?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              bool response =
                                  await repository.deleteData(person.id);

                              if (response) {
                                Navigator.pop(context, true);
                              } else {
                                Navigator.pop(context, false);
                              }
                            },
                            child: Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text('No'),
                          ),
                        ],
                      );
                    });
              },
              child: ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/phenomenal_logistic.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text('${person.firstName} ${person.lastName}'),
                subtitle: Text(
                  person.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'create');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
