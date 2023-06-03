import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'package:testest/Energy_Report/energyUsageDaily.dart';
import 'package:testest/Metering_Management/groupMeter.dart';
import 'dart:convert';

import 'package:testest/Power%20Status/hompage.dart';
import 'package:testest/login/userProfile.dart';

class Meter extends StatefulWidget {
  const Meter({super.key});

  @override
  State<Meter> createState() => _MeterState();
}

class _MeterState extends State<Meter> {
  final _httpClient = http.Client();
  bool isLoading = false;
  List<dynamic> _tableData2 = [];
  TextEditingController _searchController2 = TextEditingController();
  String _searchValue2 = '';
  List<dynamic> _originalData2 = [];
  int currentIndex = 2;
  List<dynamic> _departmentName = [];
  bool _isExpanded2 = false;
  bool _isExpanded3 = true;
  bool _isExpanded4 = false;
  List<dynamic> _nodetName = [];
  String? _selectedNodeName = 'Node';
  @override
  void initState() {
    super.initState();
    
    departmentName().then((name) {
      setState(() {
        _departmentName = name;
        // isLoading1 = false;
      });
    });
    if (_departmentName.isNotEmpty) {
      _selectedDeptName = 'Department';
    }
    nodeName().then((name) {
      setState(() {
        _nodetName = name;
        // isLoading1 = false;
      });
    });
    if (_nodetName.isNotEmpty) {
      _selectedNodeName = 'Node';
    }
    _fetchTabalDataMeter().then((table) {
    setState(() {
      _tableData2 = table;
      _originalData2 = table;
      _tableData2 = _originalData2
          .where((table) => table.any((element) =>
              element.toString().toLowerCase().startsWith(_searchValue2.toLowerCase())))
          .toList();
    });
  });
  }

