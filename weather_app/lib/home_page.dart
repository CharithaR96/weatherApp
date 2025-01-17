import 'package:flutter/material.dart';

var _controller = TextEditingController();
var searchList = [];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Column(
          children: [
            //Search Bar
            SearchBar(
              hintText: 'Search',
              leading: Icon(
                Icons.search,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Search list
            Row(
              children: [
                SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Text(
                            'Colombo',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.cloud,
                            size: 30,
                          ),
                          Text(
                            '32 F',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
