import 'package:flutter/material.dart';

class ProgramsPage extends StatefulWidget {
  const ProgramsPage({Key? key}) : super(key: key);

  @override
  State<ProgramsPage> createState() => _ProgramsPage();
}

class _ProgramsPage extends State<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Programs')),
        body: Center(child: Text('Programs')));
  }
}
