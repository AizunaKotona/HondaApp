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
  List< dynamic> _tableData = [];
  @override
  void initState(){
        super.initState();
        fetchTabalData().then((table) {
      setState(() {
        _tableData = table;
      });
    });
     
  }
  Future<List<dynamic>> fetchTabalData() async {
    final url = Uri.parse('http://192.168.1.136:8080/api/group/getallgroup');
    final response = await http
        .get(url, headers: {'Accept': 'application/json; charset=UTF-8'});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      return jsonData;
    } else {
      throw Exception('Failed to load data');
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
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
      body: Center(
        child: Container(
          child: ListView(
            padding: EdgeInsets.all(15.0),
            children: <Widget>[
              // Row(
              //   children: [homePage(context), Text('/'), groupMeter(context)],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Group Meter',
                    style: TextStyle(fontSize: 30),
                  ),
                  // addNew(),
                  SizedBox(height: 16),
                  Text('Search:'),
                  SizedBox(width: 265,height: 55, child: search()),
                  SizedBox(height: 16),
                  Text('Order by:'),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 150,
                          child: orderBy(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 55,
                          width: 100,
                          child: orderBy2(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        go(),
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
                        child: DataTable(
                          dividerThickness: 1,

                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: 100, // modify the width here
                                child: Text('Virtual Meter ID'),
                              ),
                            ),
                            DataColumn(label: Text('Virtual Meter Name')),
                            DataColumn(label: Text('Department')),
                            DataColumn(label: Text('Area')),
                            DataColumn(label: Text('Register date')),
                           ],
                          rows: _tableData.map((table) {
                            return DataRow(cells: [
                              DataCell(Text(table[0].toString(),
                                  style: TextStyle(fontSize: 12))),
                              DataCell(SizedBox(
                                width: 75,
                                child: Text(table[1].toString(),
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 75,
                                child: Text(table[2].toString(),
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(table[3].toString(),
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(table[4].toString(),
                                    style: TextStyle(fontSize: 12)),
                              )),
                              
                            ]);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InkWell homePage(BuildContext context) {
  return InkWell(
    child: Text('Home'),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/');
    },
  );
}

InkWell groupMeter(BuildContext context) {
  return InkWell(
    child: Text('Group Meter'),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/groupMeter');
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

DropdownButtonFormField orderBy() {
  String? _selectedCountry;
  return DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: ['gid', 'gname', 'register_data', 'uid']
        .map((country) => DropdownMenuItem(
              value: country,
              child: Text(country),
            ))
        .toList(),
    onChanged: (value) {
      _selectedCountry = value;
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

DropdownButtonFormField orderBy2() {
  String? _selectedCountry;
  return DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: ['ASC', 'Desc']
        .map((country) => DropdownMenuItem(
              value: country,
              child: Text(country),
            ))
        .toList(),
    onChanged: (value) {
      _selectedCountry = value;
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

ElevatedButton go() {
  return ElevatedButton(child: Text('Go'), onPressed: () {});
}
