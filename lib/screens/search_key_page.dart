import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchKeyPage extends StatefulWidget {
  const SearchKeyPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchKeyPageState createState() => _SearchKeyPageState();
}

class _SearchKeyPageState extends State<SearchKeyPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> adviceList = [];
  List<String> filteredAdviceList = [];
  bool isLoading = false;

  Future<void> _searchAdvice(String query) async {
    setState(() {
      isLoading = true;
    });

    final String apiUrl = 'https://api.adviceslip.com/advice/search/$query';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('slips')) {
          List<dynamic> slips = data['slips'];
          setState(() {
            adviceList =
                slips.map((slip) => slip['advice'].toString()).toList();
            _filterAdviceList();
          });
        } else {
          // Handle case when no advice slips are found
          setState(() {
            adviceList = [];
            filteredAdviceList = [];
          });
        }
      } else {
        // Handle other HTTP status codes
      }
    } catch (error) {
      // Handle network errors
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterAdviceList() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      filteredAdviceList = adviceList
          .where((advice) => advice.toLowerCase().contains(keyword))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advice Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                _filterAdviceList();
              },
              decoration: InputDecoration(
                labelText: 'Search Advice',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    _searchAdvice(_searchController.text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : filteredAdviceList.isEmpty
                      ? const Center(
                          child: Text('No matching advice found.'),
                        )
                      : ListView.builder(
                          itemCount: filteredAdviceList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredAdviceList[index]),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
