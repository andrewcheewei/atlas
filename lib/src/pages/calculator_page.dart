//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({Key? key}) : super(key: key);

  @override
  State<PlateCalculator> createState() => _PlateCalculator();
}

class _PlateCalculator extends State<PlateCalculator> {
  final List<bool> _selectedUnit = <bool>[true, false];
  final List<bool> _barbellWeight = <bool>[true, false];
  late TextEditingController _weightController = TextEditingController();
  late TextEditingController _kgController = TextEditingController();
  late TextEditingController _lbController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Plate Calculator')),
      body: Center(
        child: Column(children: [
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Unit of Measurement',
                      style: theme.textTheme.titleSmall),
                  const SizedBox(height: 1),
                  ToggleButtons(
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < _selectedUnit.length; i++) {
                          _selectedUnit[i] = i == index;
                        }
                      });
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    selectedBorderColor: Colors.blue[700],
                    selectedColor: Colors.white,
                    fillColor: Colors.blue[200],
                    color: Colors.blue[400],
                    constraints: const BoxConstraints(
                      minHeight: 40.0,
                      minWidth: 40.0,
                    ),
                    isSelected: _selectedUnit,
                    children: unitOfMeasurement,
                  ),
                  SizedBox(
                    width: 100.0,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 25.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal()),
                          hintText: 'Weight'),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: _weightController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.parse(value) < 0) {
                          return 'Weight cannot be negative';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        Text(value);
                      },
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Barbell weight', style: theme.textTheme.titleSmall),
                      const SizedBox(height: 1),
                      ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            for (int i = 0; i < _barbellWeight.length; i++) {
                              _barbellWeight[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.blue[700],
                        selectedColor: Colors.white,
                        fillColor: Colors.blue[200],
                        color: Colors.blue[400],
                        constraints: const BoxConstraints(
                          minHeight: 40.0,
                          minWidth: 40.0,
                        ),
                        isSelected: _barbellWeight,
                        children: barbellWeight,
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: [
                          Text(getLatestValue(_weightController.text))
                        ],
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Text('Weight Conversion'),
//                  TextFormField(
//                    autofocus: true,
//                    keyboardType: TextInputType.number,
//                    decoration: InputDecoration(hintText: 'kg'),
//                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                    controller: _kgController,
//                    validator: (value) {
//                      if (value == null ||
//                          value.isEmpty ||
//                          int.parse(value) < 0) {
//                        return 'Weight cannot be negative';
//                      }
//                      return null;
//                    },
//                  ),
                  Icon(Icons.compare_arrows)
                ],
              )
            ],
          ),
          Column(
            children: [Text('Plates and Plate Graphic')],
          )
        ]),
      ),
    );
  }
}

String getLatestValue(String value) {
  final text = value;
  return text;
}

const List<Widget> unitOfMeasurement = <Widget>[
  Text('kg'),
  Text('lb'),
];

const List<Widget> barbellWeight = <Widget>[
  Text('25'),
  Text('20'),
];

const List<Map<String, dynamic>> kgPlates = [
  {
    'weight': 0.5,
    'color': 'grey',
  },
  {
    'weight': 1.25,
    'color': 'grey',
  },
  {
    'weight': 2.5,
    'color': 'grey',
  },
  {
    'weight': 5,
    'color': 'white',
  },
  {
    'weight': 10,
    'color': 'green',
  },
  {
    'weight': 15,
    'color': 'yellow',
  },
  {
    'weight': 20,
    'color': 'blue',
  },
  {
    'weight': 25,
    'color': 'red',
  },
  {
    'weight': 50,
    'color': 'black',
  },
];
