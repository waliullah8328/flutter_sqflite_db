class NoteBookModel {
  int id;
  String name;
  String description;

  NoteBookModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory NoteBookModel.fromJson(Map<String, dynamic> json) {
    return NoteBookModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}