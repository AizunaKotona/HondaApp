import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Meter extends StatefulWidget {
  const Meter({super.key});

  @override
  State<Meter> createState() => _MeterState();
}

class _MeterState extends State<Meter> {
  List<Map<String, dynamic>> _tableData = [
    {
      'meterID': '1',
      'meterName': 'FUTURE',
      'description': 'FUTURE',
      'location': 'SubStation Prachinburi',
      'department': 'Department1',
      'area': 'Area01',
      'status': 'เปิดใช้งาน	',
      'branchName': 'Rojana2',
      'onlineStatus': 'Online',
      'lastedUpdate': '2018-03-16 10:03:53.456268	',
      'action': 'Edit',
    },
    // add more rows here
  ];
  @override
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
              //   children: [homePage(context), Text('/'), meter(context)],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Meter',
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Node:'),Text('                                          Department:')
                    ],
                  ),
                  SizedBox(
                    
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 165,
                          child: node(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 55,
                          width: 165,
                          child: department(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
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
                          columns: [
                            DataColumn(
                              label: Text('Meter ID	'),
                            ),
                            DataColumn(label: Text('Meter Name')),
                            DataColumn(label: Text('description')),
                            DataColumn(label: Text('Location')),
                            DataColumn(label: Text('Department')),
                            DataColumn(label: Text('Area')),
                            DataColumn(label: Text('status')),
                            DataColumn(label: Text('Branch name')),
                            DataColumn(label: Text('Online Status')),
                            DataColumn(label: Text('Lasted Update')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: _tableData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['meterID'],
                                  style: TextStyle(fontSize: 12))),
                              DataCell(SizedBox(
                                width: 75,
                                child: Text(data['description'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 75,
                                child: Text(data['meterName'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 150,
                                child: Text(data['location'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 70,
                                child: Text(data['department'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(data['area'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(data['status'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(data['branchName'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(data['onlineStatus'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 170,
                                child: Text(data['lastedUpdate'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {},
                                  child: SizedBox(
                                    child: Text(data['action'],
                                        style: TextStyle(fontSize: 12)),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    minimumSize: Size(60, 30),
                                  ),
                                ),
                              ),
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

InkWell meter(BuildContext context) {
  return InkWell(
    child: Text('Meter'),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/meter');
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
DropdownButtonFormField node() {
  String? _selectedCountry;
  return DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: ['hard']
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

DropdownButtonFormField department() {
  String? _selectedCountry;
  return DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: ['D01', 'D02']
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