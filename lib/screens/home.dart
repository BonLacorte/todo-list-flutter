import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> foundToDo = [];
  final todosList = ToDo.todoList();
  final toDoController = TextEditingController();

  @override
  void initState() {
    foundToDo = // 'todosList' has the data that we stored in these app
        todosList; // search for the value stored on 'todosList' and place it to 'foundToDo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: Text(
                            'ToDo list',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (ToDo todo in foundToDo.reversed)
                          ToDoItem(
                            // pass props
                            todo: todo,
                            onToDoChanged: markToDoComplete,
                            onDeleteItem: deleteToDo,
                          ),
                      ],
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: toDoController,
                  decoration: InputDecoration(
                      hintText: 'Add a new todo item',
                      border: InputBorder.none),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    addToDo(toDoController
                        .text); // grabs the content of the textField and adds the task through addToDo
                  },
                  style: ElevatedButton.styleFrom(
                    primary: cGrey2,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  void markToDoComplete(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void deleteToDo(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id); // Map
    });
  }

  void addToDo(String toDo) {
    setState(() {
      todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo // create and pass unique id number
          ));
    });
    toDoController.clear();
  }

  void searchToDo(String enteredWord) {
    List<ToDo> results = [];
    if (enteredWord.isEmpty) {
      // if the textfield is empty
      results = todosList;
    } else {
      results = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(enteredWord.toLowerCase()))
          .toList(); //checks the item's 'todoText' if it is equal to the lowercased and list-typed 'enteredWord'
    }

    setState(() {
      foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => searchToDo(
            value), // pass the value everytime the textField value change (every keys typed)
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: cBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: cGrey1),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: cBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: cBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/user.jpg'),
          ),
        ),
      ]),
    );
  }
}
