// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Bar chart example
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:doers_app/Components/hex_colors.dart';
import 'package:flutter/material.dart';


class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory SimpleBarChart.withRandomData() {
    return new SimpleBarChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<JobStats, String>> _createRandomData() {
    final random = new Random();

    final data = [
      new JobStats('2014', random.nextInt(100)),
      new JobStats('2015', random.nextInt(100)),
      new JobStats('2016', random.nextInt(100)),
      new JobStats('2017', random.nextInt(100)),
    ];

    return [
      new charts.Series<JobStats, String>(
        id: 'JobsCompleted',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (JobStats jobsCompleted, _) => jobsCompleted.year,
        measureFn: (JobStats jobsCompleted, _) => jobsCompleted.jobsCompleted,
        data: data,
      )
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      behaviors: [
        new charts.ChartTitle('DOER Stats',
            behaviorPosition: charts.BehaviorPosition.top,
            titleOutsideJustification: charts.OutsideJustification.start,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 20, color: charts.Color.black),
            // Set a larger inner padding than the default (10) to avoid
            // rendering the text too close to the top measure axis tick label.
            // The top tick label may extend upwards into the top margin region
            // if it is located at the top of the draw area.
            innerPadding: 18),

        new charts.ChartTitle('Year',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 20, color: charts.Color.black),
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea,
        ),

        new charts.ChartTitle('Jobs Completed',
            behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 20, color: charts.Color.black),
            titleOutsideJustification:
            charts.OutsideJustification.middleDrawArea),
      ],


      /// Assign a custom style for the domain axis.
      ///
      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.Color.fromHex(code: '#000000')),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: '#000000')))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

            // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.Color.fromHex(code: '#000000')),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.Color.fromHex(code: '#000000')))),

    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<JobStats, String>> _createSampleData() {
    final data = [
      new JobStats('2014', 10),
      new JobStats('2015', 25),
      new JobStats('2016', 100),
    ];

    return [
      new charts.Series<JobStats, String>(
        id: 'JobsCompleted',
        colorFn: (_, __) => charts.Color.fromHex(code: '#69efad'),
        domainFn: (JobStats jobsCompleted, _) => jobsCompleted.year,
        measureFn: (JobStats jobsCompleted, _) => jobsCompleted.jobsCompleted,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class JobStats {
  final String year;
  final int jobsCompleted;

  JobStats(this.year, this.jobsCompleted);
}


