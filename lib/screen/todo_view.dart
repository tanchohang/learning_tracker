import 'package:flutter/material.dart';
import 'package:learning_tracker/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import 'package:learning_tracker/models/todo_model.dart';

class Todo extends StatefulWidget {
  Todo({Key key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  // int _selected;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void formvalue(TodoM todo) {
    print(todo.title);
    Provider.of<TodoStateModel>(context, listen: false).add(todo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = context.read<TodoStateModel>();

    return Scaffold(
        body: StreamBuilder<List<TodoM>>(
            stream: todoProvider.todos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) => Dismissible(
                      secondaryBackground: Container(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.red,
                      ),
                      background: Container(
                        child: Text(
                          'Archive',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        color: Colors.amber,
                      ),
                      key: Key(snapshot.data[index].title),
                      onDismissed: (direc) {
                        Provider.of<TodoStateModel>(context, listen: false)
                            .remove(snapshot.data[index]);
                      },
                      child: Card(
                        child: ListTile(
                          title: Text('${snapshot.data[index].title}'),
                          subtitle: Text('subtitle goes here'),
                          isThreeLine: true,
                          // enabled: true,
                          // selected: index == _selected,
                          // selectedTileColor: Colors.amber,
                          trailing: PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String selected) {
                              context
                                  .read<TodoStateModel>()
                                  .remove(snapshot.data[index]);
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem(
                                child: Text('Delete'),
                                value: 'delete',
                              )
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              // _selected = index;
                            });
                          },
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text('connection not active');
                }
              } else {
                return Text('Error in fretch');
              }
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Add a task'),
              content: Builder(builder: (context) {
                return Container(
                  height: 80,
                  width: 120,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _textController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )
                        ],
                      )),
                );
              }),
              actions: [
                ElevatedButton(
                  onPressed: () => {
                    if (_formKey.currentState.validate())
                      {formvalue(TodoM(title: _textController.text))}
                  },
                  child: Text(
                    'Add new Task',
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
            barrierDismissible: true,
          ),
          child: Icon(Icons.add),
        ));
  }
}
