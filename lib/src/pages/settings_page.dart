import 'package:atlas/main.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

// email (dialog box to change?)
// change password
// toggle dark mode
// delete account
// log out

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Email')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Password')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DarkMode()),
                );
              },
              child: const Text('Dark Mode'),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Delete account')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('Log out')),
          ),
        ],
      ),
    );
  }
}

const List<Widget> appearance = <Widget>[
  Text('System'),
  Text('Light'),
  Text('Dark')
];

class DarkMode extends StatefulWidget {
  const DarkMode();

  @override
  State<DarkMode> createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  final List<bool> _selectedAppearance = <bool>[true, false, false];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Dark Mode')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Appearance', style: theme.textTheme.titleSmall),
              const SizedBox(height: 5),
              ToggleButtons(
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _selectedAppearance.length; i++) {
                      _selectedAppearance[i] = i == index;
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
                  minWidth: 80.0,
                ),
                isSelected: _selectedAppearance,
                children: appearance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
