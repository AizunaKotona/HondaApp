import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Map<String, dynamic>> _tableData = [
    {
      'Id': '1',
      'profileName': '	Default',
      'registerDate': '2022-04-20',
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
              //   children: [homePage(context), Text('/'), profile(context)],
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                  // addNew(),
                  SizedBox(height: 16),
                  Text('Search:'),
                  SizedBox(height: 55, child: search()),
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
                              label: SizedBox(
                                width: 40, // modify the width here
                                child: Text('ID	'),
                              ),
                            ),
                            DataColumn(label: Text('Profile Name	')),
                            DataColumn(label: Text('Reg date')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: _tableData.map((data) {
                            return DataRow(cells: [
                              DataCell(Text(data['Id'],
                                  style: TextStyle(fontSize: 12))),
                              DataCell(SizedBox(
                                width: 75,
                                child: Text(data['profileName'],
                                    style: TextStyle(fontSize: 12)),
                              )),
                              DataCell(SizedBox(
                                width: 65,
                                child: Text(data['registerDate'],
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

InkWell profile(BuildContext context) {
  return InkWell(
    child: Text('Profile'),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/profile');
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
    items: ['Profile Name']
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
