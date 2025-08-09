import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrinaGrid Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TrinaColumn> columns = [
    TrinaColumn(
      title: 'ID',
      field: 'id',
      type: TrinaColumnType.text(),
    ),
    TrinaColumn(
      title: 'Name',
      field: 'name',
      type: TrinaColumnType.text(),
    ),
    TrinaColumn(
      title: 'Age',
      field: 'age',
      type: TrinaColumnType.number(),
    ),
    TrinaColumn(
      title: 'Role',
      field: 'role',
      type: TrinaColumnType.select(['Developer', 'Designer', 'Manager']),
    ),
    TrinaColumn(
      title: 'Completion',
      field: 'completion',
      type: TrinaColumnType.percentage(
        decimalDigits: 1,
        showSymbol: true,
      ),
    ),
  ];

  final List<TrinaRow> rows = [
    TrinaRow(
      cells: {
        'id': TrinaCell(value: '1'),
        'name': TrinaCell(value: 'John Doe'),
        'age': TrinaCell(value: 28),
        'role': TrinaCell(value: 'Developer'),
        'completion': TrinaCell(value: 0.75),
      },
    ),
    TrinaRow(
      cells: {
        'id': TrinaCell(value: '2'),
        'name': TrinaCell(value: 'Jane Smith'),
        'age': TrinaCell(value: 32),
        'role': TrinaCell(value: 'Designer'),
        'completion': TrinaCell(value: 0.5),
      },
    ),
    TrinaRow(
      cells: {
        'id': TrinaCell(value: '3'),
        'name': TrinaCell(value: 'Mike Johnson'),
        'age': TrinaCell(value: 45),
        'role': TrinaCell(value: 'Manager'),
        'completion': TrinaCell(value: 0.9),
      },
    ),
  ];

  late TrinaGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrinaGrid Example'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: TrinaGrid(
          columns: columns,
          rows: rows,
          onLoaded: (TrinaGridOnLoadedEvent event) {
            stateManager = event.stateManager;
          },
        ),
      ),
    );
  }
}