import 'package:flutter/material.dart';
import 'package:todoease/constraints/colors.dart';
import 'package:todoease/model/todo.dart';
import 'package:todoease/widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todoList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _toDoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azureMist,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 20),
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Text(
                          'Todo List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundTodo.reversed)
                        TodoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _toDoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40, color: azureMist),
                    ),
                    onPressed: () {
                      _addToDoItem(_toDoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: steelTeal,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    
  }

  void _addToDoItem(String todo) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        todoText: todo,
      ));
    });
    _toDoController.clear();
    
  }

  void _runFilter(String enterdKeyword) {
    List<ToDo> results = [];
    if(enterdKeyword.isEmpty) {
      results = todoList;
    }else{
      results = todoList
      .where((item) => item.todoText!
        .toLowerCase()
        .contains(enterdKeyword.toLowerCase()))
      .toList();
    }

    setState(() {
      _foundTodo = results;
    });

  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value) ,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: steelTeal,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: steelTealDarker),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
  return AppBar(
    backgroundColor: steelTealDarker,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.menu,
          color: tealBlue,
          size: 30,
        ),
        Spacer(),
        Text(
          'TodoEase',
          style: TextStyle(
            color: tealBlue,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Spacer(),
        Container(
          height: 40,
          width: 40,
          child: Icon(
            Icons.account_circle,
            size: 30,
            color: tealBlue,
          ),
        ),
      ],
    ),
  );
}

}
