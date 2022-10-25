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
      ToDo(id: '01', todoText: 'Eat breakfast', isDone: true),
      ToDo(id: '02', todoText: 'Attend online class', isDone: true),
      ToDo(
        id: '03',
        todoText: 'Eat Lunch',
      ),
      ToDo(
        id: '04',
        todoText: 'Study & Practice Flutter',
      ),
      ToDo(
        id: '05',
        todoText: 'Do Workout',
      ),
      ToDo(
        id: '06',
        todoText: 'Take a bath',
      ),
      ToDo(
        id: '07',
        todoText: 'Eat Dinner',
      ),
    ];
  }
}
