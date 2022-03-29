import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [
    Todo(
      id: 0,
      details: 'Walk the goldfish',
    ),
  ];

  final ScrollController _sc = ScrollController();
  final TextEditingController _tc = TextEditingController();
  final FocusNode _fn = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos App'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  controller: _sc,
                  child: SingleChildScrollView(
                    controller: _sc,
                    child: Column(
                      children: [
                        for (Todo todo in todos)
                          ListTile(
                            onTap: () => print(_tc.text),
                            leading: Text(todo.id.toString()),
                            title: Text(todo.created.toString()),
                            subtitle: Text(todo.details),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    editTodo(todo.details, todo.id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    removeTodo(todo.id);
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: FloatingActionButton(
                  child: const Icon(Icons.add),
                  backgroundColor: const Color(0xff03dac6),
                  foregroundColor: Colors.black,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AlertDialog(
                        content: TextFormField(
                          controller: _tc,
                          focusNode: _fn,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                          ),
                        ),
                        actions: [
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  addTodo(_tc.text);
                                  _tc.text = '';
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Add'),
                              ),

                              
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          )
                            ],
                          )

                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addTodo(String details) {
    int index = 0;
    if (todos.isEmpty) {
      index = 0;
    } else {
      index = todos.last.id + 1;
    }

    if (mounted) {
      setState(() {
        todos.add(Todo(details: details, id: index));
      });
    }
  }

  removeTodo(int id) {
    if (todos.isNotEmpty) {
      for (int i = 0; i < todos.length; i++) {
        if (id == todos[i].id) {
          todos.removeAt(i);
          setState(() {});
        }
      }
    }
  }

  editTodo(String details, int index) {
    _tc.text = details;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: TextFormField(
          controller: _tc,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
          ),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  if (todos.isNotEmpty) {
                    for (int i = 0; i < todos.length; i++) {
                      if (index == todos[i].id) {
                        setState(() {
                          todos[i].details = _tc.text;
                          _tc.text = '';
                        });
                      }
                    }
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Edit'),
              ),

              TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          )
            ],
          )
        ],
      ),
    );
  }
}

class Todo {
  String details;
  late DateTime created;
  int id;

  Todo({this.details = '', DateTime? created, this.id = 0}) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }
}
