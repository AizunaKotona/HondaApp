import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int currentIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30, left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          // Container(
              // padding: EdgeInsets.only(left: 10, top: 10),
              // child: Column(
                // children: [
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       backgroundColor: Colors.red[600],
                  //       radius: 50,
                  //       child: Icon(
                  //         Icons.person,
                  //         size: 80,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 15,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Text(
                  //               'Username: Data Data',
                  //               style: TextStyle(
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //         SizedBox(width: 30),
                  //         Row(
                  //           children: <Widget>[
                  //             Padding(padding: EdgeInsets.only(top: 30)),
                  //             Text(
                  //               'Phone: 1234567890',
                  //               style: TextStyle(
                  //                   fontSize: 20,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
              //   ],
              // )),
          Container(
            padding: EdgeInsets.only(left: 10, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text("Edit Profile"),
                  leading: Icon(Icons.person),
                  onTap: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                ),
                ListTile(
                  title: Text("Change Password"),
                  leading: Icon(Icons.key),
                  onTap: () {
                    Navigator.pushNamed(context, '/changePassword');
                  },
                ),
                ListTile(
                  title: Text("Logout"),
                  leading: Icon(Icons.logout_outlined),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/');
                  },
                ),
              ],
            ),
          )
        ],
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
}
