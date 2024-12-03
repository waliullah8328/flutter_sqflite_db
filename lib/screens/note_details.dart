import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  String? appBarTitle;
   NoteDetails(this.appBarTitle,);

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {

  static var priority = ["High", "Low"];
  TextEditingController titleTEController = TextEditingController();
  TextEditingController descriptionTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.titleSmall;
    return PopScope(
      canPop: false,
      onPopInvoked: (result){
        if(result){
          return;
        }
        moveToLastScreen();

      },

      child: Scaffold(
        appBar: AppBar(
          title:  Text(widget.appBarTitle.toString(),style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: (){
            moveToLastScreen();
          }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: Padding(
            padding: EdgeInsets.only(left: 10,right: 10,top: 15),
          child:  ListView(
            children: [
              ListTile(
                title: DropdownButton(items: priority.map((String dropDownStringItem) {
                  return DropdownMenuItem(
                    value:  dropDownStringItem,
                      child: Text(dropDownStringItem));
                }).toList(),
                    style: titleStyle,
                    value: "Low",
                    onChanged: (valueSelected){
                  setState(() {
                    debugPrint("User Selected $valueSelected");
      
                  });
                    }),
              ),
              // Second Elements
              Padding(padding: EdgeInsets.only(top: 15,bottom: 15),
                child: TextFormField(
                  controller: titleTEController,
                  style: titleStyle,
                  onChanged: (value){
                    debugPrint("Something changed in Title Text Field");
                  },
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: titleStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),),
      
              // Third Elements
              Padding(padding: const EdgeInsets.only(top: 15,bottom: 15),
                child: TextFormField(
                  controller: descriptionTEController,
                  style: titleStyle,
                  onChanged: (value){
                    debugPrint("Something changed in Description Text Field");
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: titleStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),),
              
              // Forth Element
              Padding(padding: EdgeInsets.only(top: 15,bottom: 15),
              child:  Row(
                children: [
                  Expanded(
      
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
      
                        ),
                          onPressed: (){
                    setState(() {
                      debugPrint("Save button clicked");
                    });
                  }, child: Text("Save"))),
                  SizedBox(width: 5,),
      
                  Expanded(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white
                      ),onPressed: (){
                    setState(() {
                      debugPrint("Delete button clicked");
                    });
                  }, child: Text("Delete"))),
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
