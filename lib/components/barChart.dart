// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeekBarChart extends StatefulWidget {
  const WeekBarChart({super.key});

  @override
  State<WeekBarChart> createState() => _WeekBarChartState();
}

class _WeekBarChartState extends State<WeekBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Weekly Expenses',
            style: TextStyle(
              color: const Color.fromARGB(255, 154, 152, 152),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            '\$ 3500.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: mainBarChart(),
          ),
        ],
      ),
    );
  }

  BarChart mainBarChart() {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
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
              reservedSize: 38,
              getTitlesWidget: getTiles,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 48,
              getTitlesWidget: LeftTiles,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        barGroups: showingGroupes(),
      ),
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text(
          'Mon',
          style: style,
        );
        break;
      case 1:
        text = Text(
          'Tue',
          style: style,
        );
        break;
      case 2:
        text = Text(
          'Wed',
          style: style,
        );
        break;
      case 3:
        text = Text(
          'Thu',
          style: style,
        );
        break;
      case 4:
        text = Text(
          'Fri',
          style: style,
        );
        break;
      case 5:
        text = Text(
          'Sat',
          style: style,
        );
        break;
      case 6:
        text = Text(
          'Sun',
          style: style,
        );
        break;
      default:
        text = Text(
          '',
          style: style,
        );
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget LeftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;

    if (value == 0) {
      text = '\$ 0k';
    } else if (value == 1) {
      text = '\$ 1k';
    } else if (value == 2) {
      text = '\$ 2k';
    } else if (value == 3) {
      text = '\$ 3k';
    } else if (value == 4) {
      text = '\$ 4k';
    } else if (value == 5) {
      text = '\$ 5k';
    } else {
      text = '';
    }

    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16,
        child: Text(
          text,
          style: style,
        ));
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        toY: y,
        width: 10,
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple, Colors.pink, Colors.red],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          toY: 5,
          color: Colors.grey.shade400,
        ),
      )
    ]);
  }

  List<BarChartGroupData> showingGroupes() => List.generate(
        7,
        (i) {
          switch (i) {
            case 0:
              return makeGroupData(0, 2);
            case 1:
              return makeGroupData(1, 3);
            case 2:
              return makeGroupData(2, 2);
            case 3:
              return makeGroupData(3, 4.5);
            case 4:
              return makeGroupData(4, 3.8);
            case 5:
              return makeGroupData(5, 1.5);
            case 6:
              return makeGroupData(6, 4);
            default:
              return throw Error();
          }
        },
      );
}
