import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:convert' show utf8;
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupMeter extends StatefulWidget {
  const GroupMeter({super.key});

  @override
  State<GroupMeter> createState() => _GroupMeterState();
}

class _GroupMeterState extends State<GroupMeter> {
  final _httpClient = http.Client();
  List<dynamic> _tableData = [];
  TextEditingController _searchController = TextEditingController();
  String _searchValue = '';
  TextEditingController _searchController2 = TextEditingController();
  String _searchValue2 = '';
  TextEditingController _searchController3 = TextEditingController();
  String _searchValue3 = '';
  List<dynamic> _originalData = [];
  bool isLoading = false;
  bool _isExpanded2 = true;
  bool _isExpanded3 = false;
  bool _isExpanded4 = false;
  List<dynamic> _originalData2 = [];
  List<dynamic> _tableData2 = [];
  List<dynamic> _originalData3 = [];
  List<dynamic> _tableData3 = [];
  int currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _fetchTabalDataGroupMeter().then((table) {
      setState(() {
        _tableData = table;
        _originalData = table;
      });
    });
  }

  Future<List<dynamic>> _fetchTabalDataGroupMeter() async {
    // setState(() {
    //       isLoading = true;
    //     });
    final url = Uri.parse(
        'http://103.74.254.174:8080/Honda-0.0.1-SNAPSHOT/api/group/getallgroup/${_selectedCountry}/${_selectedASC}');
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
      // setState(() {
      //   isLoading = false;
      // });
      rethrow;
    }
  }

  @override
  void dispose() {
    // _httpClient.close();
    _searchController.dispose();

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
              Visibility(
                visible: _isExpanded2 && !_isExpanded3 && !_isExpanded4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    SizedBox(
                      width: 265,
                      height: 60,
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchValue = value;
                            if (_searchValue.isEmpty) {
                              // If search value is empty, show all the data
                              _tableData = _originalData;
                            } else {
                              _tableData = _originalData
                                  .where((table) => table.any((element) =>
                                      element
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(
                                              _searchValue.toLowerCase())))
                                  .toList();
                            }
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20.0),
                          hintText: 'Search',
                          // prefixIcon: Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _searchValue = '';
                                      _tableData = _originalData;
                                    });
                                  },
                                )
                              : null,
                        ),
                        style: TextStyle(fontSize: 16.0),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(height: 10),
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
                            child: orderBy(),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          SizedBox(
                            child: orderBy2(),
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
                                columnSpacing: 16.0,
                                headingRowHeight: 48.0,
                                dataRowHeight: 48.0,
                                dividerThickness: 1.0,
                                columns: [
                                  DataColumn(
                                    label: Text('Virtual Meter ID',
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn(
                                    label: Text('Virtual Meter Name',
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn(
                                    label: Text('Department',
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn(
                                    label: Text('Area',
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                  DataColumn(
                                    label: Text('Register date',
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                  ),
                                ],
                                rows: _tableData.map((table) {
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
                                    DataCell(
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(table[3].toString(),
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(table[4].toString(),
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ]);
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
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

  InkWell homePage(BuildContext context) {
    return InkWell(
      child: Text('Home'),
      onTap: () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }

  TextFormField search2() {
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

  TextFormField search() {
    return TextFormField();
  }

  String? _selectedCountry = 'gid';
  PopupMenuButton<String> orderBy() {
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
            value: 'gid',
            child: Text(
              'gid',
              style: TextStyle(
                fontWeight: _selectedCountry == 'gid'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'gname',
            child: Text(
              'gname',
              style: TextStyle(
                fontWeight: _selectedCountry == 'gname'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'register_data',
            child: Text(
              'register_data',
              style: TextStyle(
                fontWeight: _selectedCountry == 'register_data'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'uid',
            child: Text(
              'uid',
              style: TextStyle(
                fontWeight: _selectedCountry == 'uid'
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
          _fetchTabalDataGroupMeter().then((table) {
            setState(() {
              _tableData = table;
              _originalData = table;
              _tableData = _originalData
                  .where((table) => table.any((element) => element
                      .toString()
                      .toLowerCase()
                      .startsWith(_searchValue.toLowerCase())))
                  .toList();
            });
          });
        });
      },
    );
  }

  String? _selectedASC = 'asc';

  PopupMenuButton<String> orderBy2() {
    return PopupMenuButton<String>(
      initialValue: _selectedASC,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Text(
              _selectedASC != null ? _selectedASC! : 'Select an order',
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
                fontWeight:
                    _selectedASC == 'asc' ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          PopupMenuItem(
            value: 'desc',
            child: Text(
              'desc',
              style: TextStyle(
                fontWeight: _selectedASC == 'desc'
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ];
      },
      onSelected: (value) {
        setState(() {
          _selectedASC = value;

          _fetchTabalDataGroupMeter().then((table) {
            setState(() {
              _tableData = table;
              _originalData = table;
              _tableData = _originalData
                  .where((table) => table.any((element) => element
                      .toString()
                      .toLowerCase()
                      .startsWith(_searchValue.toLowerCase())))
                  .toList();
            });
          });
        });
      },
    );
  }
}
