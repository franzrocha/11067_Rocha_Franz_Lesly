import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/auth_controller.dart';
import 'package:todo_app/src/classes/todo_controller.dart';
import 'package:todo_app/src/classes/todo_model.dart';
import 'package:todo_app/src/widgets/input._todo.dart';
import 'package:todo_app/src/widgets/todo_form.dart';

class TodoScreen extends StatefulWidget {
  final AuthController auth;
  const TodoScreen(this.auth, {Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ScrollController _sc = ScrollController();
  // final TextEditingController _tc = TextEditingController();
  // final FocusNode _fn = FocusNode();
  late TodoController _tc;
  AuthController get _auth => widget.auth;

  @override
  void initState() {
    _tc = TodoController(_auth.currentUser!.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.assignment_turned_in_outlined),
            Text(
              'TodoList',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing:2,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [IconButton(onPressed: (){_auth.logout();}, icon: const Icon(Icons.logout))],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.greenAccent,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
        hoverColor: Colors.grey,
        onPressed: () {
          addDialog(context);
        },
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _tc,
          builder: (context, Widget? w) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      controller: _sc,
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12.0),
                        controller: _sc,
                        child: Column(
                          children: [
                            for (Todo todo in _tc.data)
                              TodoForm(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                todo: todo,
                                deleteTap: () {
                                  _tc.removeTodo(todo);
                                  Navigator.of(context).pop();
                                },
                                editTap: () {
                                  showEditDialog(context, todo);
                                },
                                onTap: () {
                                  _tc.toggleDone(todo);
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  addDialog(BuildContext context) async {
    Todo? result = await showDialog<Todo>(
        barrierDismissible: false,
        context: context,
        builder: (dContext) {
          return const Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: InputTodo(),
          );
        });
    if (result != null) {
      _tc.addTodo(result);
    }
  }

  showEditDialog(BuildContext context, Todo todo) async {
    Todo? result = await showDialog<Todo>(
        context: context,
        barrierDismissible: false,
        builder: (dContext) {
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            child: InputTodo(
              current: todo.details,
            ),
          );
        });
    if (result != null) {
      _tc.updateTodo(todo, result.details);
    }
  }
}
  // addTodo(String details) {
  //   int index = 0;
  //   if (todos.isEmpty) {
  //     index = 0;
  //   } else {
  //     index = todos.last.id + 1;
  //   }

  //   if (mounted) {
  //     setState(() {
  //       todos.add(Todo(details: details, id: index));
  //     });
  //   }
  // }

  // removeTodo(int id) {
  //   if (todos.isNotEmpty) {
  //     for (int i = 0; i < todos.length; i++) {
  //       if (id == todos[i].id) {
  //         todos.removeAt(i);
  //         setState(() {});
  //       }
  //     }
  //   }
  // }

  // editTodo(String details, int index) {
  //   _tc.text = details;
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: TextFormField(
  //         controller: _tc,
  //         decoration: const InputDecoration(
  //           focusedBorder: OutlineInputBorder(),
  //           enabledBorder: OutlineInputBorder(),
  //         ),
  //       ),
  //       actions: [
  //         Row(
  //           children: [
  //             TextButton(
  //               onPressed: () {
  //                 if (todos.isNotEmpty) {
  //                   for (int i = 0; i < todos.length; i++) {
  //                     if (index == todos[i].id) {
  //                       setState(() {
  //                         todos[i].details = _tc.text;
  //                         _tc.text = '';
  //                       });
  //                     }
  //                   }
  //                 }
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Edit'),
  //             ),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Cancel'),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
//   }
// }
