import 'package:flutter/material.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  State<ProgramsPage> createState() => _ProgramsPage();
}

// TODO: add text if no programs currently available

class _ProgramsPage extends State<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programs')),
      body: Center(child: Text('Programs')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewProgram()),
          )
        },
      ),
    );
  }
}

class NewProgram extends StatefulWidget {
  const NewProgram({super.key});

  @override
  State<NewProgram> createState() => _NewProgramState();
}

class _NewProgramState extends State<NewProgram> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Program'),
      ),
      body: ListView(children: <Widget>[
        Card(
          child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Exercise'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: 'Exercise'),
                          ),
                          TextField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: 'Sets'),
                          ),
                          TextField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Reps'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(onPressed: () {}, child: Text('Submit'))
                      ],
                    );
                  },
                );
              },
              child: ListTile(
                  leading: Icon(Icons.add), title: Text('Add Exercise'))),
        )
      ]),
    );
  }
}
