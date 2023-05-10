import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
class EnergyUsageYearly extends StatefulWidget {
  const EnergyUsageYearly({super.key});

  @override
  State<EnergyUsageYearly> createState() => _EnergyUsageYearlyState();
}

class _EnergyUsageYearlyState extends State<EnergyUsageYearly> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
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
              Row(
                children: [
                  // homePage(context),
                  Text('Energy Usage Yearly',style: TextStyle(fontSize: 32)),
                  // energyUsageYearly(context)
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
                      Text('Profile:'),
                      Text('                    Group'),
                      Text('                        Meter ')
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 100,
                          child: profile (),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 55,
                          width: 100,
                          child: group(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        SizedBox(
                          height: 55,
                          width: 100,
                          child: meter(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Year:'),
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 55,
                          width: 215,
                          // child: dateField(context),
                          child:yearly(),

                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      ok(),reset(),
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

InkWell energyUsageYearly(BuildContext context) {
  return InkWell(
    child: Text('Energy Usage Yearly'),
    onTap: () {
      Navigator.pushReplacementNamed(context, '/energyUsageYearly');
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

// DropdownButtonFormField orderBy() {
//   String? _selectedCountry;
//   return DropdownButtonFormField<String>(
//     value: _selectedCountry,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(),
//     ),
//     items: ['gid', 'gname', 'register_data', 'uid']
//         .map((country) => DropdownMenuItem(
//               value: country,
//               child: Text(country),
//             ))
//         .toList(),
//     onChanged: (value) {
//       _selectedCountry = value;
//     },
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please select a country';
//       }
//       return null;
//     },
//     onSaved: (value) {
//       // save the selected value
//     },
//   );
// }

// DropdownButtonFormField orderBy2() {
//   String? _selectedCountry;
//   return DropdownButtonFormField<String>(
//     value: _selectedCountry,
//     decoration: InputDecoration(
//       border: OutlineInputBorder(),
//     ),
//     items: ['ASC', 'Desc']
//         .map((country) => DropdownMenuItem(
//               value: country,
//               child: Text(country),
//             ))
//         .toList(),
//     onChanged: (value) {
//       _selectedCountry = value;
//     },
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please select a country';
//       }
//       return null;
//     },
//     onSaved: (value) {
//       // save the selected value
//     },
//   );
// }

ElevatedButton go() {
  return ElevatedButton(child: Text('Go'), onPressed: () {});
}

DropdownButtonFormField profile() {
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

DropdownButtonFormField group() {
  String? _selectedCountry;
  return DropdownButtonFormField<String>(
    value: _selectedCountry,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    items: ['dd', 'konw']
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

DropdownButtonFormField meter() {
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
TextEditingController _dateController = TextEditingController();

GestureDetector datePickerButton(BuildContext context) {
  return GestureDetector(
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
      _dateController.text = DateFormat('d/M/yyyy').format(picked);
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
        onPressed: () async {});
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
DropdownButtonFormField yearly() {
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