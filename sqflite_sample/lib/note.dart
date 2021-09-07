class Note {
  
  final int? id;
  final String text;
  final DateTime date;
  final bool completed;

  Note({required this.text, required this.date, this.completed = false, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'date': date.toString(),
      'completed' : completed ? 1 : 0
    };
  }
}