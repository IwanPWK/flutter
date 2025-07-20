import 'package:flutter/material.dart';

import 'numbers_list.dart';
import 'results.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NumbersList numbersList = NumbersList();
  List<int> numbersToAdd = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  String status = 'Values are not added';

  addValues() {
    numbersList.numbers.addAll(numbersToAdd);
    setState(() {
      status = 'Values are added';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singleton Class Example'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              padding: EdgeInsets.all(20),
              onPressed: addValues,
              child: Text('Add Numbers'),
            ),
            SizedBox(height: 20),
            Text(status),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              padding: EdgeInsets.all(20),
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ResultsPage()));
              },
              child: Text('Goto to Results Page'),
            ),
          ],
        ),
      ),
    );
  }
}
