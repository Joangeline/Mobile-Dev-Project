import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'randomizer_page.dart';
import 'search_key_page.dart';
import 'settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0), // Adjust the padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DEVELOPERS NOTE',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height:
                    8.0), // Optional: Add some vertical space between the two Text widgets
            Text(
              'I only let 10 quotes load from the dashboard because it took so long having to load all of them.',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'Search Keyword',
          ),
        ],
        onTap: (index) {
          // Handle navigation to different pages based on the index.
          switch (index) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardPage()));
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RandomizerPage()));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchKeyPage()));
              break;
          }
        },
      ),
    );
  }
}
