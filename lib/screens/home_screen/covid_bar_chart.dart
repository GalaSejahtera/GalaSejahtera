import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gala_sejahtera/models/daily_cases.dart';
import 'package:gala_sejahtera/services/rest_api_services.dart';

class CovidBarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CovidBarChartState();
}

class CovidBarChartState extends State<CovidBarChart> {
  DailyCases cases;
  RestApiServices restApiServices = RestApiServices();
  double maxY = 0;

  @override
  void initState() {
    super.initState();
    fetchCases();
  }

  void fetchCases() async {
    DailyCases dailyCasesRecords = await restApiServices.fetchDailyCases();
    double tmp = 0;
    for (var i=0; i<dailyCasesRecords.dailyCases.length; i++) {
      if(dailyCasesRecords.dailyCases[i].newInfections > tmp) {
        tmp = dailyCasesRecords.dailyCases[i].newInfections.toDouble();
      }
    }
    setState(() {
      maxY = tmp;
      cases = dailyCasesRecords;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cases == null) {
      return Column(
        children: [
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              color: Colors.white.withOpacity(0.7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'New Covid-19 Cases in Malaysia',
                    style: TextStyle(color: Color(0xff60A1DD), fontSize: 20),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(child: Text("Loading Data...")),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.7,
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Colors.white.withOpacity(0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'New Covid-19 Cases in Malaysia',
                  style: TextStyle(color: Color(0xff60A1DD), fontSize: 20),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Flexible(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceBetween,
                      maxY: maxY,
                      barTouchData: BarTouchData(
                        enabled: false,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.transparent,
                          tooltipPadding: const EdgeInsets.all(0),
                          tooltipBottomMargin: 8,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            return BarTooltipItem(
                              rod.y.round().toString(),
                              TextStyle(
                                color: Color(0xff60A1DD),
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (value) => const TextStyle(
                              color: Color(0xff7589a2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            int i = value.toInt();
                            return cases.dailyCases[i].lastUpdated.substring(5, 10);
                          },
                        ),
                        leftTitles: SideTitles(showTitles: false),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[0].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[1].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[2].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[3].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[4].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 5,
                          barRods: [
                            BarChartRodData(y: cases.dailyCases[5].newInfections.toDouble(), colors: [
                              Colors.lightBlueAccent,
                              Colors.redAccent
                            ])
                          ],
                          showingTooltipIndicators: [0],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
