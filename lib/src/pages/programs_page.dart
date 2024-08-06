import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _formKey = GlobalKey<Formstate>();
  late TextEditingController _exerciseController;
  late TextEditingController _setsController;
  late TextEditingController _repsController;

  @override
  void initState() {
    super.initState();

    _exerciseController = TextEditingController();
    _setsController = TextEditingController();
    _repsController = TextEditingController();
  }

  @override
  void dispose() {
    _exerciseController.dispose();
    _setsController.dispose();
    _repsController.dispose();

    super.dispose;
  }

  Map<String, String> _exerciseData() {
    return {
      'exercise': _exerciseController.text,
      'sets': _setsController.text,
      'reps': _repsController.text,
    };
  }

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
                      key: _formKey,
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            autofocus: true,
                            decoration: InputDecoration(hintText: 'Exercise'),
                            controller: _exerciseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Exercise cannot be empty';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Sets'),
                            controller: _setsController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) < 1) {
                                return 'Sets cannot be less than 1';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(hintText: 'Reps'),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            controller: _repsController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) < 1) {
                                return 'Reps cannot be less than 1';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Map<String, String> formData =
                                    _collectFormData();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Form Data: $formData')),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text('Submit'))
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
