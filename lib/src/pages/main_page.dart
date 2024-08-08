import 'package:flutter/material.dart';
import './home_page.dart';
import './calculator_page.dart';
import './train_page.dart';
import './programs_page.dart';
import './settings_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator(0, HomePage()),
            _buildOffstageNavigator(1, PlateCalculator()),
            _buildOffstageNavigator(2, TrainPage()),
            _buildOffstageNavigator(3, ProgramsPage()),
            _buildOffstageNavigator(4, SettingsPage()),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          indicatorColor: Colors.blue,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.insert_chart),
              //icon: Icon(Icons.circle_rounded),
              label: 'Calculator',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center),
              label: 'Train',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite),
              label: 'Programs',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => child,
          );
        },
      ),
    );
  }
}
