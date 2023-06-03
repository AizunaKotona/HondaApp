import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'package:testest/Energy_Report/energyUsageDaily.dart';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:testest/Energy_Report/energyUsageMonthly.dart';
import 'dart:io';
import 'package:testest/Metering_Management/groupMeter.dart';
import 'package:testest/login/userProfile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
  List<List<dynamic>> combinedData = [];
  int currentIndex = 0;
  late DateTime now;
  late DateTime startOfMonth;
  String? _selectedCountry;
  void initializeDateTime() {
    now = DateTime.now();
    startOfMonth = DateTime(now.year, now.month, 1);
  }

  bool isLoading = false,
      isLoading1 = false,
      isLoading2 = false,
      isLoading3 = false,
      isLoading4 = false,
      isLoading5 = false,
      isLoading6 = false,
      isLoading7 = false,
      isLoading8 = false;
  List<dynamic> _meterName = [];
  bool _isExpanded = false;
  bool _isExpanded2 = true;
  String _meter1 = '';
  List<dynamic> _thisMonthMeter1 = [];
  List<dynamic> _thisYear1 = [];
  final _httpClient = http.Client();
  List<String> _meter1List = [];
  String _departmentName1 = '';
  String _departmentName2 = '';
  bool _isExpanded3 = false;
  String _dataMeter = '';
  String _dataCurrentStatus = '';
  String _dataCurrentStatusoff = '';
  String _mainEMDBName = '';
  String _chartMDBName = '';
  bool _isSwitched = false;

  final textStyleBottomNavigationBar = TextStyle(
    fontWeight: FontWeight.bold,
  );

  // late TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    super.initState();
    thisYear1().then((data) {
      setState(() {
        _thisYear1 = data;
        // isLoading2 = false;
      });
    });
    if (_meterName.isNotEmpty) {
      _selectedCountry = _meterName[0];
    }
    thisMonthMeter1().then((data) {
      setState(() {
        _thisMonthMeter1 = data;
        // isLoading2 = false;
      });
    });

    fetchData();
    currentStatus();
    currentStatusoff();
    _chartMDB().then((data) {
      setState(() {
        _energyDataList = data;
        // isLoading2 = false;
      });
    });
    _chartMAINEMDB().then((data) {
      setState(() {
        _energyDataList2 = data;
        // isLoading3 = false;
      });
    });
    _datameterName().then((name) {
      setState(() {
        _meterName = name;
        // isLoading1 = false;
      });
    });
    _chartDepartment1().then((data) {
      setState(() {
        _energyDepartment = data;
        // isLoading4 = false;
      });
    });
    _chartDepartment2().then((data) {
      setState(() {
        _energyDepartment2 = data;
        // isLoading5 = false;
      });
    });
    _chartOnlineMeter1().then((onlinemid1) {
      setState(() {
        _chartOnlineMeter = onlinemid1;
        // isLoading6 = false;
      });
    });
  }

  void dispose() {
    // _httpClient.close();

    super.dispose();
  }

  Future<List<dynamic>> thisYear1() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energydailys/gettotalenergybyyear/6');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            // final body = response.body.replaceAll('[', '').replaceAll(']', '');
            // final value = double.parse(body);
            setState(() {
              _thisYear1 = jsonData;
              // isLoading4 = false;
            });
          } else {
            // Handle case when jsonData is empty
            setState(() {
              _thisYear1 = []; // Set an empty list for _chartOnlineMeter
            });
          }
          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading4 = false;
        //   });
        // }
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> thisMonthMeter1() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energydailys/gettotalenergybymonth/6');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            setState(() {
              _thisMonthMeter1 = jsonData;
              // isLoading4 = false;
            });
          } else {
            // Handle case when jsonData is empty
            setState(() {
              _thisMonthMeter1 = []; // Set an empty list for _chartOnlineMeter
            });
          }
          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } on SocketException catch (e) {
        // Handle the connection timeout error
        print('Connection timeout: $e');
        setState(() {
          _thisMonthMeter1 = []; // Set an empty list for _chartOnlineMeter
        });
        // You can show an error message to the user or retry the request here
        // ...
        return [];
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading4 = false;
        //   });
        // }
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> fetchData() async {
  if (_isExpanded2 == true && _isExpanded3 == false) {
    final url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/meters/count');
    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json; charset=UTF-8'},
      );

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _dataMeter = response.body;
            // isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _dataMeter = 'N/A';
            // isLoading = false;
          });
        }
        throw Exception('Failed to load data');
      }
      return []; // Return an empty list if the condition is met
    } catch (e) {
      rethrow;
    }
  } else {
    return []; // Return an empty list if the condition is not met
  }
}


  Future<List<dynamic>> _datameterName() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
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

  Future<List<dynamic>> _chartMDB() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/thismonth/6/1');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic chartMDB = jsonData[0];
            final String chartMDBName = chartMDB[2].toString();
            if (mounted) {
              setState(() {
                _chartMDBName = chartMDBName;
                _energyDataList = jsonData;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                _chartMDBName = 'N/A';
                _energyDataList = [];
              });
            }
          }

          final DateTime now = DateTime.now(); // Current date and time
          final DateTime startDate = DateTime(
              now.year, now.month, 1); // Last month in the current month
          final DateTime endDate = DateTime(
              now.year, now.month + 1, 0); // End date of the missing range

          for (DateTime date = startDate;
              date.isBefore(endDate);
              date = date.add(Duration(days: 1))) {
            bool isDateMissing = true;
            for (dynamic data in _energyDataList) {
              final DateTime dataDate = DateTime.parse(data[1].toString());
              if (dataDate.year == date.year &&
                  dataDate.month == date.month &&
                  dataDate.day == date.day) {
                isDateMissing = false;
                break;
              }
            }
            if (isDateMissing) {
              _energyDataList.add([0, date.toString(), 'N/A', 0]);
            }
          }

          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        if (mounted) {
          print('Error: $e');
        }
        rethrow;
      }
    } else {
      return [];
    }
  }

  Future<List<dynamic>> _chartMAINEMDB() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/thismonth/6/3');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic chartMAINEMDB = jsonData[0];
            final String chartmainEMDBName = chartMAINEMDB[2].toString();
            if (mounted) {
              setState(() {
                _mainEMDBName = chartmainEMDBName;
                _energyDataList2 = jsonData;
                // isLoading3 = false;
              });
            }
          } else {
            // Handle case when jsonData is empty
            if (mounted) {
              setState(() {
                _mainEMDBName = 'N/A';
                _energyDataList2 =
                    []; // Set an empty list for _chartOnlineMeter
              });
            }
          }

          final DateTime now = DateTime.now(); // Current date and time
          final DateTime startDate = DateTime(
              now.year, now.month, 1); // Last month in the current month
          final DateTime endDate = DateTime(
              now.year, now.month + 1, 0); // End date of the missing range

          for (DateTime date = startDate;
              date.isBefore(endDate);
              date = date.add(Duration(days: 1))) {
            bool isDateMissing = true;
            for (dynamic data in _energyDataList2) {
              final DateTime dataDate = DateTime.parse(data[1].toString());
              if (dataDate.year == date.year &&
                  dataDate.month == date.month &&
                  dataDate.day == date.day) {
                isDateMissing = false;
                break;
              }
            }
            if (isDateMissing) {
              _energyDataList2.add([0, date.toString(), 'N/A', 0]);
            }
          }

          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        if (mounted) {
          // if (mounted) {
          //   setState(() {
          //     isLoading3 = false;
          //   });
          // }
        }
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> _chartDepartment1() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      if (!mounted) {
        // Check if the widget is still mounted
        return [];
      }

      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/deptmonth/6/24');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic departmentData1 = jsonData[0];
            final String departmentName1 = departmentData1[4].toString();

            if (mounted) {
              setState(() {
                _departmentName1 = departmentName1;
                _energyDepartment = jsonData;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                _departmentName1 = 'N/A';
                _energyDepartment = [];
              });
            }
          }

          final DateTime now = DateTime.now(); // Current date and time
          final DateTime startDate = DateTime(
              now.year, now.month, 1); // Last month in the current month
          final DateTime endDate = DateTime(
              now.year, now.month + 1, 0); // End date of the missing range

          for (DateTime date = startDate;
              date.isBefore(endDate);
              date = date.add(Duration(days: 1))) {
            bool isDateMissing = true;
            for (dynamic data in _energyDepartment) {
              final DateTime dataDate = DateTime.parse(data[0].toString());
              if (dataDate.year == date.year &&
                  dataDate.month == date.month &&
                  dataDate.day == date.day) {
                isDateMissing = false;
                break;
              }
            }
            if (isDateMissing) {
              _energyDepartment.add([date.toString(), 0]);
            }
          }

          return jsonData;
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

  Future<List<dynamic>> _chartDepartment2() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      if (!mounted) {
        // Check if the widget is still mounted
        return [];
      }

      try {
        final url = Uri.parse(
            'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/deptmonth/6/25');
        final response = await http
            .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic departmentData2 = jsonData[0];
            final String departmentName2 = departmentData2[4].toString();

            if (!mounted) {
              // Check if the widget is still mounted before calling setState
              return [];
            }

            setState(() {
              _departmentName2 = departmentName2;
              _energyDepartment2 = jsonData;
            });
          } else {
            if (!mounted) {
              // Check if the widget is still mounted before calling setState
              return [];
            }

            // Handle case when jsonData is empty
            setState(() {
              _departmentName2 = 'N/A';
              _energyDepartment2 = [];
            });
          }

          final DateTime now = DateTime.now(); // Current date and time
          final DateTime startDate = DateTime(
              now.year, now.month, 1); // Last month in the current month
          final DateTime endDate = DateTime(
              now.year, now.month + 1, 0); // End date of the missing range

          for (DateTime date = startDate;
              date.isBefore(endDate);
              date = date.add(Duration(days: 1))) {
            bool isDateMissing = true;
            for (dynamic data in _energyDepartment2) {
              final DateTime dataDate = DateTime.parse(data[0].toString());
              if (dataDate.year == date.year &&
                  dataDate.month == date.month &&
                  dataDate.day == date.day) {
                isDateMissing = false;
                break;
              }
            }
            if (isDateMissing) {
              _energyDepartment2.add([date.toString(), 0]);
            }
          }

          return jsonData;
        } else {
          throw Exception('Failed to load data');
        }
      } on SocketException catch (e) {
        // Handle the connection timeout error
        print('Connection timeout: $e');
        if (!mounted) {
          // Check if the widget is still mounted before calling setState
          return [];
        }

        setState(() {
          _departmentName2 = 'N/A';
          _energyDepartment2 = [];
        });
        // You can show an error message to the user or retry the request here
        // ...
        return [];
      } catch (e) {
        // Handle other exceptions
        print('Error: $e');
        rethrow;
      }
    } else {
      // Add a return statement here to handle the case when the condition is not met
      return [];
    }
  }

  Future<List<dynamic>> _chartOnlineMeter1() async {
    if (_isExpanded3 == true &&
        _isExpanded2 == false &&
        _selectedCountry != null) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/energys/online/6/${_selectedCountry}');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          if (jsonData.isNotEmpty) {
            final dynamic meterData = jsonData[0];
            final String meter1 = meterData[3].toString();
            setState(() {
              _meter1 = meter1;
              _chartOnlineMeter =
                  jsonData; // Set the value of _chartOnlineMeter
            });
          } else {
            // Handle case when jsonData is empty
            setState(() {
              _meter1 = 'N/A';
              _chartOnlineMeter = []; // Set an empty list for _chartOnlineMeter
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

  Future<List<dynamic>> currentStatus() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/meters/current_status');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          setState(() {
            _dataCurrentStatus = response.body;
            // isLoading7 = false;
          });
        } else {
          setState(() {
            _dataCurrentStatus = 'N/A';
            // isLoading7 = false;
          });
          throw Exception('Failed to load data');
        }
        return []; // Return an empty list if the condition is met
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading7 = false;
        //   });
        // }
        rethrow;
      }
    } else {
      return []; // Return an empty list if the condition is not met
    }
  }

  Future<List<dynamic>> currentStatusoff() async {
    if (_isExpanded2 == true && _isExpanded3 == false) {
      final url = Uri.parse(
          'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/meters/current_statusoff');
      try {
        final response = await http.get(
          url,
          headers: {'Accept': 'application/json; charset=UTF-8'},
        );

        if (response.statusCode == 200) {
          setState(() {
            _dataCurrentStatusoff = response.body;
            // isLoading8 = false;
          });
        } else {
          setState(() {
            _dataCurrentStatusoff = 'N/A';
            // isLoading8 = false;
          });
          throw Exception('Failed to load data');
        }
        return []; // Return an empty list if the condition is met
      } catch (e) {
        // if (mounted) {
        //   setState(() {
        //     isLoading8 = false;
        //   });
        // }
        rethrow;
      }
    } else {
      return []; // Return an empty list if the condition is not met
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(85), // Set the preferred height of the AppBar
        child: AppBar(
          title: Text(
            'Dashboard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[600],
          // Add other properties and widgets to the AppBar as needed
        ),
      ),
      body: Stack(children: <Widget>[
        ListView(
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
                          leading: FaIcon(
                            FontAwesomeIcons.server,
                            color: Colors.white,
                            size: 32.0,
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _dataMeter.isNotEmpty ? ('$_dataMeter') : 'N/A',
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
                      color: const Color.fromARGB(255, 117, 202, 43),
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
                                _dataCurrentStatus.isNotEmpty &&
                                        _dataCurrentStatusoff.isNotEmpty
                                    ? ('$_dataCurrentStatus/$_dataCurrentStatusoff')
                                    : 'N/A',
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
                      color: Colors.orange[400],
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
                                _thisMonthMeter1.isNotEmpty
                                    ? (_thisMonthMeter1[0].toDouble())
                                        .toStringAsFixed(2)
                                    : 'N/A',
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
                                _thisYear1.isNotEmpty
                                    ? (_thisYear1[0].toDouble())
                                        .toStringAsFixed(2)
                                    : 'N/A',
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
            SingleChildScrollView(
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
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                      ), // Added right padding for spacing
                      child: Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isExpanded2 ? Colors.red : Colors.black,
                          letterSpacing:
                              1.2, // Increased letter spacing for emphasis
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded2 = false;
                        _isExpanded3 = true;
                        _chartOnlineMeter1();
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20), // Added right padding for spacing
                      child: Text(
                        'Online Values',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isExpanded3 ? Colors.red : Colors.black,
                          letterSpacing:
                              1.2, // Increased letter spacing for emphasis
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isExpanded2 && !_isExpanded3,
              child: Column(children: [
                GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
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
                            Row(
                              children: [
                                Icon(Icons.bar_chart_sharp),
                                SizedBox(
                                    width:
                                        5), // เพิ่มระยะห่างระหว่าง Icon และ Text
                                Text(
                                  'Main Meter',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2), // เพิ่มระยะห่างระหว่างรายการ
                            Container(
                              width: double
                                  .infinity, // กำหนดความกว้างของกราฟให้เต็มรูปแบบ
                              height:
                                  300, // ปรับค่าความสูงของ Container สำหรับกราฟ
                              child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: SfCartesianChart(
                                    title: ChartTitle(
                                      text:
                                          'Energy By Main Meter\n${DateFormat('MMMM yyyy').format(DateTime.now())}',
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    legend: Legend(
                                      isVisible: true,
                                      position: LegendPosition.top,
                                      itemPadding: 9,
                                      iconBorderWidth: 10,
                                      orientation:
                                          LegendItemOrientation.horizontal,
                                      overflowMode: LegendItemOverflowMode.wrap,
                                      textStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    series: <ChartSeries>[
                                      ColumnSeries<dynamic, dynamic>(
                                        name: "$_mainEMDBName",
                                        dataSource: _energyDataList2
                                          ..sort((a, b) => DateFormat(
                                                  "yyyy-MM-dd")
                                              .parse(a[1].toString())
                                              .compareTo(
                                                  DateFormat("yyyy-MM-dd")
                                                      .parse(b[1].toString()))),
                                        xValueMapper: (data, _) =>
                                            DateFormat("yyyy-MM-dd")
                                                .parse(data[1].toString()),
                                        yValueMapper: (data, _) => data[3],
                                      ),
                                      ColumnSeries<dynamic, dynamic>(
                                        name: '$_chartMDBName',
                                        dataSource: _energyDataList
                                          ..sort((a, b) => DateFormat(
                                                  "yyyy-MM-dd")
                                              .parse(a[1].toString())
                                              .compareTo(
                                                  DateFormat("yyyy-MM-dd")
                                                      .parse(b[1].toString()))),
                                        xValueMapper: (data, _) =>
                                            DateFormat("yyyy-MM-dd")
                                                .parse(data[1].toString()),
                                        yValueMapper: (data, _) => data[3],
                                        color: Colors.green,
                                      ),
                                    ],
                                    primaryXAxis: DateTimeAxis(
                                      title: AxisTitle(
                                        text: 'Date',
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
                                      ),
                                      visibleMinimum: DateTime.now()
                                          .subtract(Duration(days: 1)),
                                      visibleMaximum:
                                          DateTime.now().add(Duration(days: 4)),
                                      dateFormat: DateFormat("dd"),
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
                                      labelFormat: '{value}',
                                    ),
                                    primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                        text: 'Energy (kWh)',
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13),
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
                                      numberFormat:
                                          NumberFormat.decimalPattern(),
                                      labelFormat: '{value}',
                                    ),
                                    tooltipBehavior: TooltipBehavior(
                                      enable: true,
                                      duration: 3000,
                                      header: '',
                                      format:
                                          'point.x\nseries.name : point.y kWh',
                                    ),
                                    zoomPanBehavior: ZoomPanBehavior(
                                      enablePanning: true,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.deferToChild,
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
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
                            Row(
                              children: [
                                Icon(Icons.bar_chart_sharp),
                                SizedBox(
                                    width:
                                        5), // เพิ่มระยะห่างระหว่าง Icon และ Text
                                Text(
                                  'By Department',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2), // เพิ่มระยะห่างระหว่างรายการ
                            Container(
                              width: double
                                  .infinity, // กำหนดความกว้างของกราฟให้เต็มรูปแบบ
                              height:
                                  300, // ปรับค่าความสูงของ Container สำหรับกราฟ
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: SfCartesianChart(
                                  title: ChartTitle(
                                    text:
                                        'Energy By Department\n${DateFormat('MMMM yyyy').format(DateTime.now())}',
                                    textStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight
                                          .bold, // Adjust the font size as per your needs
                                    ),
                                  ),
                                  legend: Legend(
                                    isVisible: true,
                                    position: LegendPosition.top,
                                    itemPadding: 9,
                                    iconBorderWidth: 10,
                                    orientation:
                                        LegendItemOrientation.horizontal,
                                    overflowMode: LegendItemOverflowMode.wrap,
                                    textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  series: <ChartSeries>[
                                    ColumnSeries<dynamic, dynamic>(
                                      name: "$_departmentName1",
                                      dataSource: _energyDepartment
                                        ..sort((a, b) {
                                          DateTime dateTimeA =
                                              DateFormat("yyyy-MM-dd")
                                                  .parse(a[0].toString());
                                          DateTime dateTimeB =
                                              DateFormat("yyyy-MM-dd")
                                                  .parse(b[0].toString());
                                          return dateTimeA.compareTo(dateTimeB);
                                        }),
                                      xValueMapper: (data, _) {
                                        DateTime dateTime =
                                            DateFormat("yyyy-MM-dd")
                                                .parse(data[0].toString());
                                        return dateTime;
                                      },
                                      yValueMapper: (data, _) => (data.length >
                                                  3 &&
                                              data[3] != null)
                                          ? data[3]
                                          : 0, // กำหนดให้มีค่าเป็น 0 เมื่อไม่มีข้อมูล
                                    ),
                                    ColumnSeries<dynamic, dynamic>(
                                      name: '$_departmentName2',
                                      dataSource: _energyDepartment2
                                        ..sort((a, b) {
                                          DateTime dateTimeA =
                                              DateFormat("yyyy-MM-dd")
                                                  .parse(a[0].toString());
                                          DateTime dateTimeB =
                                              DateFormat("yyyy-MM-dd")
                                                  .parse(b[0].toString());
                                          return dateTimeA.compareTo(dateTimeB);
                                        }),
                                      xValueMapper: (data, _) {
                                        DateTime dateTime =
                                            DateFormat("yyyy-MM-dd")
                                                .parse(data[0].toString());
                                        return dateTime;
                                      },
                                      yValueMapper: (data, _) =>
                                          (data.length > 3 && data[3] != null)
                                              ? data[3]
                                              : 0,

                                      // กำหนดให้มีค่าเป็น 0 เมื่อไม่มีข้อมูล
                                      color: Colors.green,
                                    ),
                                  ],
                                  primaryXAxis: DateTimeAxis(
                                    title: AxisTitle(
                                      text: 'Date',
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    visibleMinimum: DateTime.now()
                                        .subtract(Duration(days: 1)),
                                    visibleMaximum:
                                        DateTime.now().add(Duration(days: 4)),
                                    dateFormat: DateFormat("dd"),
                                    intervalType: DateTimeIntervalType.days,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.hide,
                                    labelStyle: TextStyle(color: Colors.black),
                                    majorTickLines:
                                        MajorTickLines(color: Colors.black),
                                    minorTickLines:
                                        MinorTickLines(color: Colors.black),
                                    axisLine: AxisLine(color: Colors.black),
                                    majorGridLines: MajorGridLines(
                                        color: Colors.transparent),
                                    labelFormat: '{value}',
                                  ),
                                  primaryYAxis: NumericAxis(
                                    title: AxisTitle(
                                      text: 'Energy (kWh)',
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13),
                                    ),
                                    visibleMinimum: 0,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                    labelStyle: TextStyle(color: Colors.black),
                                    majorTickLines:
                                        MajorTickLines(color: Colors.black),
                                    minorTickLines:
                                        MinorTickLines(color: Colors.black),
                                    axisLine: AxisLine(color: Colors.black),
                                    majorGridLines: MajorGridLines(
                                        color: Colors.transparent),
                                    numberFormat: NumberFormat.decimalPattern(),
                                    labelFormat: '{value}',
                                  ),
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    duration: 3000,
                                    header: '',
                                    format:
                                        'point.x\nseries.name : point.y  kWH',
                                  ),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enablePanning: true,
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
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
                visible: _isExpanded3 && !_isExpanded2,
                child: Container(
                    child: Column(children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "   Select Meter :",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: meter(),
                            ),
                            // SizedBox(height: 10,)
                          ],
                        ),
                        // if (_selectedCountry == _meter1)
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
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
                                                  'Live Energy Meter : $_selectedCountry',
                                              textStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.top,
                                            itemPadding: 9,
                                            iconBorderWidth: 10,
                                            orientation: LegendItemOrientation
                                                .horizontal,
                                            overflowMode:
                                                LegendItemOverflowMode.wrap,
                                            textStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          series: <ChartSeries>[
                                            LineSeries<dynamic, dynamic>(
                                              name: 'kWh Import',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      4]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.blue,
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'kWh Export',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      5]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.green,
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'kWh Total',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      6]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 255, 145, 0),
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'Demand',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      7]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.pink,
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'Sum P(kW)',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      8]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.deepPurple,
                                              isVisible:
                                                  false, // Initially hidden
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'Sum Q(kvar)',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      9]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.red,
                                              isVisible:
                                                  false, // Initially hidden
                                            ),
                                            LineSeries<dynamic, dynamic>(
                                              name: 'kWh',
                                              dataSource: _chartOnlineMeter,
                                              xValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  // Return time values from 00:00 to 23:00
                                                  int hour = _.toInt();
                                                  DateTime currentDate =
                                                      DateTime.now();
                                                  return DateFormat('HH:mm')
                                                      .format(DateTime(
                                                    currentDate.year,
                                                    currentDate.month,
                                                    currentDate.day,
                                                    hour,
                                                    0,
                                                  ));
                                                } else {
                                                  return onlinemid1[2]
                                                      .toString();
                                                }
                                              },
                                              yValueMapper: (onlinemid1, _) {
                                                if (_chartOnlineMeter.isEmpty) {
                                                  return 0; // ใส่ค่า 0 ในกรณีที่ _chartOnlineMeter ว่างเปล่า
                                                } else {
                                                  return onlinemid1[
                                                      10]; // ใช้ค่า onlinemid1[4] ในกรณีอื่นๆ
                                                }
                                              },
                                              width: 2,
                                              color: Colors.brown,
                                              isVisible:
                                                  false, // Initially hidden
                                            ),
                                          ],
                                          primaryXAxis: CategoryAxis(
                                            visibleMinimum:
                                                0, // set the minimum value of x-axis
                                            visibleMaximum: 23,
                                            title: AxisTitle(
                                              text: 'Hours',
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
                                            majorTickLines: MajorTickLines(
                                                color: Colors.black),
                                            minorTickLines: MinorTickLines(
                                                color: Colors.black),
                                            axisLine:
                                                AxisLine(color: Colors.black),
                                            majorGridLines: MajorGridLines(
                                                color: Colors.transparent),
                                          ),
                                          primaryYAxis: NumericAxis(
                                            title: AxisTitle(
                                              text: 'Energy (kWh)',
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
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
                                            majorTickLines: MajorTickLines(
                                                color: Colors.black),
                                            minorTickLines: MinorTickLines(
                                                color: Colors.black),
                                            axisLine:
                                                AxisLine(color: Colors.black),
                                            majorGridLines: MajorGridLines(
                                                color: Colors.transparent),
                                          ),
                                          zoomPanBehavior: ZoomPanBehavior(
                                            enablePanning: true,
                                          ),
                                          trackballBehavior: TrackballBehavior(
                                            enable: true,
                                            tooltipDisplayMode:
                                                TrackballDisplayMode
                                                    .groupAllPoints,
                                            tooltipSettings:
                                                InteractiveTooltip(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]))),
          ],
        ),
      ]),
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
          ), BottomNavigationBarItem(
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
      _selectedCountry = "";
    }

    List<PopupMenuItem<String>> popupMenuItems;

    if (_meterName.isEmpty) {
      popupMenuItems = [
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
      popupMenuItems = _meterName.map((country) {
        return PopupMenuItem<String>(
          value: country,
          child: Center(
            child: Text(
              country,
              style: TextStyle(
                fontSize: 14,
                fontWeight: country == _selectedCountry
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList();
    }

    if (!_hasSelectedCountry(popupMenuItems, _selectedCountry)) {
      _selectedCountry = popupMenuItems[0].value;
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
              _selectedCountry != null ? _selectedCountry! : 'Select a country',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return popupMenuItems;
      },
      onSelected: (value) {
        setState(() {
          _selectedCountry = value;
        });
        _chartOnlineMeter1();
      },
    );
  }

  bool _hasSelectedCountry(
      List<PopupMenuItem<String>> items, String? selectedValue) {
    return items.any((item) => item.value == selectedValue);
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

  pagechange() {
    if (currentIndex == 1) {
      Navigator.pushNamed(context, '/home');
    }
    if (currentIndex == 2) {
      Navigator.pushNamed(context, '/groupMeter');
    }
    if (currentIndex == 3) {
      Navigator.pushNamed(context, '/energyUsageDaily');
    }
    if (currentIndex == 4) {
      Navigator.pushNamed(context, '/userProfile');
    }
  }
}
