import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/dbhive.dart';

class delet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _delet();
  }
}

class _delet extends State<delet> {
  late Box mypatient = Hive.box<patient>("patient");
  late Box myproblems = Hive.box<problems>("problems");
  late Box myrepeat = Hive.box<repeat>("repeat");
  late Box mysurery = Hive.box<surgery>("surery");
  late Box mydruges = Hive.box<druges>("druges");
  late Box myhistory = Hive.box<history>("history");
  late Box mypayment = Hive.box<salarys>("newsalarysdoctor");
  late Box mydrugeschose = Hive.box<drugeschose>("drugeschose");

  late Box mydiseasechose = Hive.box<diseasechose>("diseasechose");
  late Box mypatientdisease = Hive.box<patientdisease>("patientdisease");
  late Box mynotes = Hive.box<notes>("notes");
  late Box idbox = Hive.box('id');
  late Box idpayment = Hive.box("idpayment");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: IconButton(
              onPressed: () {
                mypatient.deleteFromDisk();
                myproblems.deleteFromDisk();
                myrepeat.deleteFromDisk();
                mysurery.deleteFromDisk();
                mydruges.deleteFromDisk();
                myhistory.deleteFromDisk();
                mypayment.deleteFromDisk();
                mydrugeschose.deleteFromDisk();
                mydiseasechose.deleteFromDisk();
                mypatientdisease.deleteFromDisk();
                mynotes.deleteFromDisk();
                idbox.delete('id');
                idpayment.delete('id');
              },
              icon: Icon(Icons.delete))),
    );
  }
}
