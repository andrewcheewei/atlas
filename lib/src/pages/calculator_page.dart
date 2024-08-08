import 'package:atlas/src/pages/settings_page.dart';
import 'package:flutter/material.dart';

class PlateCalculator extends StatefulWidget {
  const PlateCalculator({Key? key}) : super(key: key);

  @override
  State<PlateCalculator> createState() => _PlateCalculator();
}

class _PlateCalculator extends State<PlateCalculator> {
  final List<bool> _selectedUnit = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Plate Calculator')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Unit', style: theme.textTheme.titleSmall),
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
          ],
        ),
      ),
    );
  }
}

const List<Widget> unitOfMeasurement = <Widget>[
  Text('kg'),
  Text('lb'),
];
