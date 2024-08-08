import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../main.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  State<ProgramsPage> createState() => _ProgramsPage();
}

// TODO: add text if no programs currently available
// TODO: maybe store as list of maps?
// TODO: create program should take in a name of program, then allow for adding exercises
class _ProgramsPage extends State<ProgramsPage> {
  createProgram(BuildContext context) {
    final TextEditingController _programNameController =
        TextEditingController();

    Future<void> _addProgram(String name) async {
      final response = await supabase.from('programs').insert({'name': name});
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Program created: $name'),
        ));
        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to add program: ${response.error!.message}'),
          ));
        }
      }
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter Program Name'),
            content: TextFormField(
              controller: _programNameController,
              decoration: InputDecoration(hintText: 'Program name'),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  String name = _programNameController.text;
                  if (name.isNotEmpty) {
                    _addProgram(name);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
              )
            ],
          );
        });
  }

  Widget buildCard() => Card(
          child: ListTile(
        leading: Icon(Icons.fitness_center_rounded),
        title: Text('Sample Program'),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Programs')),
      // show Programs if no programs
      // retrieve existing programs from db
//      body: Center(child: Text('No existing programs')),
      body: ListView(
        children: <Widget>[
          buildCard(),
          buildCard(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new program',
        onPressed: () => {createProgram(context)},
        child: Icon(Icons.add),
      ),
    );
  }
}

// TODO: rename class name to new exercise or something
class NewExercise extends StatefulWidget {
  const NewExercise({super.key});

  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _exerciseController;
  late TextEditingController _setsController = TextEditingController();
  late TextEditingController _repsController = TextEditingController();

  Map<String, String> _getExerciseData() {
    return {
      'exercise': _exerciseController.text,
      'sets': _setsController.text,
      'reps': _repsController.text,
    };
  }

  @override
  void initState() {
    super.initState();

    _exerciseController = TextEditingController();
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
        title: Text('Create New Exercise'),
      ),
    );
  }

  addExercise() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Add Exercise'),
          content: Column(
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
                controller: _exerciseController,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1) {
                    return 'Sets cannot be less than 1';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Reps'),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _exerciseController,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1) {
                    return 'Reps cannot be less than 1';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map<String, String> formData = _getExerciseData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$formData')),
                    );
                  }
                  Navigator.of(context).pop(_exerciseController.text);
                },
                child: Text('Submit'))
          ],
        ),
      );
}
