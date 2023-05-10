import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryGraph extends StatefulWidget {
  const HistoryGraph({super.key});

  @override
  State<HistoryGraph> createState() => _HistoryGraphState();
}

class _HistoryGraphState extends State<HistoryGraph> {
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
    );
  }
}