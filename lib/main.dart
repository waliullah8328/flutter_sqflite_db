import 'package:flutter/material.dart';

import 'db_helper/helper.dart';
import 'model/note.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int primaryID = 0;
  List<NoteBookModel> notes = [];

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  late DatabaseHelper dbHelper;
  @override
  void initState() {
    initDatabase();

    super.initState();
  }

  void addNoteDatabase() async {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      setState(() {
        primaryID++;
      });
      NoteBookModel newNote = NoteBookModel(
          id: primaryID,
          name: titleController.text,
          description: descriptionController.text);
      await dbHelper.insertNote(newNote);
      notes = await dbHelper.getNotes();

      setState(() {
        titleController.clear();
        descriptionController.clear();
      });
    } else {
      debugPrint("Please fill up full form for inserting.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Title"),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(hintText: "Description"),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: notes.length,
                  // reverse: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        if (titleController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          await dbHelper.updateNoteById(NoteBookModel(
                              id: notes[index].id,
                              name: titleController.text,
                              description: descriptionController.text));

                          notes = await dbHelper.getNotes();
                          setState(() {
                            titleController.clear();
                            descriptionController.clear();
                          });
                        } else {
                          debugPrint("Please fill up full form for updating.");
                        }
                      },
                      leading: Text(notes[index].id.toString()),
                      title: Text(notes[index].name),
                      subtitle: Text(notes[index].description),
                      trailing: IconButton(
                        onPressed: () async {
                          await dbHelper.deleteNoteById(notes[index].id);
                          notes = await dbHelper.getNotes();
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNoteDatabase,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void initDatabase() async {
    dbHelper = DatabaseHelper();
    notes = await dbHelper.getNotes();
    primaryID = notes.isNotEmpty ? (notes.last.id + 1) : 0;
  }
}