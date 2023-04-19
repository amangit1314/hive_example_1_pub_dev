import 'package:flutter/material.dart';
import 'package:hive_example_1_pub_dev/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'features/note_tile.dart';
import 'models/note.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  runApp(
    ListenableProvider(
      create: (context) => HiveService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskContentController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final hiveService = HiveService();
  final notesBox = useHive<Box<Note>>(hiveService.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SafeArea(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .7,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.09,
                          ),
                          const Text(
                            'Add Task',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: taskTitleController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.task,
                                        color: Colors.indigoAccent),
                                    hintText: 'Enter task',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[300],
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.016,
                                ),
                                TextFormField(
                                  controller: taskContentController,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.description,
                                        color: Colors.indigoAccent),
                                    hintText: 'Enter Task Content',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[300],
                                    ),
                                    contentPadding: const EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.04,
                                ),
                                Consumer<HiveService>(
                                  builder: (context, hiveService, widget) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.indigoAccent,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.indigoAccent,
                                          width: 2,
                                        ),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            hiveService.createItem(
                                              Note(
                                                title: taskTitleController.text,
                                                description:
                                                    taskContentController.text,
                                              ),
                                            );
                                            Navigator.of(context).pop(context);
                                          }
                                        },
                                        child: const Text(
                                          'Add Task',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Consumer<HiveService>(
        builder: (context, hiveService, widget) {
          return ValueListenableBuilder(
            valueListenable: notesBox,
            builder: (context, Box<Note> notes, widget) {
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes.getAt(index);
                  return NoteTile(
                    title: note!.title.toString(),
                    content: note.description.toString(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
