class Contact{

  int? id;
  String name;
  String phoneNumber;


  Contact({this.id, required this.name, required this.phoneNumber});

  factory Contact.fromMap(Map<String,dynamic>s)=>
    Contact (id: s['id'],name: s['name'],phoneNumber:s['phoneNumber']);

  Map<String,dynamic> toMap()=>{"id":id,"name":name,"phoneNumber":phoneNumber};


}