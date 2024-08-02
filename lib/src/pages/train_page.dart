import 'package:flutter/material.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({Key? key}) : super(key: key);

  @override
  State<TrainPage> createState() => _TrainPage();
}

class _TrainPage extends State<TrainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Train')),
        body: Center(child: Text('Train')));
  }
}
