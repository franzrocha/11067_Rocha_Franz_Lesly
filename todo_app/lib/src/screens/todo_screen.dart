import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/auth_controller.dart';
import 'package:todo_app/src/classes/todo_controller.dart';
import 'package:todo_app/src/classes/todo_model.dart';
import 'package:todo_app/src/widgets/alert_logs.dart';
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
            Icon(
              Icons.assignment_turned_in_outlined,
              size: 25,
            ),
            Text(
              'TodoLista',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                _auth.logout();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      backgroundColor: Colors.greenAccent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
              child: _tc.data.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.hourglass_empty,
                            size: 100,
                          ),
                          Text(
                            "No Todos Yet",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ],
                      ),
                    )
                  : Column(
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
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
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const AlertLogs(
          title: 'Success',
          content: 'Todo Successfully Added',
        ),
      );
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
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const AlertLogs(
          title: 'Success',
          content: 'Todo Successfully Edited',
        ),
      );
    }
  }
}
