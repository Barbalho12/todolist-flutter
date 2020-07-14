import 'package:flutter/material.dart';
import 'api.dart';
import 'taskitem.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  var tasks = [];
  final _todoController = TextEditingController();
  var _loading = true;

  @override
  void initState() {
    super.initState();
    Api.findAll().then((map) {
      setState(() {
        tasks = map;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sddsd',
      theme: ThemeData(primaryColor: Colors.grey, fontFamily: "Google Sans"),
      home: Scaffold(
        appBar: AppBar(
          title: Text("TODO List"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(labelText: "Nova tarefa"),
                    ),
                  )
                ],
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    color: Colors.teal,
                    child: Text("ADICIONAR"),
                    textColor: Colors.white,
                    onPressed: () {
                      if (_todoController.text != "") {
                        setState(() {
                          _loading = true;
                        });
                        Api.create(_todoController.text).then((map) {
                          setState(() {
                            _loading = false;
                            tasks.add(map);
                            _todoController.text = "";
                          });
                        });
                      }
                    },
                  ),
                ),
              )
            ]),
            _loading
                ? Container(
                    padding: EdgeInsets.only(top: 100.0),
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(
                    child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) =>
                            TaskItem(index, tasks[index])),
                  ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedPage,
            onTap: (int index) {
              setState(() {
                _selectedPage = index;
                _todoController.text = "";
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text('Todas'),
                  backgroundColor: Colors.grey),
              BottomNavigationBarItem(
                  icon: Icon(Icons.access_time),
                  title: Text('Pendentes'),
                  backgroundColor: Colors.grey),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  title: Text('Finalizadas'),
                  backgroundColor: Colors.grey)
            ]),
      ),
    );
  }
}
