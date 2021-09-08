import 'package:floor_sample/local_datasource.dart';
import 'package:floor_sample/note.dart';
import 'package:floor_sample/note_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Floor Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Floor Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final NoteRepository? _repository = NoteRepository(LocalDatasource());
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _textFieldController,
            textInputAction: TextInputAction.done,
            onEditingComplete: () {
              setState(() {
                _repository?.insert(
                    Note(text: _textFieldController.text, date: DateTime.now()));
                _textFieldController.clear();
              });
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: _repository?.getAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error.toString()}"));
              }

              final list = (snapshot.data as List<Note>);

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Text(list[index].text);
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
