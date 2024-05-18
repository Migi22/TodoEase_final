class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '02', todoText: 'Read a book', isDone: false),
      ToDo(id: '03', todoText: 'Prepare breakfast', isDone: false),
      ToDo(id: '04', todoText: 'Write a journal entry', isDone: true),
      ToDo(id: '05', todoText: 'Take a walk in the park', isDone: false),
      ToDo(id: '06', todoText: 'Call a friend', isDone: false),
    ];
  }

}