import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class HistoryGraph extends StatefulWidget {
  const HistoryGraph({super.key});

  @override
  State<HistoryGraph> createState() => _HistoryGraphState();
}

class _HistoryGraphState extends State<HistoryGraph> {
  final _httpClient = http.Client();
  bool isLoading = false;
  String _meter1 = '';
  String _meterGroup = '';
  bool isData = false;
  bool _isExpanded = false;
  List<dynamic> _tableData = [];
  List<dynamic> _energyUsageYear = [];
  List<dynamic> _energyUsageYearGroup = [];
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
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  bool _isExpanded5 = true;
  List<int> years =
      List.generate(DateTime.now().year - 2017, (index) => 2018 + index);
  int? selectedYear;
  int _currentPage1 = 0;
  int _rowsPerPage1 = 10;
  int _currentPage2 = 0;
  int _rowsPerPage2 = 10;
  int _currentPage3 = 0;
  int _rowsPerPage3 = 10;
  int _currentPage4 = 0;
  int _rowsPerPage4 = 10;
  int _currentPage5 = 0;
  int _rowsPerPage5 = 10;
  int _currentPage6 = 0;
  int _rowsPerPage6 = 10;
  int _currentPage7 = 0;
  int _rowsPerPage7 = 10;
  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isVisible3 = true;
  bool isVisible4 = true;
  bool isVisible5 = false;
  bool isVisible6 = false;
  bool isVisible7 = false;
  @override
  void dispose() {
    // _httpClient.close();

    _dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    energyUsageYear().then((data) {
      setState(() {
        _currentPage1 = 0;
        _currentPage2 = 0;
        _currentPage3 = 0;
        _currentPage4 = 0;
        _currentPage5 = 0;
        _currentPage6 = 0;
        _currentPage7 = 0;
        _energyUsageYear = data;
        _tableData = data;
        _originalData = data;
      });
    });
    energyUsageYearGroup().then((data) {
      setState(() {
        _currentPage1 = 0;
        _currentPage2 = 0;
        _currentPage3 = 0;
        _currentPage4 = 0;
        _currentPage5 = 0;
        _currentPage6 = 0;
        _currentPage7 = 0;
        _energyUsageYearGroup = data;
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

  int get totalPages1 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage1).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage1).ceil();
    }
  }

  int get totalPages2 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage2).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage2).ceil();
    }
  }

  int get totalPages3 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage3).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage3).ceil();
    }
  }

  int get totalPages4 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage4).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage4).ceil();
    }
  }

  int get totalPages5 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage5).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage5).ceil();
    }
  }

  int get totalPages6 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage6).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage6).ceil();
    }
  }

  int get totalPages7 {
    if (isData) {
      return (_energyUsageYearGroup.length / _rowsPerPage7).ceil();
    } else {
      return (_energyUsageYear.length / _rowsPerPage7).ceil();
    }
  }

  List<dynamic> get currentPageData1 {
    final int startIndex = _currentPage1 * _rowsPerPage1;
    final int endIndex = startIndex + _rowsPerPage1;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData2 {
    final int startIndex = _currentPage2 * _rowsPerPage2;
    final int endIndex = startIndex + _rowsPerPage2;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData3 {
    final int startIndex = _currentPage3 * _rowsPerPage3;
    final int endIndex = startIndex + _rowsPerPage3;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData4 {
    final int startIndex = _currentPage4 * _rowsPerPage4;
    final int endIndex = startIndex + _rowsPerPage4;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData5 {
    final int startIndex = _currentPage5 * _rowsPerPage5;
    final int endIndex = startIndex + _rowsPerPage5;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData6 {
    final int startIndex = _currentPage6 * _rowsPerPage6;
    final int endIndex = startIndex + _rowsPerPage6;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  List<dynamic> get currentPageData7 {
    final int startIndex = _currentPage7 * _rowsPerPage7;
    final int endIndex = startIndex + _rowsPerPage7;

    if (isData) {
      if (startIndex < _energyUsageYearGroup.length) {
        return _energyUsageYearGroup.sublist(
            startIndex,
            endIndex > _energyUsageYearGroup.length
                ? _energyUsageYearGroup.length
                : endIndex);
      } else {
        return [];
      }
    } else {
      if (startIndex < _energyUsageYear.length) {
        return _energyUsageYear.sublist(
            startIndex,
            endIndex > _energyUsageYear.length
                ? _energyUsageYear.length
                : endIndex);
      } else {
        return [];
      }
    }
  }

  Future<List<dynamic>> groupMeter() async {
    if (_isExpanded2 == false &&
        _isExpanded3 == false &&
        _isExpanded4 == false &&
        _isExpanded5 == true) {
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
        _isExpanded3 == false &&
        _isExpanded4 == false &&
        _isExpanded5 == true) {
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

  Future<List<dynamic>> energyUsageYear() async {
    if (_selectedCountry != "" &&
        selectedYear != null &&
        _selectedCountry2 == null) {
      isData = false;
      // ดึงค่าวันที่ที่ผู้ใช้เลือกจาก TextEditingController
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/getbyhistorygraph/$selectedYear/6/$_selectedCountry');

      try {
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic meterData = jsonData[0];
            final String meter1 = meterData[1].toString();
            setState(() {
              _meter1 = meter1;
              _energyUsageYear = jsonData;
            });
          } else {
            // Handle case when jsonData is empty
            setState(() {
              _meter1 = 'N/A';
              _energyUsageYear = []; // Set an empty list for _chartOnlineMeter
            });
          }

          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> energyUsageYearGroup() async {
    if (_selectedCountry2 != "" && selectedYear != null) {
      isData = true;
      _selectedCountry = "";
      // ดึงค่าวันที่ที่ผู้ใช้เลือกจาก TextEditingController
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/getbyhistorygraphgroup/$selectedYear/6/$_selectedCountry2');

      try {
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});
        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic meterData = jsonData[0];
            final String meterGroup = meterData[1].toString();
            setState(() {
              _meterGroup = meterGroup;
              _energyUsageYearGroup = jsonData;
            });
          } else {
            // Handle case when jsonData is empty
            setState(() {
              _meterGroup = 'N/A';
              _energyUsageYearGroup =
                  []; // Set an empty list for _chartOnlineMeter
            });
          }

          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
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
                  // // homePage(context),
                  // Text('Energy Usage Yearly', style: TextStyle(fontSize: 32)),
                  // // energyUsageYearly(context)
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
                            width: 215,
                            child: DropdownButton<int>(
                              value: selectedYear,
                              onChanged: (int? newValue) async {
                                // ระบุประเภทข้อมูลเป็น 'int?'
                                setState(() {
                                  selectedYear = newValue!;
                                  _selectedCountry = _selectedCountry;
                                  _selectedCountry2 = _selectedCountry2;
                                });
                                await Future.wait([
                                  energyUsageYear(),
                                  energyUsageYearGroup(),
                                ]);
                              },
                              items:
                                  years.map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                            )),
                      ],
                    ),
                    
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
                                        text:
                                            'Energy Meter : ${isData ? _meterGroup : _meter1}',
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
                                          name: 'kWh Import',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[3],
                                          isVisible: true,
                                          color: Colors.blue,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'kWh Export',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[4],
                                          isVisible: true,
                                          color: Colors.green,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'kWh Total',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[5],
                                          isVisible: true,
                                          color: Colors.orange,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'Demand',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[6],
                                          isVisible: true,
                                          color: Colors.pink,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'Sum P(kW)',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[7],
                                          isVisible: false,
                                          color: Colors.purple,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'Sum Q(kvar)',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[8],
                                          isVisible: false,
                                          color: Colors.red,
                                        ),
                                        LineSeries<dynamic, dynamic>(
                                          name: 'kWh',
                                          dataSource: isData
                                              ? _energyUsageYearGroup
                                              : _energyUsageYear,
                                          width: 2,
                                          sortFieldValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          xValueMapper: (data, _) {
                                            DateTime dateTime =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(data[2].toString());
                                            return dateTime;
                                          },
                                          yValueMapper: (data, _) => data[9],
                                          isVisible: false,
                                          color: Colors.brown,
                                        ),
                                      ],
                                      primaryXAxis: DateTimeAxis(
                                        visibleMinimum: DateTime.now()
                                            .subtract(Duration(days: 5)),
                                        visibleMaximum: DateTime.now(),
                                        dateFormat: DateFormat("dd-MMM"),
                                        intervalType: DateTimeIntervalType.days,
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
                                        minimum: 0,
                                        edgeLabelPlacement:
                                            EdgeLabelPlacement.shift,
                                        numberFormat:
                                            NumberFormat.decimalPattern(),
                                        labelIntersectAction:
                                            AxisLabelIntersectAction.hide,
                                        isVisible: true,
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
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                isData
                                    ? 'Group Name : $_meterGroup'
                                    : 'Meter Name : $_meter1',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "kWh Import",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              PopupMenuButton<int>(
                                initialValue: null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        _currentPage1 != null
                                            ? 'Page ${_currentPage1 + 1}'
                                            : 'Select a page',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                                itemBuilder: (context) {
                                  return List<PopupMenuEntry<int>>.generate(
                                      totalPages1, (index) {
                                    return PopupMenuItem<int>(
                                      value: index,
                                      child: Text(
                                        'Page ${index + 1}',
                                        style: TextStyle(
                                          fontWeight: _currentPage1 == index
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    );
                                  });
                                },
                                onSelected: (value) {
                                  setState(() {
                                    _currentPage1 = value;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'kWh Import',
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
                                  ? currentPageData1.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[3].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData1.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[3].toString(),
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
                  SizedBox(
                    height: 50,
                  ),
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "kWh Export",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage2 != null
                                        ? 'Page ${_currentPage2 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages2, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage2 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage2 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'kWh Export',
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
                                  ? currentPageData2.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[4].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData2.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[4].toString(),
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
                  SizedBox(
                    height: 50,
                  ),
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "kWh Total",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage3 != null
                                        ? 'Page ${_currentPage3 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages3, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage3 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage3 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'kWh Total',
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
                                  ? currentPageData3.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[5].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData3.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[5].toString(),
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
                  SizedBox(
                    height: 50,
                  ),
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Demand",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage4 != null
                                        ? 'Page ${_currentPage4 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages4, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage4 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage4 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Demand',
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
                                  ? currentPageData4.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[6].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData4.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[6].toString(),
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
                  SizedBox(
                    height: 50,
                  ),
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Sum P (kW)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage5 != null
                                        ? 'Page ${_currentPage5 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages5, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage5 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage5 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sum P (kW)',
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
                                  ? currentPageData5.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[7].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData5.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[7].toString(),
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
                  SizedBox(
                    height: 50,
                  ),
                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Sum Q (kvar)",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage6 != null
                                        ? 'Page ${_currentPage6 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages6, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage6 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage6 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Sum Q (kvar)',
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
                                  ? currentPageData6.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[8].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData6.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[8].toString(),
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
                  SizedBox(
                    height: 50,
                  ),

                  if ((_energyUsageYear.isNotEmpty && !isData) ||
                      (_energyUsageYearGroup.isNotEmpty && isData))
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "kWh",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          PopupMenuButton<int>(
                            initialValue: null,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _currentPage7 != null
                                        ? 'Page ${_currentPage7 + 1}'
                                        : 'Select a page',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            itemBuilder: (context) {
                              return List<PopupMenuEntry<int>>.generate(
                                  totalPages7, (index) {
                                return PopupMenuItem<int>(
                                  value: index,
                                  child: Text(
                                    'Page ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: _currentPage7 == index
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                );
                              });
                            },
                            onSelected: (value) {
                              setState(() {
                                _currentPage7 = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: (_energyUsageYear.isNotEmpty && !isData) ||
                            (_energyUsageYearGroup.isNotEmpty && isData)
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
                                      '      Days',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'kWh',
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
                                  ? currentPageData7.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[9].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                      ]);
                                    }).toList()
                                  : currentPageData7.map((table) {
                                      return DataRow(cells: [
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[2].toString(),
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              table[9].toString(),
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

  PopupMenuButton<String> meter() {
    if (_selectedCountry == null || _selectedCountry!.isEmpty) {
      _selectedCountry =
          ""; // เพิ่มบรรทัดนี้เพื่อตั้งค่าตัวแปร _selectedCountry เป็นค่าว่าง
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
      _selectedCountry =
          ""; // เพิ่มบรรทัดนี้เพื่อตั้งค่าตัวแปร _selectedCountry เป็นค่าว่าง
    }

    return PopupMenuButton<String>(
      initialValue: null,
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
          energyUsageYear(),
          energyUsageYearGroup(),
        ]);
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
          energyUsageYear(),
          energyUsageYearGroup(),
        ]);
      },
    );
  }

  bool _hasSelectedCountry2(
      List<PopupMenuItem<String>> items, String? selectedValue) {
    return items.any((item) => item.value == selectedValue);
  }

  ElevatedButton go() {
    return ElevatedButton(child: Text('Go'), onPressed: () {});
  }

  ElevatedButton ok() {
    return ElevatedButton(
      child: const Text(
        'OK',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      onPressed: () async {
        setState(() {
          _selectedCountry = _selectedCountry;
          _selectedCountry2 = _selectedCountry2;
        });
        await Future.wait([
          energyUsageYear(),
          energyUsageYearGroup(),
        ]);
      },
    );
  }

  ElevatedButton reset() {
    return ElevatedButton(
        child: const Text(
          'Reset',
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () async {});
  }
}
