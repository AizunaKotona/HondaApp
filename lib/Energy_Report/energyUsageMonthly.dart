import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnergyUsageMonthly extends StatefulWidget {
  const EnergyUsageMonthly({super.key});

  @override
  State<EnergyUsageMonthly> createState() => _EnergyUsageMonthlyState();
}

class _EnergyUsageMonthlyState extends State<EnergyUsageMonthly> {
  DateTime minDate =
      DateTime(2023, 5, 1); // กำหนดวันที่เริ่มต้นเป็น 1 พฤษภาคม 2023
  DateTime maxDate = DateTime(2023, 5, 31);
  final _httpClient = http.Client();
  bool isLoading = false;
  String _meter1 = '';
  String _meterGroup = '';
  bool isData = false;
  bool _isExpanded = false;
  List<dynamic> _tableData = [];
  List<dynamic> _energyUsageMonth = [];
  List<dynamic> _energyUsageMonthGroup = [];
  List<dynamic> _tableData2 = [];
  List<dynamic> _originalData2 = [];
  String _searchValue = '';
  List<dynamic> _originalData = [];
  List<DataColumn> columns = [];
  int currentIndex = 1;
  String? _selectedCountry;
  String? _selectedCountry2;
  TextEditingController _dateController = TextEditingController();
  List<dynamic> _meterName = [];
  List<dynamic> _groupMeter = [];
  DateTime? _selectedDate;
  bool _isExpanded2 = false;
  bool _isExpanded3 = true;
  bool _isExpanded4 = false;
  bool _isExpanded5 = false;

  @override
  void dispose() {
    // _httpClient.close();
    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    energyUsageMonth().then((data) {
      setState(() {
        _energyUsageMonth = data;
        _tableData = data;
        _originalData = data;
      });
    });
    energyUsageMonthGroup().then((data) {
      setState(() {
        _energyUsageMonthGroup = data;
        _tableData2 = data;
        _originalData2 = data;
      });
    });
    _datameterName().then((name) {
      setState(() {
        _meterName = name;
        // isLoading1 = false;
      });
    });
    groupMeter().then((name) {
      setState(() {
        _groupMeter = name;
        // isLoading1 = false;
      });
    });
  }