  Future<List<dynamic>> departmentName() async {
    // setState(() {
    //   isLoading1 = true;
    // });
    final url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/department/departmentname');
    try {
      final response = await http
          .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          setState(() {
            _departmentName = jsonData;
          });
        } else {
          setState(() {
            _departmentName = [];
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
  }

  Future<List<dynamic>> nodeName() async {
    // setState(() {
    //   isLoading1 = true;
    // });
    final url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/nodes/nodename');
    try {
      final response = await http
          .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isNotEmpty) {
          setState(() {
            _nodetName = jsonData;
          });
        } else {
          setState(() {
            _nodetName = [];
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
  }

  Future<List<dynamic>> _fetchTabalDataMeter() async {
  final selectedCountry = _selectedCountry?.toLowerCase().replaceAll(' ', '');
  
  final url = Uri.parse(
      'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/meters/getallmeter/6/${_selectedNodeName}/${_selectedDeptName}/${selectedCountry}/${_selectedASC2}');
  try {
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    rethrow;
  }
}

  @override
  void dispose() {
    // _httpClient.close();
    _searchController2.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Metering Management',
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
                      if (ModalRoute.of(context)?.settings.name !=
                          '/groupMeter') {
                        Navigator.pushReplacementNamed(context, "/groupMeter");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                    ), // Added right padding for spacing
                    child: Text(
                      'Group Meter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded2 ? Colors.black : Colors.white,
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
                      _isExpanded3 = false;
                      _isExpanded4 = true;
                      if (ModalRoute.of(context)?.settings.name != '/profile') {
                        Navigator.pushReplacementNamed(context, "/profile");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20), // Added right padding for spacing
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded4 ? Colors.black : Colors.white,
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
                      _isExpanded4 = false;
                      if (ModalRoute.of(context)?.settings.name != '/meter') {
                        Navigator.pushReplacementNamed(context, "/meter");
                      }
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                      left: 10,
                    ), // Added right padding for spacing
                    child: Text(
                      'Meter',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isExpanded3 ? Colors.black : Colors.white,
                        letterSpacing:
                            1.2, // Increased letter spacing for emphasis
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
              // Row(
              //   children: [homePage(context), Text('/'), meter(context)],
              // ),
              Visibility(
                visible: _isExpanded3 && !_isExpanded2 && !_isExpanded4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meter',
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text('Node:'),
                        Text(
                            '                                          Department:')
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          SizedBox(
                            child: node(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            child: department(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Text(
                            'Order by :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            child: orderBy3(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            child: orderBy5(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: DataTable(
                                  columnSpacing: 58.0,
                                  headingRowHeight: 48.0,
                                  dataRowHeight: 48.0,
                                  dividerThickness: 1.0,
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        'Meter ID	',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    DataColumn(
                                        label: Text(
                                      'Meter Name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'description',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Location',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Department',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Area',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Branch name',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Online Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'Lasted Update',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ],
                                  rows: _tableData2.map((table) {
                                    return DataRow(cells: [
                                      DataCell(
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(table[0].toString(),
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(table[1].toString(),
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                      DataCell(
                                        Container(
                                          alignment: Alignment.center,
                                          child: Text(table[2].toString(),
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(table[3],
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(table[4],
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(table[5],
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                            table[6] == '1'
                                                ? 'เปิดใช้งาน'
                                                : 'ไม่เปิดใช้งาน',
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(table[7],
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                      DataCell(
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: 80, maxHeight: 40),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: table[6] == '1'
                                                  ? Colors.green
                                                  : Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              table[8] ? 'Online' : 'Offline',
                                              style: TextStyle(fontSize: 12),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataCell(Container(
                                        alignment: Alignment.center,
                                        child: Text(table[9],
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      )),
                                    ]);
                                  }).toList(),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
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

  String? _selectedCountry = 'Meter ID';

  PopupMenuButton<String> orderBy3() {
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
              _selectedCountry != null ? _selectedCountry! : 'Select a country',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'Meter ID',
            child: Text(
              'Meter ID',
              style: TextStyle(
                fontWeight: _selectedCountry == 'Meter ID'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'Meter Name',
            child: Text(
              'Meter Name',
              style: TextStyle(
                fontWeight: _selectedCountry == 'Meter Name'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'Status',
            child: Text(
              'Status',
              style: TextStyle(
                fontWeight: _selectedCountry == 'Status'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'Online Status',
            child: Text(
              'Online Status',
              style: TextStyle(
                fontWeight: _selectedCountry == 'Online Status'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ];
      },
      onSelected: (value) {
        setState(() {
          _selectedCountry = value;
          _fetchTabalDataMeter().then((table) {
            setState(() {
              _tableData2 = table;
              _originalData2 = table;
              _tableData2 = _originalData2
                  .where((table) => table.any((element) => element
                      .toString()
                      .toLowerCase()
                      .startsWith(_searchValue2.toLowerCase())))
                  .toList();
            });
          });
        });
      },
    );
  }

  String? _selectedDeptName = 'Department'; // เปลี่ยนเป็นประเภทตัวแปรแบบ nullable String

  PopupMenuButton<String> department() {
    if (_selectedDeptName == null || _selectedDeptName!.isEmpty) {
      _selectedDeptName = "Department";
    }

    List<PopupMenuItem<String>> popupMenuItems;

    if (_departmentName.isEmpty) {
      popupMenuItems = [
        PopupMenuItem<String>(
          value: "Department",
          child: Center(
            child: Text(
              'Select a department',
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
          value: "Department",
          child: Center(
            child: Text(
              'Department',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        ..._departmentName.map((department) {
          return PopupMenuItem<String>(
            value: department,
            child: Center(
              child: Text(
                department,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: department == _selectedDeptName
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ];
    }

    if (!_hasSelectedCountry(popupMenuItems, _selectedDeptName)) {
      _selectedDeptName = "Department";
    }

    return PopupMenuButton<String>(
      initialValue: _selectedDeptName,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              _selectedDeptName != null ? _selectedDeptName! : 'Department',
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
          _selectedDeptName = value;
        _fetchTabalDataMeter().then((table) {
            setState(() {
              _tableData2 = table;
              _originalData2 = table;
              _tableData2 = _originalData2
                  .where((table) => table.any((element) => element
                      .toString()
                      .toLowerCase()
                      .startsWith(_searchValue2.toLowerCase())))
                  .toList();
            });
          });
        });
        departmentName();
      },
    );
  }

  bool _hasSelectedCountry(
      List<PopupMenuItem<String>> items, String? selectedValue) {
    return items.any((item) => item.value == selectedValue);
  }

  PopupMenuButton<String> node() {
  if (_selectedNodeName == null || _selectedNodeName!.isEmpty) {
    _selectedNodeName = "Noe";
  }

  List<PopupMenuItem<String>> popupMenuItems;

  if (_nodetName.isEmpty) {
    popupMenuItems = [
      PopupMenuItem<String>(
        value: "Node",
        child: Center(
          child: Text(
            'Select a node',
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
        value: "Node",
        child: Center(
          child: Text(
            'Node',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
      ..._nodetName.map((node) {
        return PopupMenuItem<String>(
          value: node,
          child: Center(
            child: Text(
              node,
              style: TextStyle(
                fontSize: 14,
                fontWeight: node == _selectedNodeName
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    ];
  }

  if (!_hasSelectedCountry2(popupMenuItems, _selectedNodeName)) {
    _selectedNodeName = "Node";
  }

  return PopupMenuButton<String>(
    initialValue: _selectedNodeName != "Node" ? _selectedNodeName : null,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Text(
            _selectedNodeName != "Node" ? _selectedNodeName! : 'Node',
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
        _selectedNodeName = value;
      });
      _fetchTabalDataMeter().then((table) {
        setState(() {
          _tableData2 = table;
          _originalData2 = table;
          _tableData2 = _originalData2
              .where((table) => table.any((element) => element
                  .toString()
                  .toLowerCase()
                  .startsWith(_searchValue2.toLowerCase())))
              .toList();
        });
      });
    },
  );
}

bool _hasSelectedCountry2(
    List<PopupMenuItem<String>> items, String? selectedValue) {
  return items.any((item) => item.value == selectedValue);
}


  String? _selectedASC2 = 'asc';

  PopupMenuButton<String> orderBy5() {
    return PopupMenuButton<String>(
      initialValue: _selectedASC2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              _selectedASC2 != null ? _selectedASC2! : 'Select an order',
              style: TextStyle(fontSize: 16.0),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'asc',
            child: Text(
              'asc',
              style: TextStyle(
                fontWeight: _selectedASC2 == 'asc'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'desc',
            child: Text(
              'desc',
              style: TextStyle(
                fontWeight: _selectedASC2 == 'desc'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ];
      },
      onSelected: (value) {
        setState(() {
          _selectedASC2 = value;

          _fetchTabalDataMeter().then((table) {
            setState(() {
              _tableData2 = table;
              _originalData2 = table;
              _tableData2 = _originalData2
                  .where((table) => table.any((element) => element
                      .toString()
                      .toLowerCase()
                      .startsWith(_searchValue2.toLowerCase())))
                  .toList();
            });
          });
        });
      },
    );
  }

  ElevatedButton go() {
    return ElevatedButton(child: Text('Go'), onPressed: () {});
  }
}
