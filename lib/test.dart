// endDrawer: Drawer(
      //   child: Builder(
      //     builder: (context) => Container(
      //       child: ListView.separated(
      //         padding: EdgeInsets.only(top: 40.0),
      //         separatorBuilder: (context, index) => Divider(),
      //         itemCount: 7,
      //         itemBuilder: (context, index) {
      //           if (index == 0) {
      //             return ExpansionTile(
      //               leading: Icon(Icons.person_2),
      //               title: Text('User Name'),
      //               children: [
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('User Profile'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/UserProfile');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Change Password'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(context, '/ChangePassword');
      //                   },
      //                 ),
      //               ],
      //             );
      //           }

      //           if (index == 1) {
      //             return ListTile(
      //               leading: FaIcon(FontAwesomeIcons.gauge),
      //               title: Text('Power Status'),
      //               onTap: () {
      //                 Navigator.pushReplacementNamed(context, '/home');
      //               },
      //             );
      //           } else if (index == 2) {
      //             return ExpansionTile(
      //               leading: FaIcon(FontAwesomeIcons.wrench),
      //               title: Text('Metering Management'),
      //               children: [
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Group Meter'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/groupMeter');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Profile'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(context, '/profile');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Meter'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(context, '/meter');
      //                   },
      //                 ),
      //               ],
      //             );
      //           } else if (index == 3) {
      //             return ExpansionTile(
      //               leading: Icon(Icons.bar_chart_sharp),
      //               title: Text('Energy Report'),
      //               children: [
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Energy Usage Daily'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/energyUsageDaily');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Energy Usage Monthly'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/energyUsageMonthly');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('Energy Usage yearly'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/energyUsageYearly');
      //                   },
      //                 ),
      //                 ListTile(
      //                   leading: Text('   '),
      //                   title: Text('History Graph'),
      //                   onTap: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, '/historyGraph');
      //                   },
      //                 ),
      //               ],
      //             );
      //           } else if (index == 4) {
      //             return ListTile(
      //               leading: Icon(Icons.logout_sharp),
      //               title: Text('Logout'),
      //               onTap: () {
      //                 Navigator.pushReplacementNamed(context, '/');
      //               },
      //             );
      //           }
      //           return SizedBox.shrink();
      //         },
      //       ),
      //     ),
      //   ),
      // ),