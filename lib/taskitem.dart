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
    var item = ListTile(
      leading: CircleAvatar(
          child: Icon(widget._task["completed"] ? Icons.check : null),
          backgroundColor:
              widget._task["completed"] ? Colors.teal : Colors.transparent),
      title: Text(widget._task["description"],
          style: TextStyle(
              decoration: widget._task["completed"]
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      // subtitle: Text(widget._task["creationDate"] ?? ''),
      onTap: () {
        var newState = !widget._task["completed"];
        Api.setCompleted(widget._task["id"], newState).then((response) {
          setState(() {
            widget._task["completed"] = newState;
          });
        });
      },
    );

    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        background: Container(
          color: Colors.orangeAccent,
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
        child: item);
  }
}
