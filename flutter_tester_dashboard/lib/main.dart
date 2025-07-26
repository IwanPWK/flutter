import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

// Data models defined before use
class BugData {
  BugData(this.month, this.bugs);
  final String month;
  final double bugs;
}

class Bug {
  Bug(this.id, this.title, this.priority, this.status);
  final int id;
  final String title;
  final String priority;
  final String status;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tester Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const TesterDashboard(),
    );
  }
}

class TesterDashboard extends StatefulWidget {
  const TesterDashboard({Key? key}) : super(key: key);

  @override
  _TesterDashboardState createState() => _TesterDashboardState();
}

class _TesterDashboardState extends State<TesterDashboard> {
  late List<BugData> _chartData;
  late BugDataSource _bugDataSource;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _bugDataSource = BugDataSource(bugData: getBugData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tester Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPI Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildKpiCard('Projects', '12', Icons.folder),
                  _buildKpiCard('Tasks', '128', Icons.assignment),
                  _buildKpiCard('Bugs Found', '56', Icons.bug_report),
                  _buildKpiCard('Users', '34', Icons.people),
                ],
              ),
              const SizedBox(height: 24),

              // Chart
              Text('Bugs Found Over Time', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildChart(),

              const SizedBox(height: 24),

              // Data Grid
              Text('Recent Bugs', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              _buildDataGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return SizedBox(
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        // Corrected the type from List<ChartSeries> to List<CartesianSeries>
        series: <CartesianSeries>[
          LineSeries<BugData, String>(
            dataSource: _chartData,
            xValueMapper: (BugData data, _) => data.month,
            yValueMapper: (BugData data, _) => data.bugs,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }

  Widget _buildDataGrid() {
    return SizedBox(
      height: 300,
      child: SfDataGrid(
        source: _bugDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: 'title',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Title'))),
          GridColumn(
              columnName: 'priority',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Priority',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'status',
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text('Status'))),
        ],
      ),
    );
  }

  List<BugData> getChartData() {
    return [
      BugData('Jan', 12),
      BugData('Feb', 15),
      BugData('Mar', 10),
      BugData('Apr', 20),
      BugData('May', 18),
    ];
  }

  List<Bug> getBugData() {
    return [
      Bug(10001, 'UI Glitch on login screen', 'High', 'Open'),
      Bug(10002, 'App crash on profile save', 'High', 'In Progress'),
      Bug(10003, 'Typo in the about us page', 'Low', 'Closed'),
      Bug(10004, 'API call failing for user data', 'Medium', 'Open'),
      Bug(10005, 'Button not responsive on mobile', 'High', 'Open'),
    ];
  }
}

class BugDataSource extends DataGridSource {
  BugDataSource({required List<Bug> bugData}) {
    _bugData = bugData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'title', value: e.title),
              DataGridCell<String>(columnName: 'priority', value: e.priority),
              DataGridCell<String>(columnName: 'status', value: e.status),
            ]))
        .toList();
  }

  List<DataGridRow> _bugData = [];

  @override
  List<DataGridRow> get rows => _bugData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
