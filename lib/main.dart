import 'dart:io';

import 'package:doctor/provid/prov.dart';
import 'package:doctor/veiw/datapatient.dart';
import 'package:doctor/veiw/delet.dart';
import 'package:doctor/veiw/history.dart';
import 'package:doctor/veiw/home.dart';
import 'package:doctor/veiw/patienttoday.dart';
import 'package:doctor/veiw/payment.dart';

import 'package:doctor/veiw/repeat.dart';
import 'package:doctor/veiw/surgery.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:path_provider/path_provider.dart';

import 'model/dbhive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  //adapter
  Hive.registerAdapter(patientAdapter());
  Hive.registerAdapter(problemsAdapter());
  Hive.registerAdapter(repeatAdapter());
  Hive.registerAdapter(surgeryAdapter());
  Hive.registerAdapter(drugesAdapter());
  Hive.registerAdapter(historyAdapter());
  Hive.registerAdapter(salarysAdapter());
  Hive.registerAdapter(drugeschoseAdapter());
  Hive.registerAdapter(diseasechoseAdapter());
  Hive.registerAdapter(patientdiseaseAdapter());
  Hive.registerAdapter(notesAdapter());
  //openboxes
  await Hive.openBox<patient>("patient");
  await Hive.openBox<problems>("problems");
  await Hive.openBox<repeat>("repeat");
  await Hive.openBox<surgery>("surery");
  await Hive.openBox<druges>("druges");
  await Hive.openBox<history>("history");
  await Hive.openBox<salarys>("newsalarysdoctor");
  await Hive.openBox<drugeschose>("drugeschose");
  await Hive.openBox<diseasechose>("diseasechose");
  await Hive.openBox<patientdisease>("patientdisease");
  await Hive.openBox<notes>("notes");

  await Hive.openBox("id");
  await Hive.openBox("idpayment");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return changedata();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (context) => home(),
          'datapatient': (context) => datapationt(),
          'patienttoday': (context) => patienttoday(),
          'repeatscreen': (context) => repeatscreen(),
          'surgeryscreen': (context) => surgeryscreen(),
          'history': (context) => historypage(),
          'paymentpage':(context) => paymentpage(),
          //'print':(context) => print(name: '', id: '', date: '', redate: '', sudate: '', druge: []),
        },
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: patienttoday(),
      ),
    );
  }
}
