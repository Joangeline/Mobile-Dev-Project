import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_page.dart';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<List<Map<String, dynamic>>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    final List<int> slipIds = List.generate(10, (index) => index + 1);
    final List<Map<String, dynamic>> items = [];

    for (final int slipId in slipIds) {
      final response = await http
          .get(Uri.parse('https://api.adviceslip.com/advice/$slipId'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final slip = data['slip'];

        if (slip != null) {
          items.add({
            'slip_id': slip['slip_id'] ?? slipId,
            'advice': slip['advice'],
          });
        } else {
          items.add({
            'slip_id': slipId,
            'advice': 'Advice not found for this ID',
          });
        }
      } else {
        items.add({
          'slip_id': slipId,
          'advice': 'Error fetching advice for this ID',
        });
      }
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Page'),
      ),
      body: FutureBuilder(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<Map<String, dynamic>> items =
                snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['slip_id'].toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          slipId: items[index]['slip_id'],
                          advice: items[index]['advice'],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
