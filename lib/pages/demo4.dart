import 'dart:math';

/// Donut chart with labels example. This is a simple pie chart with a hole in
/// the middle.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DonutAutoLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutAutoLabelChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutAutoLabelChart.withSampleData() {
    return new DonutAutoLabelChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        behaviors: [
          new charts.ChartTitle('批售周报',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification:
                charts.OutsideJustification.start),

        ],
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        //
        // [ArcLabelDecorator] will automatically position the label inside the
        // arc if the label will fit. If the label will not fit, it will draw
        // outside of the arc with a leader line. Labels can always display
        // inside or outside using [LabelPosition].
        //
        // Text style for inside / outside can be controlled independently by
        // setting [insideLabelStyleSpec] and [outsideLabelStyleSpec].
        //
        // Example configuring different styles for inside/outside:
        //       new charts.ArcLabelDecorator(
        //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
        //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: 60,
            arcRendererDecorators: [new charts.ArcLabelDecorator()]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final random = new Random();
    final data = [
      new LinearSales(0, random.nextInt(100),'X80'),
      new LinearSales(1, random.nextInt(100),'X40'),
      new LinearSales(2, random.nextInt(100),'T77'),
      new LinearSales(3, random.nextInt(100),'B70'),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (LinearSales row, _) => '${row.company}: ${row.sales}',
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;
  final String company;

  LinearSales(this.year, this.sales,this.company);
}