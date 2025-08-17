import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/responsive.dart';
import '../../util/colors.dart';

class BarChartRepresentation extends StatefulWidget {
  const BarChartRepresentation({super.key});

  @override
  State<BarChartRepresentation> createState() => _BarChartRepresentationState();
}

class _BarChartRepresentationState extends State<BarChartRepresentation> {
  final TransformationController _tController = TransformationController();
  Matrix4? _savedMatrix;
  bool _matrixLoaded = false;
  final debouncer = Debouncer(milliseconds: 1000);
  double _currentScale = 2.0; // nilai scale sekarang
  double _currentOffset = 0.0; // nilai scale sekarang
  final double _minScale = 1.0;
  final double _maxScale = 4.0;

  @override
  void initState() {
    super.initState();
    _tController.addListener(_onTransformChanged);
    _loadMatrixAndInit();

    // Set default scale 1.5x secara horizontal (tanpa geser dulu)
    // _transformationController.value =
    //     Matrix4.identity()
    //       ..scale(1.25, 1.0)
    //       ..translate(-200.0, 0.0);
    //  _controller.value = Matrix4.identity()
    // _transformationController.value =
    // Matrix4.identity()
    //   ..scale(1.25, 1.0)
    //   ..translate(-200.0, 0.0);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // restore matrix kalau ada yang tersimpan
    //   _transformationController.value =
    //       _transformationController.value =
    //           Matrix4.identity()
    //             ..scale(1.75, 1.0)
    //             ..translate(-600.0, 0.0);
    // });
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await _loadedOnTransformChanged();
    //     // restore matrix kalau ada yang tersimpan
    //     if (_savedMatrix != null) {
    //       _tController.value = _savedMatrix!;
    //       // _tController.value =
    //       //     Matrix4.identity()
    //       //       ..scale(1.75)
    //       //       ..translate(-600.0, 0.0);
    //       final matrix = _tController.value;
    //       final scaleY = matrix.storage[5];
    //       final offsetX = matrix.storage[12];
    //       setState(() {
    //         _currentScale = scaleY;
    //         _currentOffset = offsetX;
    //       });
    //     }
    //   });
  }

