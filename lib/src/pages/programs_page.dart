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
        tooltip: 'Create new program',
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewProgram()),
          )
        },
        child: Icon(Icons.add),
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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _exerciseController = TextEditingController();
  late TextEditingController _setsController = TextEditingController();
  late TextEditingController _repsController = TextEditingController();

  Map<String, String> _collectFormData() {
    return {
      'exercise': _exerciseController.text,
      'sets': _setsController.text,
      'reps': _repsController.text,
    };
  }

  @override
  void dispose() {
    _exerciseController.dispose();
    _setsController.dispose();
    _repsController.dispose();
    super.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Program'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Sets'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Reps'),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> formData = _collectFormData();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$formData')),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            )),
      ),
    );
  }
}
