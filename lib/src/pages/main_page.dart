import 'package:flutter/material.dart';
import 'package:atlas/src/pages/home_page.dart';
import 'package:atlas/src/pages/train_page.dart';
import 'package:atlas/src/pages/programs_page.dart';
import 'package:atlas/src/pages/settings_page.dart';

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
            _buildOffstageNavigator(1, TrainPage()),
            _buildOffstageNavigator(2, ProgramsPage()),
            _buildOffstageNavigator(3, SettingsPage()),
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

//enum _Tab {
//  home,
//  train,
//  programs,
//  settings,
//}
//
//  
//class _MainPageState extends State<MainPage> {
//  int currentPageIndex = 0;
//
//  final GlobalKey _tabHomeKey = GlobalKey();
//  final GlobalKey _tabTrainKey = GlobalKey();
//  final GlobalKey _tabProgramsKey = GlobalKey();
//  final GlobalKey _tabSettingsKey = GlobalKey();
//
//
//
//  Widget _getPage(_Tab page) {
//    switch (page) {
//      case _Tab.home:
//        return _BottomNavTab(
//          key: _tabHomeKey,
//          title: 'Home Tab',
//          onChangedPages: (List)
//        );
//      case _Tab.train:
//        return _BottomNavTab(
//          key: _tabTrainKey,
//          title: 'Train Tab',
//          onChangedPages: (List)
//        );
//      case _Tab.programs:
//        return _BottomNavTab(
//          key: _tabProgramsKey,
//          title: 'Programs Tab',
//          onChangedPages: (List)
//        );
//      case _Tab.settings:
//        return _BottomNavTab(
//          key: _tabSettingsKey,
//          title: 'Settings Tab',
//          onChangedPages: (List)
//        );
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final ThemeData theme = Theme.of(context);
//    return Scaffold( ;
//      bottomNavigationBar: NavigationBar(
//        onDestinationSelected: (int index) {
//          setState(() {
//            currentPageIndex = index;
//          });
//        },
//        selectedIndex: currentPageIndex,
//        destinations: const <Widget>[
//         NavigationDestination(
//           selectedIcon: Icon(Icons.home),
//           icon: Icon(Icons.home_outlined),
//           label: 'Home',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.fitness_center),
//           label: 'Train',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.favorite),
//           label: 'Programs',
//         ),
//         NavigationDestination(
//           icon: Icon(Icons.settings),
//           label: 'Settings',
//         )
//        ],
//      ),
//      body: <Widget>[
//        // Home page
//        Card(
//          shadowColor: Colors.transparent,
//          margin: const EdgeInsets.all(8.0),
//          child: SizedBox.expand(
//            child: Center(
//              child: Text(
//                'Home',
//                style: theme.textTheme.titleLarge,
//              ),
//            ),
//          ),
//        ),
//
//        // Train page
//        // will start the current lifting program
//        Card(
//          shadowColor: Colors.transparent,
//          margin: const EdgeInsets.all(8.0),
//          child: SizedBox.expand(
//            child: Center(
//              child: Text(
//                'Train',
//                style: theme.textTheme.titleLarge,
//              ),
//            ),
//          ),
//        ),
//        ][currentPageIndex],
//    );
//  }
//}
//
//class _BottomNavTab extends StatefulWidget {
//  const _BottomNavTab({
//    super.key,
//    required this.title,
//  });
//
//  final String title;
//  
//  @override
//  State<_BottomNavTab> createState() => _BottomNavTabState();
//}
//
//class _BottomNavTabState extends State<_BottomNavTab> {
//  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//
//  @override
//  Widget build(BuildContext context) {
//    return NavigatorPopHandler(
//      onPop: () {
//        _navigatorKey.currentState?.maybePop();
//      },
//      child: Navigator(
//        key: _navigatorKey,
//        onPopPage: (Route<void> route, void result) {
//          if (!route.didPop(null)) {
//            return false;
//          }
//          widget.onChangedPages(<_TabPage>[
//            ...widget.pages,
//          ]..removeLast());
//          return true;
//        },
//        pages: widget.pages.map((_TabPage page)) {
//          switch (page) {
//            case _TabPage.home:
//              return MaterialPage<void>()
//          }
//        }
//      )
//    )
//  }
//}