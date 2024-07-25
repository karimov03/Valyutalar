import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../view_model/provider/data_provider.dart';
import '../../model/api_data.dart';

class LineChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    List<FlSpot> spots = dataProvider.currencydata.asMap().entries.map((entry) {
      int index = entry.key;
      ApiData apiData = entry.value;
      return FlSpot(index.toDouble(), double.parse(apiData.Rate));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: Color.fromARGB(255, 11, 12, 21),
          height: 400,
          width: 1000,
          child: LineChart(
            LineChartData(
              minY: dataProvider.currencydata.isEmpty
                  ? 0
                  : dataProvider.currencydata
                          .map((data) => double.parse(data.Rate))
                          .reduce((a, b) => a < b ? a : b) -
                      50,
              maxY: dataProvider.currencydata.isEmpty
                  ? 0
                  : dataProvider.currencydata
                          .map((data) => double.parse(data.Rate))
                          .reduce((a, b) => a > b ? a : b) +
                      50,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 20,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index >= 0 &&
                          index < dataProvider.currencydata.length) {
                        final apiData = dataProvider.currencydata[index];
                        final date = DateFormat('dd/MM')
                            .format(DateTime.parse(apiData.Date.toString()));
                        return Text(
                          date,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        );
                      } else {
                        return Text('');
                      }
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 50,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(0),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Color.fromARGB(255, 14, 220, 124),
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Color.fromARGB(100, 14, 220, 124),
                  ),
                  dotData: FlDotData(show: false),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedSpots) {
                    return touchedSpots.map((spot) {
                      final apiData = dataProvider.currencydata[spot.x.toInt()];
                      final date = DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(apiData.Date.toString()));
                      return LineTooltipItem(
                        "${double.parse(apiData.Rate).toStringAsFixed(2)} uzs\n$date\n${double.parse(apiData.Diff).toStringAsFixed(2)} uzs",
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }).toList();
                  },
                ),
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
