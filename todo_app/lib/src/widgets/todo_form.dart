import 'package:flutter/material.dart';
import 'package:todo_app/src/classes/todo_model.dart';

class TodoForm extends StatelessWidget {
  final Todo todo;
  final Function()? deleteTap;
  final Function()? editTap;
  final Function()? onTap;
  final Function()? checklist;
  final EdgeInsets? margin;
  final ScrollController _sc = ScrollController();

  TodoForm(
      {required this.todo,
      this.onTap,
      this.deleteTap,
      this.editTap,
      this.checklist,
      this.margin,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 11 / 3,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
            decoration: BoxDecoration(
                color: todo.done ? Colors.grey : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
                
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      todo.parsedDate,
                      style: TextStyle(
                          color: todo.done ? Colors.red : null,
                          fontWeight: FontWeight.bold,
                          decoration:
                              todo.done ? TextDecoration.lineThrough : null),
                    ),
                    const SizedBox(width: 12,),
                    const ChecklistBox(),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      iconSize: 15,
                      onPressed: editTap,
                    ),
                    IconButton(
                        icon: const Icon(Icons.close),
                        iconSize: 15,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                "Confirm",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              content: const Text(
                                  "Are you sure you wish to delete this todo?"),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                    ),
                                    onPressed: (deleteTap),
                                    child: const Text("Yes")),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancel"),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
                const Divider(
                  color: Colors.black,
                  height: 4,
                  endIndent: 15,
                  ),

                  

                Expanded(
                  child: Scrollbar(
                    controller: _sc,
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      controller: _sc,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        todo.details,
                        style: TextStyle(
                            color: todo.done ? Colors.red : null,
                            decoration:
                                todo.done ? TextDecoration.lineThrough : null),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChecklistBox extends StatefulWidget {
  const ChecklistBox({ Key? key, onPresssed }) : super(key: key);

  @override
  State<ChecklistBox> createState() => _ChecklistBoxState();
}

class _ChecklistBoxState extends State<ChecklistBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    
    return Checkbox(
      activeColor: Colors.green,
      checkColor: Colors.white,
      onChanged: (bool? value) 
      {
        
        setState(() {
        this.value = value!;
         });},
          value: value,);
  }
}