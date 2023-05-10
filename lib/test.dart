import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool _showData1 = false;
bool _showData2 = false;
bool _showData3 = false;
bool _showData4 = false;
bool _showData5 = false;
bool _showData6 = false;
bool _showData7 = false;


  List<dynamic> _chartData = [];

  Future<List<dynamic>> _fetchChartData() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/month/2021-05-01/2021-05-30/6/MDB');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchChartData().then((data) {
      setState(() {
        _chartData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chart Example'),
      ),
      body: Center(
        child: _chartData.isEmpty
            ? CircularProgressIndicator()
            : SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  ColumnSeries<dynamic, dynamic>(
                    dataSource: _chartData,
                    xValueMapper: (data, _) => data[1].toString(),
                    yValueMapper: (data, _) => data[3],
                  )
                ],
              ),
              
      ),
      
    );
    
  }
  
}

