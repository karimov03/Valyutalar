import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../view_model/provider/data_provider.dart';
import '../../model/api_data.dart';

class CandlestickChart extends StatefulWidget {
  @override
  _CandlestickChartState createState() => _CandlestickChartState();
}

class _CandlestickChartState extends State<CandlestickChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 430,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: 900,
            child: BarChart(
              BarChartData(
                minY: dataProvider.data.isEmpty
                    ? 0
                    : dataProvider.data
                            .map((data) => double.parse(data.Rate))
                            .reduce((a, b) => a < b ? a : b) -
                        30,
                maxY: dataProvider.data.isEmpty
                    ? 0
                    : dataProvider.data
                            .map((data) => double.parse(data.Rate))
                            .reduce((a, b) => a > b ? a : b) +
                        30,
                barTouchData: BarTouchData(
                  handleBuiltInTouches: true,
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      final apiData = dataProvider.data[group.x.toInt()];
                      final date =
                          DateFormat('dd-MM-yyyy').format(apiData.Date);
                      return BarTooltipItem(
                        "${double.parse(rod.toY.toString()).toStringAsFixed(2)}\n$date\n${double.parse(apiData.Rate).toStringAsFixed(2)} uzs",
                        TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                        ),
                      );
                    },
                  ),
                  touchCallback: (FlTouchEvent event, barTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          barTouchResponse == null ||
                          barTouchResponse.spot == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          barTouchResponse.spot!.touchedBarGroupIndex;
                    });
                  },
                ),
                gridData: FlGridData(
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            "${value.toString()} ",
                            style: TextStyle(color: Colors.white, fontSize: 8),
                          ),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                barGroups: _buildBarGroups(dataProvider.data),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(List<ApiData> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      ApiData apiData = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            fromY: (double.parse(apiData.Rate) - double.parse(apiData.Diff) >
                    double.parse(apiData.Rate))
                ? double.parse(apiData.Rate)
                : double.parse(apiData.Rate) - double.parse(apiData.Diff),
            toY: (double.parse(apiData.Rate) - double.parse(apiData.Diff) <
                    double.parse(apiData.Rate))
                ? double.parse(apiData.Rate)
                : double.parse(apiData.Rate) - double.parse(apiData.Diff),
            color: (double.parse(apiData.Diff) < 0)
                ? Colors.red.shade400
                : Colors.green.shade400,
            width: 20,
          ),
        ],
      );
    }).toList();
  }
}
