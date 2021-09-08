class Note {
  final int? id;
  final String text;
  final DateTime date;
  final bool completed;
  final bool active; // Field added with version 2

  Note({required this.text, required this.date, this.completed = false, this.active = true, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date.toString(),
      'completed' : completed ? 1 : 0,
      'active' : active ? 1 : 0
    };
  }
}