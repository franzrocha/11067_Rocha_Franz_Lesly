import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/todo_model.dart';

class InputTodo extends StatefulWidget {
  final String? current;

  const InputTodo({this.current, Key? key}) : super(key: key);

  @override
  State<InputTodo> createState() => _InputTodoState();
}

class _InputTodoState extends State<InputTodo> {
  final TextEditingController _tc = TextEditingController();

  String? get current => widget.current;

  @override
  void initState() {
    if (current != null) _tc.text = current as String;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState?.validate();
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              current != null ? 'Edit Todo' : 'Add Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            inputTextField(),
            inputButtons(),
          ],
        ),
      ),
    );
  }

  Padding inputTextField() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: TextFormField(
        maxLines: 5,
        controller: _tc,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }

  Padding inputButtons() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: (_formKey.currentState?.validate() ?? false)
                ? () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(Todo(details: _tc.text));
                    }
                  }
                : null,
            style: TextButton.styleFrom(
                backgroundColor: (_formKey.currentState?.validate() ?? false)
                    ? Colors.black
                    : Colors.grey),
            child: Text(
              current != null ? 'Edit' : 'Add',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
