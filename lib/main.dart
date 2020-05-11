import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  return runApp(ChartApp());
}

class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Center(
          child: Container(
            height: 500,
            width: 320,
            child: SfCartesianChart(
              backgroundColor: Colors.white,
              plotAreaBackgroundColor: Colors.white,
              onTooltipRender: (TooltipArgs args) {
                if (args.pointIndex == 0) {
                  //Tooltip without header
                  args.header = '';
                }
                if (args.pointIndex == 1) {
                  //Tooltip with customized header
                  args.header = 'Sold';
                }
                if (args.pointIndex == 2) {
                  //Tooltip with X and Y positions of data points
                  args.header = 'x : y';
                  args.text = '${args.locationX.floor()} : ${args.locationY.floor()}';
                }
                if(args.pointIndex == 3) {
                  //Tooltip with formatted DateTime values
                  List<CartesianChartPoint<dynamic>> chartdata = args.dataPoints;
                  args.header = DateFormat('d MMM yyyy').format(chartdata[3].x);
                  args.text = '${chartdata[3].y}';
                }
              },
                primaryXAxis: DateTimeAxis(
                  interval: 30,
                  intervalType: DateTimeIntervalType.days
                ),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<SalesData, DateTime>>[
                  LineSeries<SalesData, DateTime>(
                      enableTooltip: true,
                      dataSource: <SalesData>[
                        SalesData(DateTime(2020, 01, 31), 35),
                        SalesData(DateTime(2020, 02, 28), 28),
                        SalesData(DateTime(2020, 03, 31), 34),
                        SalesData(DateTime(2020, 04, 30), 32),
                        SalesData(DateTime(2020, 05, 31), 40)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.date,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                  )
                ]
            ),
          ),
        )
    );
  }
}

class SalesData {
  SalesData(this.date, this.sales);

  final DateTime date;
  final double sales;
}