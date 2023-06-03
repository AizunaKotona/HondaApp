import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testest/Energy_Report/energyUsageDaily.dart';
import 'package:testest/Energy_Report/energyUsageMonthly.dart';
import 'package:testest/Energy_Report/energyUsageYearly.dart';
import 'package:testest/Energy_Report/historyGraph.dart';
import 'package:testest/Metering_Management/Meter.dart';
import 'package:testest/Metering_Management/groupMeter.dart';
import 'package:testest/Metering_Management/profile.dart';
import 'dart:convert' show utf8;

import 'package:testest/Power%20Status/hompage.dart';
import 'package:testest/login/editProfile.dart';
import 'package:testest/login/login.dart';
import 'package:testest/login/userProfile.dart';
import 'package:testest/test.dart';

import 'package:testest/login/changePassword.dart';

void main() {
  utf8.decoder;
  utf8.encoder;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildMaterialApp();
  }

  MaterialApp buildMaterialApp() {
    return MaterialApp(
      
      initialRoute: '/',
      routes: {
        // '/': (context) => ChartPage(),
        // '/': (context) => MyTest(),
        '/': (context) => Login(), //Login
        '/home': (context) => MyHomePage(), //MyHomePage(),
        //User Profile
        '/userProfile': (context) => UserProfile(), //UserProfile
        '/changePassword': (context) => ChangePassword(), //ChangePassword
        '/editProfile' :(context) => EditProfile(),
        //User Profile
        //Metering_Management
        '/groupMeter': (context) => GroupMeter(), //GroupMeter(),
        '/profile': (context) => Profile(), //Profile
        '/meter': (context) => Meter(), //Profile
        //Metering Management
        //Energy Report
        '/energyUsageDaily': (context) => EnergyUsageDaily(), //EnergyUsageDaily
        '/energyUsageMonthly': (context) =>
            EnergyUsageMonthly(), //EnergyUsageMonthly
        '/energyUsageYearly': (context) =>
            EnergyUsageYearly(), //EnergyUsageYearly
        '/historyGraph': (context) => HistoryGraph(), //HistoryGraph
        // '/homePage': (context) => HomePage(),
        //Reports
      },
    );
  }
}