  Future<void> _loadMatrixAndInit() async {
    await _loadedOnTransformChanged();
    if (_savedMatrix != null) {
      _tController.value = _savedMatrix!;
      final matrix = _tController.value;
      final scaleY = matrix.storage[5];
      final offsetX = matrix.storage[12];
      setState(() {
        _currentScale = scaleY;
        _currentOffset = offsetX;
        _matrixLoaded = true;
      });
    } else {
      setState(() {
        _matrixLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _tController.removeListener(_onTransformChanged);
    _tController.dispose();
    super.dispose();
  }

  void _updateScale(double newScale) {
    setState(() {
      _currentScale = newScale;
      //Step A
      // final matrix = _tController.value.clone();
      // matrix.storage[0] = _currentScale; // scaleX
      // matrix.storage[5] = _currentScale;
      // matrix.storage[10] = _currentScale;
      // _tController.value = matrix;
      // or Step B (Seamslely)
      _tController.value =
          Matrix4.identity()
            ..translate(_currentOffset, 0.0)
            ..scale(_currentScale); // atur ulang zoom
    });
  }

  Future<void> _onTransformChanged() async {
    final matrix = _tController.value;
    final values = matrix.storage.toList();
    final stringValues = values.map((e) => e.toString()).toList();
    debouncer.run(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('chart_matrix', stringValues);
      print("Matrix berubah: $matrix");
    });
    setState(() {
      _currentScale = matrix.storage[5];
      _currentOffset = matrix.storage[12];
    });
  }

  Future<void> _loadedOnTransformChanged() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValues = prefs.getStringList('chart_matrix');

    if (savedValues != null) {
      final values = savedValues.map((e) => double.parse(e)).toList();
      final restoredMatrix = Matrix4.fromList(values);

      _savedMatrix = restoredMatrix;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_matrixLoaded) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        strokeWidth: 4.0,
      );
    }
    return Row(
      children: [
        Expanded(
          child: BarChart(
            transformationConfig: FlTransformationConfig(
              minScale: _minScale,
              maxScale: _maxScale,
              scaleAxis: FlScaleAxis.horizontal,
              panEnabled: true,
              scaleEnabled: true,
              trackpadScrollCausesScale: true,
              transformationController: _tController,
            ),
            BarChartData(
              // groupsSpace: 10,
              barGroups: [
                _generateBarGroupsJan(context),
                _generateBarGroupsFeb(context),
                _generateBarGroupsMar(context),
                _generateBarGroupsApr(context),
              ],

              borderData: FlBorderData(show: false),
              alignment: BarChartAlignment.spaceBetween,
              gridData: const FlGridData(
                drawHorizontalLine: true,
                horizontalInterval: 30,
              ),
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  getTooltipColor: (_) => Colors.transparent,
                ),
                handleBuiltInTouches: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 30,
                    getTitlesWidget: (value, meta) {
                      print('value: $value');
                      switch (value.toInt()) {
                        case 0:
                          return const Text(
                            '0',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        case 30:
                          return const Text(
                            '10k',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        case 60:
                          return const Text(
                            '50k',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        case 90:
                          return const Text(
                            '100k',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      final months = [
                        'JAN',
                        'FEB',
                        'MAR',
                        'APR',
                        'MAY',
                        'JUN',
                        'JUL',
                        'AUG',
                        'SEP',
                        'OCT',
                        'NOV',
                        'DEC',
                      ];
                      if (value.toInt() >= 0 && value.toInt() < months.length) {
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      final months = [
                        'JAN',
                        'FEB',
                        'MAR',
                        'APR',
                        'MAY',
                        'JUN',
                        'JUL',
                        'AUG',
                        'SEP',
                        'OCT',
                        'NOV',
                        'DEC',
                      ];
                      if (value.toInt() >= 0 && value.toInt() < months.length) {
                        return Text(
                          months[value.toInt()],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.linear,
          ),
        ),
        SizedBox(
          height: 300,
          child: RotatedBox(
            quarterTurns: 3, // putar biar slider vertikal
            child: Slider(
              value: _currentScale,
              min: _minScale,
              max: _maxScale,
              divisions: 15,
              label: _currentScale.toStringAsFixed(1),
              onChanged: (value) => _updateScale(value),
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData _generateBarGroupsJan(BuildContext context) {
    final List<double> values = [
      20,
      35,
      50,
      90,
      60,
      40,
      25,
      15,
      70,
      90,
      70,
      60,
    ];

    return BarChartGroupData(
      x: 0,
      barsSpace: 4,
      barRods: List.generate(values.length, (index) {
        return BarChartRodData(
          toY: values[index],
          color: Colors.black,
          width: Responsive.isDesktop(context) ? 40 : 10,
          borderRadius: BorderRadius.zero,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 90,
            color: MyAppColor.barBg,
          ),
        );
      }),
      showingTooltipIndicators: List.generate(values.length, (index) => index),
    );
  }

  BarChartGroupData _generateBarGroupsFeb(BuildContext context) {
    final List<double> values = [
      30,
      25,
      40,
      80,
      50,
      30,
      35,
      25,
      80,
      80,
      80,
      70,
    ];

    return BarChartGroupData(
      x: 1,
      barsSpace: 4,
      barRods: List.generate(values.length, (index) {
        return BarChartRodData(
          toY: values[index],
          color: Colors.black,
          width: Responsive.isDesktop(context) ? 40 : 10,
          borderRadius: BorderRadius.zero,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 90,
            color: MyAppColor.barBg,
          ),
        );
      }),
      showingTooltipIndicators: List.generate(values.length, (index) => index),
    );
  }

  BarChartGroupData _generateBarGroupsMar(BuildContext context) {
    final List<double> values = [
      30,
      25,
      40,
      80,
      50,
      30,
      35,
      25,
      80,
      80,
      80,
      70,
    ];

    return BarChartGroupData(
      x: 2,
      barsSpace: 4,
      barRods: List.generate(values.length, (index) {
        return BarChartRodData(
          toY: values[index],
          color: Colors.black,
          width: Responsive.isDesktop(context) ? 40 : 10,
          borderRadius: BorderRadius.zero,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 90,
            color: MyAppColor.barBg,
          ),
        );
      }),
      showingTooltipIndicators: List.generate(values.length, (index) => index),
    );
  }

  BarChartGroupData _generateBarGroupsApr(BuildContext context) {
    final List<double> values = [
      30,
      25,
      40,
      80,
      50,
      30,
      35,
      25,
      80,
      80,
      80,
      70,
    ];

    return BarChartGroupData(
      x: 3,
      barsSpace: 4,
      barRods: List.generate(values.length, (index) {
        return BarChartRodData(
          toY: values[index],
          color: Colors.black,
          width: Responsive.isDesktop(context) ? 40 : 10,
          borderRadius: BorderRadius.zero,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 90,
            color: MyAppColor.barBg,
          ),
        );
      }),
      showingTooltipIndicators: List.generate(values.length, (index) => index),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
