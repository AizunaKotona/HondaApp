import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> _energyDataList = [];
  List<dynamic> _energyDataList2 = [];
  late TransformationController controller;
  List<dynamic> _energyDepartment = [];
  List<dynamic> _energyDepartment2 = [];
  List<dynamic> _chartOnlineMeter = [];

  List<dynamic> _meterName = [];
  bool _isExpanded = false;
  bool _isExpanded2 = true;
  String _meter1 = '';

  List<String> _meter1List = [];
  String _departmentName1 = '';
  String _departmentName2 = '';
  bool _isExpanded3 = false;
  String _dataMeter = '';
  String _dataCurrentStatus = '';
  String _dataCurrentStatusoff = '';
  String _mainEMDBName = '';
  String _chartMDBName = '';
  // late TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    // _trackballBehavior = TrackballBehavior(
    //               enable: true,

    //               tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
    //               tooltipSettings: InteractiveTooltip(
    //               )

    //             );
    super.initState();
    fetchData();
    currentStatus();
    currentStatusoff();
    _chartMDB().then((data) {
      setState(() {
        _energyDataList = data;
      });
    });
    _chartMAINEMDB().then((data) {
      setState(() {
        _energyDataList2 = data;
      });
    });
    _datameterName().then((name) {
      setState(() {
        _meterName = name;
      });
    });
    _chartDepartment1().then((data) {
      setState(() {
        _energyDepartment = data;
      });
    });
    _chartDepartment2().then((data) {
      setState(() {
        _energyDepartment2 = data;
      });
    });
    _chartOnlineMeter1().then((onlinemid1) {
      setState(() {
        _chartOnlineMeter = onlinemid1;
      });
    });
  }

  Future<void> fetchData() async {
    final url = Uri.parse('http://192.168.1.136:8080/api/meters/count');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _dataMeter = response.body;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<dynamic>> _datameterName() async {
    final url = Uri.parse('http://192.168.1.136:8080/api/meters/name');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _chartMDB() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/month/2021-05-01/2021-05-31/6/MDB');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final dynamic chartMDB = jsonData[0];
      final String chartMDBName = chartMDB[2].toString();
      setState(() {
        _chartMDBName = chartMDBName;
      });
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _chartMAINEMDB() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/month/2021-05-01/2021-05-31/6/MAIN EMDB');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final dynamic chartMAINEMDB = jsonData[0];
      final String chartmainEMDBName = chartMAINEMDB[2].toString();
      setState(() {
        _mainEMDBName = chartmainEMDBName;
      });
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _chartDepartment1() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/deptmonth/2021-05-01/2021-05-31/6/Department1');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final dynamic departmentData1 = jsonData[0];
      final String departmentName1 = departmentData1[4].toString();
      setState(() {
        _departmentName1 = departmentName1;
      });
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _chartDepartment2() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/deptmonth/2021-05-01/2021-05-31/6/Department2');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final dynamic departmentData2 = jsonData[0];
      final String departmentName2 = departmentData2[4].toString();
      setState(() {
        _departmentName2 = departmentName2;
      });
      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<dynamic>> _chartOnlineMeter1() async {
    final url = Uri.parse(
        'http://192.168.1.136:8080/api/energys/online/2021-05-31/2021-05-31/6/${_selectedCountry}');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final dynamic meterData = jsonData[0];
      final String meter1 = meterData[3].toString();
      setState(() {
        _meter1 = meter1;
      });

      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> currentStatus() async {
    final url =
        Uri.parse('http://192.168.1.136:8080/api/meters/current_status');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _dataCurrentStatus = response.body;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> currentStatusoff() async {
    final url =
        Uri.parse('http://192.168.1.136:8080/api/meters/current_statusoff');
    final response = await http.get(
      url,
      headers: {'Accept': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _dataCurrentStatusoff = response.body;
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          width: double.infinity, // Set the width to infinity
          child: AppBar(
            leading: Container(
              width: 140,
              height: 140,
              padding:
                  EdgeInsets.only(left: 20.0), // Add 16 pixels of left padding
              // child: Image.asset('assets/honda.png'),
            ),
            backgroundColor: Color.fromARGB(255, 255, 0, 0),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Builder(
          builder: (context) => Container(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 40.0),
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.black),
              itemCount: 7,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return ExpansionTile(
                    leading: Icon(Icons.person_2),
                    title: Text('User Name'),
                    children: [
                      ListTile(
                        leading: Text('   '),
                        title: Text('User Profile'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/groupMeter');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('Change Password'),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/profile');
                        },
                      ),
                    ],
                  );
                }
                
                if (index == 1) {
                  return ListTile(
                    leading: FaIcon(FontAwesomeIcons.gauge),
                    title: Text('Power Status'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  );
                } else if (index == 2) {
                  return ExpansionTile(
                    leading: FaIcon(FontAwesomeIcons.wrench),
                    title: Text('Metering Management'),
                    children: [
                      ListTile(
                        leading: Text('   '),
                        title: Text('Group Meter'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/groupMeter');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('Profile'),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/profile');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('Meter'),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/meter');
                        },
                      ),
                    ],
                  );
                } else if (index == 3) {
                  return ExpansionTile(
                    leading: Icon(Icons.bar_chart_sharp),
                    title: Text('Energy Report'),
                    children: [
                      ListTile(
                        leading: Text('   '),
                        title: Text('Energy Usage Daily'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/energyUsageDaily');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('Energy Usage Monthly'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/energyUsageMonthly');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('Energy Usage yearly'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/energyUsageYearly');
                        },
                      ),
                      ListTile(
                        leading: Text('   '),
                        title: Text('History Graph'),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, '/historyGraph');
                        },
                      ),
                      
                    ],
                  );
                }
                
                else if (index == 4) {
                  return ListTile(
                    leading: Icon(Icons.logout_sharp),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5.0)),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue[700],
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.zoom_out_rounded,
                          color: Colors.white,
                          size: 32.0,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_dataMeter}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Meters',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.lightGreen[600],
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Transform.rotate(
                          angle: 90, // หมุน 90 องศา
                          child: Icon(
                            Icons.compare_arrows,
                            color: Colors.white,
                            size: 32.0,
                          ),
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_dataCurrentStatus/$_dataCurrentStatusoff',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Online / Offline',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.orange[300],
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.white,
                          size: 32.0,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'data',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'This Month',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.red[500],
                    border: Border.all(
                      color: Colors.white,
                      width: 10.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.white,
                          size: 32.0,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'data',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'This Year',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  overView(),
                  onlineValues(),
                ]),
          ),
          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Visibility(
              visible: _isExpanded2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.bar_chart_sharp),
                      title: Text('Main Meter'),
                    ),
                    Container(
                      width: 1000,
                      height: 500,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: SfCartesianChart(
                          title: ChartTitle(text: 'Energy By Main Meter'),
                          legend: Legend(isVisible: true),
                          series: <ChartSeries>[
                            ColumnSeries<dynamic, dynamic>(
                              name: "$_mainEMDBName",
                              dataSource: _energyDataList2,
                              xValueMapper: (data, _) => data[1].toString(),
                              yValueMapper: (data, _) => data[3],
                            ),
                            ColumnSeries<dynamic, dynamic>(
                              name: '$_chartMDBName',
                              dataSource: _energyDataList,
                              xValueMapper: (data, _) => data[1].toString(),
                              yValueMapper: (data, _) => data[3],
                              color: Colors.green,
                            ),
                          ],
                          primaryXAxis: CategoryAxis(
                            labelRotation: 315,
                            visibleMaximum: 4,
                            labelIntersectAction:
                                AxisLabelIntersectAction.multipleRows,
                          ),
                          primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            title: AxisTitle(
                              text: 'kWH',
                              textStyle: TextStyle(fontSize: 13),
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            duration: 3000,
                            header: '',
                            format: 'point.x\nseries.name : point.y kWH',
                          ),
                          zoomPanBehavior: ZoomPanBehavior(
                            // enablePinching: true,
                            enablePanning: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Visibility(
              visible: _isExpanded2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.bar_chart_sharp),
                      title: Text('By Department'),
                    ),
                    Container(
                      width: 1000,
                      height: 500,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: SfCartesianChart(
                          title: ChartTitle(text: 'Energy By Department'),
                          legend: Legend(isVisible: true),
                          series: <ChartSeries>[
                            ColumnSeries<dynamic, dynamic>(
                              name: '$_departmentName1',
                              dataSource: _energyDepartment,
                              xValueMapper: (data, _) => data[0].toString(),
                              yValueMapper: (data, _) => data[3],
                              // dataLabelSettings: DataLabelSettings(
                              //   isVisible: true,
                              // ),
                            ),
                            ColumnSeries<dynamic, dynamic>(
                              name: '$_departmentName2',
                              dataSource: _energyDepartment2,
                              xValueMapper: (data, _) => data[0].toString(),
                              yValueMapper: (data, _) => data[3] / 1000,
                              // dataLabelSettings: DataLabelSettings(
                              //   isVisible: true,
                              // ),
                              color: Colors.green, // set color to green
                            ),
                          ],
                          primaryXAxis: CategoryAxis(
                            labelRotation: 315,
                            visibleMaximum: 4,
                            labelIntersectAction:
                                AxisLabelIntersectAction.multipleRows,
                          ),
                          primaryYAxis: NumericAxis(
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            title: AxisTitle(
                                text: 'kWH',
                                textStyle: TextStyle(fontSize: 13)),
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                            duration: 3000,
                            header: '',
                            format: 'point.x\nseries.name : point.y kWH',
                          ),
                          zoomPanBehavior: ZoomPanBehavior(
                            // enablePinching: true,
                            enablePanning: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isExpanded3,
            child: Container(
              child: Column(
                children: <Widget>[
                  Select(),
                  if (_isSelected) ...[
                    Row(
                      children: [
                        Container(
                            padding: EdgeInsets.all(11),
                            child: SizedBox(
                                height: 70, width: 150, child: meter())),
                        // ok(),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: kWhImport(context)),
                        Expanded(child: kWhExport(context)),
                        Expanded(child: kWhTotal(context))
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: kWDemand(context)),
                        Expanded(child: SumP(context)),
                        Expanded(child: SumQ(context)),
                      ],
                    ),
                    kWh(
                      context,
                    )
                  ],
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Column(
                      children: <Widget>[
                        if (_selectedCountry == _meter1)
                          Visibility(
                            child: Container(
                              width: 1000,
                              height: 500,
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SfCartesianChart(
                                  // trackballBehavior: _trackballBehavior,

                                  title: ChartTitle(
                                      text: 'Live Energy Meter : ${_meter1}'),
                                  // legend: Legend(isVisible: true),
                                  series: <ChartSeries>[
                                    if (_iskWhImport || _default)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'kWh Import',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[4],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_iskWhExport || _default)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'kWh Export',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[5],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),// set color to green
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_iskWhTotal || _default)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'kWh Total',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[6],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_iskWDemand || _default)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'Demand',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[7],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_isSumP)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'Sum P(kW)',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[8],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_isSumQ)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'Sum Q(kvar)',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[9],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                    if (_iskWh)
                                      LineSeries<dynamic, dynamic>(
                                        name: 'kWh',
                                        dataSource: _chartOnlineMeter,
                                        xValueMapper: (onlinemid1, _) =>
                                            onlinemid1[2].toString(),
                                        yValueMapper: (onlinemid1, _) =>
                                            onlinemid1[10],
                                        // dataLabelSettings: DataLabelSettings(
                                        //   isVisible: true,
                                        // ),
                                        width: 4,
                                        markerSettings:
                                            MarkerSettings(isVisible: true),
                                      ),
                                  ],
                                  primaryXAxis: CategoryAxis(
                                    labelRotation: 315,
                                    visibleMaximum: 15,
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.multipleRows,
                                  ),
                                  primaryYAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                  ),
                                  tooltipBehavior: TooltipBehavior(
                                      // enable: true,
                                      // duration: 3000,
                                      // // header: '',
                                      // // format: 'point.x\nseries.name : point.y kWH',
                                      ),

                                  zoomPanBehavior: ZoomPanBehavior(
                                    // enablePinching: true,
                                    enablePanning: true,
                                  ),
                                  trackballBehavior: TrackballBehavior(
                                    enable: true,
                                    tooltipDisplayMode:
                                        TrackballDisplayMode.groupAllPoints,
                                    tooltipSettings: InteractiveTooltip(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String? _selectedCountry = "MDB";
  DropdownButtonFormField meter() {
    return DropdownButtonFormField<String>(
      value: _selectedCountry,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      items: [
        "${_meterName[0]}",
        "${_meterName[1]}",
        "${_meterName[2]}",
        "${_meterName[3]}",
        "${_meterName[4]}",
        "${_meterName[5]}",
        "${_meterName[6]}",
        "${_meterName[7]}",
        "${_meterName[8]}",
        "${_meterName[9]}",
        "${_meterName[10]}",
        "${_meterName[11]}",
        "${_meterName[12]}",
      ]
          .map((country) => DropdownMenuItem(
                value: country,
                child: Text(country),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCountry = value;
        });
        _chartOnlineMeter1();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country';
        }
        return null;
      },
      onSaved: (value) {
        // save the selected value
      },
    );
  }

  ElevatedButton ok() {
    return ElevatedButton(
        child: Text('OK'),
        onPressed: () {
          setState(() {
            _selectedCountry = _selectedCountry;
            _iskWhImport = _iskWhImport;
            _iskWhExport = _iskWhExport;
            _iskWhTotal = _iskWhTotal;
            _iskWDemand = _iskWDemand;
            _isSumP = _isSumP;
            _isSumQ = _isSumQ;
            _iskWh = _iskWh;
          });
          _chartOnlineMeter1();
        });
  }

  bool _default = true;
  bool _isSelected = false;
  InkWell Select() {
    return InkWell(
      child: Text('Select Meter and Parameter'),
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
    );
  }

  bool _iskWhImport = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile kWhImport(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'ΣkWh Import',
        style: TextStyle(fontSize: 12),
      ),
      value: _iskWhImport,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _iskWhImport = value ?? false;
          _iskWhImport = !_iskWhImport;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _iskWhExport = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile kWhExport(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('ΣkWh Export', style: TextStyle(fontSize: 12)),
      value: _iskWhExport,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _iskWhExport = value ?? true;
          _iskWhExport = !_iskWhExport;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _iskWhTotal = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile kWhTotal(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('ΣkWh Total', style: TextStyle(fontSize: 12)),
      value: _iskWhTotal,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _iskWhTotal = value ?? false;
          _iskWhTotal = !_iskWhTotal;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _iskWDemand = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile kWDemand(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('ΣkWh Demand', style: TextStyle(fontSize: 12)),
      value: _iskWDemand,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _iskWDemand = value ?? true;
          _iskWDemand = _iskWDemand;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _isSumP = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile SumP(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Sum P (kW)', style: TextStyle(fontSize: 12)),
      value: _isSumP,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _isSumP = value ?? false;
          _isSumP = !_isSumP;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _isSumQ = false; // กำหนดค่าเริ่มต้นให้กับตัวแปร _iskWhImport

  CheckboxListTile SumQ(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('Sum Q (kvar)', style: TextStyle(fontSize: 12)),
      value: _isSumQ,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _isSumQ = value ?? false;
          _isSumQ = !_isSumQ;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  bool _iskWh = false;
  CheckboxListTile kWh(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('kWh', style: TextStyle(fontSize: 12)),
      value: _iskWh,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) {
        setState(() {
          // _default = !_default;
          // _iskWh = value ?? false;
          _iskWh = !_iskWh;
          if (_iskWDemand == true ||
              _iskWh == true ||
              _isSumQ == true ||
              _isSumP == true ||
              _iskWhTotal == true ||
              _iskWhExport == true ||
              _iskWhImport == true) {
            _default = false;
          } else {
            _default = true;
          }
        });
      },
    );
  }

  ElevatedButton overView() {
    return ElevatedButton(
      onPressed: !_isExpanded2
          ? () {
              setState(() {
                _isSelected = false;
                _isExpanded2 = true;
                _isExpanded3 = false;
              });
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isExpanded2 ? Colors.white : Colors.white,
      ),
      child: Text(
        'OverView',
        style: TextStyle(
          color: _isExpanded2 ? Color.fromARGB(255, 0, 174, 243) : Colors.blue,
        ),
      ),
    );
  }

  ElevatedButton onlineValues() {
    return ElevatedButton(
      onPressed: !_isExpanded3
          ? () {
              setState(() {
                _isExpanded2 = false;
                _isExpanded3 = true;
              });
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isExpanded3 ? Colors.white : Colors.white,
      ),
      child: Text(
        'Online Values',
        style: TextStyle(
          color: _isExpanded3 ? Color.fromARGB(255, 0, 195, 255) : Colors.blue,
        ),
      ),
    );
  }
}