  Future<List<dynamic>> groupMeter() async {
    if (_isExpanded2 == false &&
        _isExpanded3 == true &&
        _isExpanded4 == false &&
        _isExpanded5 == false) {
      // setState(() {
      //   isLoading1 = true;
      // });
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/group/getgroupmeterselect');
      try {
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            setState(() {
              _groupMeter = jsonData;
            });
          } else {
            setState(() {
              _groupMeter = [];
            });
          }
          return jsonData;
        } else {
          throw Exception('N/A');
        }
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading1 = false;
        //   });
        // }
        print('Error during API call: $e');
        // Handle the error gracefully, e.g., show an error message to the user
        // or perform any necessary cleanup.
        rethrow; // Return an empty list or another appropriate value.
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> _datameterName() async {
    if (_isExpanded2 == false &&
        _isExpanded3 == true &&
        _isExpanded4 == false &&
        _isExpanded5 == false) {
      // setState(() {
      //   isLoading1 = true;
      // });
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/meters/name');
      try {
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            setState(() {
              _meterName = jsonData;
            });
          } else {
            setState(() {
              _meterName = [];
            });
          }
          return jsonData;
        } else {
          throw Exception('N/A');
        }
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading1 = false;
        //   });
        // }
        print('Error during API call: $e');
        // Handle the error gracefully, e.g., show an error message to the user
        // or perform any necessary cleanup.
        rethrow; // Return an empty list or another appropriate value.
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> energyUsageMonth() async {
  final selectedDate = _dateController.text;
  final formattedDate =
      selectedDate.replaceAll('-', ''); // Remove dashes from the date

  if (_selectedCountry != "" &&
      formattedDate != "" &&
      _selectedCountry2 == "") {
    isData = false;
    final url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/getcrosstabbymonth/${formattedDate.substring(0, 2)}-${formattedDate.substring(2)}/6/$_selectedCountry');
    try {
      final response = await http.get(url, headers: {
        'Accept': 'application/json; charset=UTF-8'
      });
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          final dynamic meterData = jsonData[0];
          final String meter1 = meterData[2].toString();
          // Create a list to hold data for all days of the month
          List<dynamic> monthData = [];
          // Calculate the number of days in the selected month
          final DateTime firstDayOfMonth = DateTime(
              int.parse(formattedDate.substring(4)),
              int.parse(formattedDate.substring(0, 2)),
              1);
          final DateTime firstDayOfNextMonth =
              DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 1);
          final int daysInMonth =
              firstDayOfNextMonth.difference(firstDayOfMonth).inDays;
          // Initialize monthData with dummy data points for all days of the month
          for (int day = 1; day <= daysInMonth; day++) {
            monthData.add([
              day.toString().padLeft(2, '0'), // Format day as 'dd'
              0
            ]); // Initialize with energy usage 0
          }
          // Populate monthData with actual data
          for (dynamic data in jsonData) {
            final String? apiDate = data[0];
            final double? apiData = data[3];
            if (apiDate != null && apiData != null) {
              final int? day = int.tryParse(apiDate.substring(8));
              if (day != null && day >= 1 && day <= daysInMonth) {
                int dataIndex = day - 1;
                // Check if the data at the current day index is dummy data
                if (monthData[dataIndex][1] == 0) {
                  // Convert the apiData to int before assigning
                  monthData[dataIndex] = [
                    apiDate,
                    0,
                    meterData,
                    apiData.toInt()
                  ];
                }
              }
            }
          }
          setState(() {
            _meter1 = meter1;
            _energyUsageMonth.clear(); // Clear the existing data
            _energyUsageMonth = monthData;
          });
        } else {
          setState(() {
            _meter1 = 'N/A';
            _energyUsageMonth.clear(); // Clear the existing data
            _energyUsageMonth = [];
          });
        }
        return _energyUsageMonth;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  } else {
    return [];
  }
}

  
  Future<List<dynamic>> energyUsageMonthGroup() async {
    final selectedDate = _dateController.text;
    if (_selectedCountry2 != "" && selectedDate != "") {
      isData = true;
      _selectedCountry = '';
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/getcrosstabbymonthgroup/$selectedDate/6/$_selectedCountry2');
      try {
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic meterData = jsonData[0];
            final String meterGroup = meterData[2].toString();
            // Create a list to hold data for all days of the month
            List<dynamic> monthData = [];
            // Calculate the number of days in the selected month
            final DateTime firstDayOfMonth = DateTime.parse(selectedDate)
                .subtract(Duration(days: DateTime.parse(selectedDate).day - 1));
            final DateTime firstDayOfNextMonth =
                DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 1);
            final int daysInMonth =
                firstDayOfNextMonth.difference(firstDayOfMonth).inDays;
            // Iterate over all days of the selected month
            for (int day = 1; day <= daysInMonth; day++) {
              // Check if data exists for the current day
              dynamic dataForDay = jsonData.firstWhere(
                  (data) => data[0] == day.toString(),
                  orElse: () => null);
              if (dataForDay != null) {
                monthData.add(dataForDay);
              } else {
                // Create a dummy data point with zero energy usage for the day
                monthData.add([day.toString(), 0]);
              }
            }
            setState(() {
              _meterGroup = meterGroup;
              _energyUsageMonthGroup = monthData;
            });
          } else {
            setState(() {
              _meterGroup = 'N/A';
              _energyUsageMonthGroup = [];
            });
          }
          return _energyUsageMonthGroup;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        rethrow;
      }
    } else {
      return [];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Energy Report',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red[600],
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(30), // Increased height for better visibility
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded2 = true;
                      _isExpanded3 = false;
                      _isExpanded4 = false;
                      _isExpanded5 = false;
                      if (ModalRoute.of(context)?.settings.name !=
                          '/energyUsageDaily') {
                        Navigator.pushReplacementNamed(
                            context, "/energyUsageDaily");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(
                      'Daily',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded2 ? Colors.white : Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded2 = false;
                      _isExpanded3 = true;
                      _isExpanded4 = false;
                      _isExpanded5 = false;
                      if (ModalRoute.of(context)?.settings.name !=
                          '/energyUsageMonthly') {
                        Navigator.pushReplacementNamed(
                            context, "/energyUsageMonthly");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Monthly',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded3 ? Colors.white : Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded2 = false;
                      _isExpanded3 = false;
                      _isExpanded4 = true;
                      _isExpanded5 = false;
                      if (ModalRoute.of(context)?.settings.name !=
                          '/energyUsageYearly') {
                        Navigator.pushReplacementNamed(
                            context, "/energyUsageYearly");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(
                      'Yearly',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded4 ? Colors.white : Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded2 = false;
                      _isExpanded3 = false;
                      _isExpanded4 = false;
                      _isExpanded5 = true;
                      if (ModalRoute.of(context)?.settings.name !=
                          '/historyGraph') {
                        Navigator.pushReplacementNamed(
                            context, "/historyGraph");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(
                      'History',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded5 ? Colors.white : Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              Row(
                children: [
                  // homePage(context),
                  // Text(
                  //   'Energy Usage Monthly',
                  //   style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),
                  // ),
                  // energyUsageMonthly(context)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'Energy Usage Daily',
                  //   style: TextStyle(fontSize: 30),
                  // ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Group : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        child: group(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          'Meter : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          child: meter(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Text(
                          'Date : ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 55,
                          width: 150,
                          child: dateField(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.deferToChild,
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Visibility(
                      // visible: _isExpanded,

                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  10), // เพิ่มการกำหนดรูปร่างของ Container
                            ),
                            width: 800,
                            padding: EdgeInsets.all(
                                10), // เพิ่มการกำหนดระยะห่างภายใน Container
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // จัดตำแหน่งของวัตถุภายใน Column เป็นแนวนอนซ้าย
                              children: <Widget>[
                                SizedBox(height: 2),
                                Container(
                                  width: double
                                      .infinity, // กำหนดความกว้างของกราฟให้เต็มรูปแบบ
                                  height: 300,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: SfCartesianChart(
                                      title: ChartTitle(
                                        text: 'Energy Usage Monthly(kWh)',
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      legend: Legend(
                                        isVisible: true,
                                        position: LegendPosition.bottom,
                                        itemPadding: 9,
                                        iconBorderWidth: 10,
                                        orientation:
                                            LegendItemOrientation.horizontal,
                                        overflowMode:
                                            LegendItemOverflowMode.wrap,
                                      ),
                                      series: <ChartSeries>[
                                        LineSeries<dynamic, dynamic>(
                                          name: isData
                                              ? '$_meterGroup'
                                              : '$_meter1',
                                          dataSource: isData
                                              ? _energyUsageMonthGroup
                                              : _energyUsageMonth,
                                          xValueMapper: (data, _) =>
                                              data[0].toString(),
                                          yValueMapper: (data, _) =>
                                              (data.length > 3 &&
                                                      data[3] != null)
                                                  ? data[3].toDouble()
                                                  : 0,
                                        ),
                                      ],
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                          text: 'Date',
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        labelIntersectAction:
                                            AxisLabelIntersectAction.hide,
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        majorTickLines:
                                            MajorTickLines(color: Colors.black),
                                        minorTickLines:
                                            MinorTickLines(color: Colors.black),
                                        axisLine: AxisLine(color: Colors.black),
                                        majorGridLines: MajorGridLines(
                                            color: Colors.transparent),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        title: AxisTitle(
                                          text: 'Energy (kWh)',
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                        visibleMinimum: 0,
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        majorTickLines:
                                            MajorTickLines(color: Colors.black),
                                        minorTickLines:
                                            MinorTickLines(color: Colors.black),
                                        axisLine: AxisLine(color: Colors.black),
                                        majorGridLines: MajorGridLines(
                                            color: Colors.transparent),
                                        numberFormat: NumberFormat.compact(),
                                        labelFormat: '{value}',
                                      ),
                                      zoomPanBehavior:
                                          ZoomPanBehavior(enablePanning: true),
                                      trackballBehavior: TrackballBehavior(
                                        enable: true,
                                        tooltipDisplayMode:
                                            TrackballDisplayMode.groupAllPoints,
                                        tooltipSettings: InteractiveTooltip(),
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
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _energyUsageMonth.isNotEmpty ||
                            _energyUsageMonthGroup.isNotEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DataTable(
                              columns: [
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Time',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Energy(kWh)',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                              columnSpacing: 117,
                              horizontalMargin: 50,
                              dataRowHeight: 30,
                              headingRowHeight: 40,
                              dividerThickness: 1,
                              rows: isData
                                  ? _energyUsageMonthGroup.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[0]
                                                  .toString(), // Adjust index based on your data structure
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[1]
                                                  .toString(), // Adjust index based on your data structure
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : _energyUsageMonth.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[0]
                                                  .toString(), // Adjust index based on your data structure
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[1]
                                                  .toString(), // Adjust index based on your data structure
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList(),
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (currentIndex != index) {
            setState(() {
              currentIndex = index;
            });

            // Handle navigation to different screens based on the index
            if (currentIndex == 0) {
              // Navigate to the Power Status screen
              Navigator.pushReplacementNamed(context, '/home');
            } else if (currentIndex == 1) {
              // Navigate to the Metering MGMT screen
              Navigator.pushReplacementNamed(context, '/energyUsageDaily');
            } else if (currentIndex == 2) {
              // Navigate to the Energy Report screen
              Navigator.pushReplacementNamed(context, '/groupMeter');
            } else if (currentIndex == 3) {
              // Navigate to the Profile screen
              Navigator.pushReplacementNamed(context, '/userProfile');
            }
          }
        },
        currentIndex: currentIndex,
        backgroundColor: Colors.red[600],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedFontSize: 12,
        unselectedFontSize: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 8,
        // useLegacyColorScheme:false ,

        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.gauge,
              size: 20,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bar_chart_sharp,
              size: 20,
            ),
            label: 'Energy Report',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.wrench,
              size: 20,
            ),
            label: 'Metering MGMT',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }

  InkWell homePage(BuildContext context) {
    return InkWell(
      child: Text('Home'),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }

  InkWell energyUsageDaily1(BuildContext context) {
    return InkWell(
      child: Text('Energy Usage Daily'),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/energyUsageDaily');
      },
    );
  }

  ElevatedButton addNew() {
    return ElevatedButton(child: Text('Add a new'), onPressed: () {});
  }

  TextFormField search() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return null;
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onSaved: (value) {
        // save the input value
      },
      keyboardType: TextInputType.text,
    );
  }

  PopupMenuButton<String> meter() {
    if (_selectedCountry == null || _selectedCountry!.isEmpty) {
      _selectedCountry = "";
    }

    List<PopupMenuItem<String>> popupMenuItems;

    if (_meterName.isEmpty) {
      popupMenuItems = [
        PopupMenuItem<String>(
          value: "",
          child: Center(
            child: Text(
              'Select a country',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: null,
          child: Center(
            child: Text(
              'No available',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ];
    } else {
      popupMenuItems = [
        PopupMenuItem<String>(
          value: "",
          child: Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        ..._meterName.map((country) {
          return PopupMenuItem<String>(
            value: country,
            child: Center(
              child: Text(
                country,
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
      ];
    }

    if (!_hasSelectedCountry(popupMenuItems, _selectedCountry)) {
      _selectedCountry = "";
    }

    return PopupMenuButton<String>(
      initialValue: _selectedCountry,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              _selectedCountry != null ? _selectedCountry! : '',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return popupMenuItems;
      },
      onSelected: (value) async {
        setState(() {
          _selectedCountry = value;
        });

        await Future.wait([
          energyUsageMonth(),
          energyUsageMonthGroup(),
        ]);

        print(_selectedCountry2); // ตรวจสอบค่า _selectedCountry2
      },
    );
  }

  bool _hasSelectedCountry(
      List<PopupMenuItem<String>> items, String? selectedValue) {
    return items.any((item) => item.value == selectedValue);
  }

  PopupMenuButton<String> group() {
    if (_selectedCountry2 == null || _selectedCountry2!.isEmpty) {
      _selectedCountry2 = "";
    }

    List<PopupMenuItem<String>> popupMenuItems;

    if (_groupMeter.isEmpty) {
      popupMenuItems = [
        PopupMenuItem<String>(
          value: "",
          child: Center(
            child: Text(
              'No available',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ];
    } else {
      popupMenuItems = [
        PopupMenuItem<String>(
          value: "",
          child: Center(
            child: Text(
              '',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        ..._groupMeter.map((country) {
          return PopupMenuItem<String>(
            value: country,
            child: Center(
              child: Text(
                country,
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        }).toList(),
      ];
    }

    if (!_hasSelectedCountry2(popupMenuItems, _selectedCountry2)) {
      _selectedCountry2 = "";
    }

    return PopupMenuButton<String>(
      initialValue: _selectedCountry2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              _selectedCountry2 != null
                  ? _selectedCountry2!
                  : 'Select a country',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return popupMenuItems;
      },
      onSelected: (value) async {
        setState(() {
          _selectedCountry2 = value;
        });

        await Future.wait([
          energyUsageMonth(),
          energyUsageMonthGroup(),
        ]);

        print(_selectedCountry2); // ตรวจสอบค่า _selectedCountry2
      },
    );
  }

  bool _hasSelectedCountry2(
      List<PopupMenuItem<String>> items, String? selectedValue) {
    return items.any((item) => item.value == selectedValue);
  }

  GestureDetector datePickerButton(BuildContext context) {
    final DateTime initialDate = DateTime.now();
    final DateTime firstDate = DateTime(1800);
    final DateTime lastDate = DateTime(DateTime.now().year + 5);

    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );
        if (picked != null) {
          String formattedDate = DateFormat('MM-yyyy').format(picked);
          setState(() {
            _dateController.text = formattedDate;
          });
        }
      },
      child: Icon(Icons.calendar_today),
    );
  }

  TextFormField dateField(BuildContext context) {
    return TextFormField(
      controller: _dateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        suffixIcon: datePickerButton(context),
      ),
      keyboardType: TextInputType.datetime,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
      onChanged: (value) async {
        setState(() {
          _selectedCountry = _selectedCountry;
          _selectedCountry2 = _selectedCountry2;
        });
        await Future.wait([
          energyUsageMonth(),
          energyUsageMonthGroup(),
        ]);
      },
      onSaved: (value) {
        // save the selected value
      },
    );
  }

  ElevatedButton ok() {
    return ElevatedButton(
      child: const Text(
        'OK',
        style: TextStyle(color: Colors.lightBlue),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
      onPressed: () async {
        setState(() {
          _selectedCountry = _selectedCountry;
          _selectedCountry2 = _selectedCountry2;
        });
        await Future.wait([
          energyUsageMonth(),
          energyUsageMonthGroup(),
        ]);
      },
    );
  }

  ElevatedButton reset() {
    return ElevatedButton(
        child: const Text(
          'Reset',
          style: TextStyle(color: Colors.lightBlue),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () async {});
  }
}
