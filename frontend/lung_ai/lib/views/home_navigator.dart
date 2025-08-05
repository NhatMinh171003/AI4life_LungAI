import 'package:flutter/material.dart';
import 'package:lung_ai/views/history_view.dart';

import 'home_view.dart'; // lịch sử

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeView(),
    HistoryView(),
  ];

  final List<String> _titles = [
    'Phân tích X-quang',
    'Lịch sử chuẩn đoán',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.image),
                selectedIcon: Icon(Icons.image_outlined,color: Colors.pink,),
                label: Text('Chuẩn đoán'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                selectedIcon: Icon(Icons.history_toggle_off,color: Colors.pink,),
                label: Text('Lịch sử'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Column(
              children: [
                AppBar(
                  title: Text(_titles[_selectedIndex]),
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  elevation: 1,
                  automaticallyImplyLeading: false,
                ),
                Expanded(child: _screens[_selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
