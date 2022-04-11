import 'package:intl/intl.dart';

class Todo {
  late String details;
  late DateTime created;
  bool done = false;

  Todo({
    this.details = '',
    DateTime? created,
  }) {
    created == null ? this.created = DateTime.now() : this.created = created;
  }

  Todo.fromJson(Map<String, dynamic> json) {
    details = json['details'] ?? '';
    created = json['created'] ?? DateTime.now();
    done = json['done'] ?? false;
  }

  String get parsedDate {
    return DateFormat.yMMMEd().format(created);
  }

  toggleDone() {
    done = !done;
  }

  updateDetails(String update) {
    details = update;
    created = DateTime.now();
  }

  Map<String, dynamic> get json => {
        'details': details,
        'created': created,
        'done': done,
      };

  Map<String, dynamic> toJson() {
    return json;
  }

  log() {
    print(json);
  }
}
