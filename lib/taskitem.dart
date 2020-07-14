import 'package:flutter/material.dart';
import 'api.dart';

class TaskItem extends StatefulWidget {
  var _task;
  var _index;

  TaskItem(var index, var task) {
    this._task = task;
    this._index = index;
  }

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          Api.delete(widget._task["id"]).then((response) {});
        },
        child: CheckboxListTile(
          title: Text(widget._task["description"]),
          value: widget._task["completed"],
          onChanged: (done) {
            Api.update(widget._task["id"], widget._task).then((response) {
              setState(() {
                widget._task["completed"] = !widget._task["completed"];
              });
            });
          },
          secondary: CircleAvatar(
              child: Icon(widget._task["completed"] ? Icons.check : null),
              backgroundColor: Colors.transparent),
        ));
  }
}
