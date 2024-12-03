import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/screens/note_details.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        tooltip: "Add Note",
        onPressed: (){
          debugPrint("FAB Clicked");
          navigateToDetails("Add Note");
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

 ListView getNoteListView() {
    TextStyle? titleStyle = Theme.of(context).textTheme.bodyLarge;
    return ListView.builder(
      itemCount: count,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),

              ),
              title: Text("Dummy title",style: titleStyle,),
              subtitle: const Text("Dummy date"),
              trailing: const Icon(Icons.delete,color: Colors.grey,),
              onTap: (){
                debugPrint("ListTile Trapped");
                navigateToDetails("Edit Note");
              },
            ),

          );
        },
    );
 }

 void navigateToDetails(String title){
   Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetails(title),));

 }
}
