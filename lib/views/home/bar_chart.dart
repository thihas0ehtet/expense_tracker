import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expense/config/constants.dart';
import 'package:expense/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Report {
  final String label;
  final double amount;

  Report(this.label, this.amount);
}

class HomeBarChart extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  List<charts.Series<dynamic, String>> _createSampleData(
      income, expense, total) {
    final incomeData = [
      Report('Income', income),
    ];

    final expenseData = [
      Report('Expense', expense),
    ];

    final totalData = [
      Report("Total", total),
    ];

    return [
      charts.Series<Report, String>(
        id: 'Income',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (Report report, _) => report.label,
        measureFn: (Report report, _) => report.amount,
        data: incomeData,
      ),
      charts.Series<Report, String>(
        id: 'Expense',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Report report, _) => report.label,
        measureFn: (Report report, _) => report.amount,
        data: expenseData,
      ),
      charts.Series<Report, String>(
        id: 'Total',
        colorFn: (_, __) => income > expense
            ? charts.MaterialPalette.green.shadeDefault
            : charts.MaterialPalette.red.shadeDefault,
        domainFn: (Report report, _) => report.label,
        measureFn: (Report report, _) => report.amount,
        data: totalData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() => Column(
              children: <Widget>[
                Expanded(
                  child: charts.BarChart(
                    _createSampleData(
                        controller.getTotalAmount(ConstantUitls.income),
                        controller.getTotalAmount(ConstantUitls.expense),
                        controller.getAllAmount()),
                    animate: true,
                    barGroupingType: charts.BarGroupingType.groupedStacked,
                    domainAxis: charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 0,
                        labelStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.gray.shadeDefault,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    primaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                            labelAnchor: charts.TickLabelAnchor.centered,
                            labelJustification:
                                charts.TickLabelJustification.outside,
                            labelStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.gray.shadeDefault,
                              fontSize: 14,
                            ),
                            lineStyle: charts.LineStyleSpec(
                                color:
                                    charts.MaterialPalette.gray.shadeDefault))),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
