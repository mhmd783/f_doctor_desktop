import 'package:doctor/model/dbhive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jiffy/jiffy.dart';

import 'package:flutter/foundation.dart';
////////////\
import 'dart:convert';

import '../server/server.dart';

class changedata extends ChangeNotifier {
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
  late var lpatient;
  List listonepatiebt = [];
  List listproblem = [];
  List listrepeat = [];
  List listsurgery = [];
  List listdruges = [];
  List listdrugestoday = [];
  List listpaymenttoday = [];

  List listcheck = [];
  List listpatientcheck = [];
  List listpatientrepeat = [];
  List listpatientsurgery = [];
  List listpatientstoday = [];
  List listpatientsearch = [];
  List listid = [];
  List listhistory = [];
  List listpayment = [];
  List listchosedruges = [];
  List listpatientdiseace = [];
  List listdiseacechose = [];
  List listnote = [];
  int idpatient = 0;
  late List listdaterepeat;
  late Map datasend = {};

  TextEditingController namef = new TextEditingController();
  TextEditingController phonef = new TextEditingController();
  TextEditingController agef = new TextEditingController();
  TextEditingController problem = new TextEditingController();
  TextEditingController druge = new TextEditingController();
  TextEditingController num = new TextEditingController();
  TextEditingController search = new TextEditingController();
  TextEditingController disease = new TextEditingController();
  TextEditingController note = new TextEditingController();
  String datef = Jiffy.now().yMd;
  late String daterepeat;
  late String datesurgery;

  int screen = 1;
  late int find;
  bool update = false;
  int show = 0;
  int monytoday = 0;

  patienttodayscreen() {
    screen = 1;
    notifyListeners();
  }

  repeatscreen() {
    screen = 2;
    notifyListeners();
  }

  surgeryscreen() {
    screen = 3;
    notifyListeners();
  }

  patientsscreen() {
    screen = 4;
    notifyListeners();
  }

  paymentscreen() {
    screen = 5;
    notifyListeners();
  }

  changeshow() {
    show = 1;
    notifyListeners();
  }

  changehide() {
    show = 0;
    notifyListeners();
  }

  addpatient() {
    mypatient.add(patient(
        name: namef.text,
        phone: phonef.text,
        age: agef.text,
        date: datef,
        idpatient: mypatient.length.toString()));

    namef.text = '';
    phonef.text = '';
    agef.text = '';

    for (int i = 0; i < mypatient.length; i++) {
      displaypatient(i);
    }
    getidpatient(mypatient.length - 1);
    notifyListeners();
  }

  displaypatient(int id) {
    lpatient = mypatient.getAt(id);
  }

  getidpatient(int idp) {
    if (idp < mypatient.length) {
      idpatient = idp;
      //print('from creet $idpatient');
      notifyListeners();
    }
  }

  getonepatient() {
    listonepatiebt = [];
    //List listcheck = [];

    listonepatiebt.add(mypatient.getAt(idpatient));
    print(listonepatiebt[0].name);

    notifyListeners();
  }

  addproblems() {
    myproblems.put("${idpatient}",
        problems(idpatient: idpatient.toString(), problem: problem.text));
    problem.text = '';
    //print('good');
    getproblems();
    notifyListeners();
  }

  getproblems() {
    listproblem = [];
    final patientProblem = myproblems.get("$idpatient");
    if (patientProblem != null) {
      listproblem.add(patientProblem);
      print('${listproblem[0].problem}');
    } else {
      print('null');
    }
    notifyListeners();
  }

  // adddaterepeat() {
  //   myrepeat.put("${idpatient}",
  //       repeat(idpatient: idpatient.toString(), date: daterepeat));

  //   //print('good date repeat');
  //   getdaterepeat();
  //   notifyListeners();
  // }

  getdaterepeat() {
    listrepeat = [];
    final patientProblem = myrepeat.get("$idpatient");
    if (patientProblem != null) {
      listrepeat.add(patientProblem);
      print('${listrepeat[0].date}');
    } else {
      print('null');
    }
    notifyListeners();
  }

  adddatesurgery() {
    mysurery.put("${idpatient}",
        surgery(idpatient: idpatient.toString(), date: datesurgery));
    getdatesergery();
    notifyListeners();
  }

  getdatesergery() {
    listsurgery = [];
    final patientsurgery = mysurery.get("$idpatient");
    if (patientsurgery != null) {
      listsurgery.add(patientsurgery);
      //print('date surgery: ${listsurgery[0].date}');
    } else {
      print('null');
    }
    notifyListeners();
  }

  adddruge() {
    mydruges.add(druges(
        idpatient: idpatient.toString(),
        druge: druge.text,
        num: num.text,
        date: datef));
    mydrugeschose.add(drugeschose(
        idpatient: idpatient.toString(),
        druge: druge.text,
        num: num.text,
        date: datef));

    druge.text = '';
    num.text = '';
    //print('good storage');

    getdruge();
    chosedruges();
    notifyListeners();
  }

  getdruge() {
    listcheck = [];
    listdruges = [];
    for (int i = 0; i < mydruges.length; i++) {
      final check = mydruges.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].idpatient == idpatient.toString()) {
        listdruges.add(listcheck[i]);
        // print('good surgery');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  get_druge_to_day_to_print() {
    listcheck = [];
    listdrugestoday = [];
    for (int i = 0; i < mydruges.length; i++) {
      final check = mydruges.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].idpatient == idpatient.toString() &&
          listcheck[i].date == datef) {
        listdrugestoday.add(listcheck[i]);
        // print('good surgery');
      }
    }

    notifyListeners();
  }

  getpatientrepeat() {
    listcheck = [];
    listpatientcheck = [];

    listpatientrepeat = [];

    for (int i = 0; i < myrepeat.length; i++) {
      final check = myrepeat.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listpatientcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientrepeat
            .add(listpatientcheck[int.parse(listcheck[i].idpatient)]);
        //listpatientrepeat=mypatient.getAt(int.parse(listcheck[i].idpatient));
        // print('good listpatient to day ${listpatientrepeat[0].name}');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getpatientsurgery() {
    listcheck = [];
    listpatientcheck = [];

    listpatientsurgery = [];

    for (int i = 0; i < mysurery.length; i++) {
      final check = mysurery.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listpatientcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientsurgery
            .add(listpatientcheck[int.parse(listcheck[i].idpatient)]);
        // print('good listpatient surgery to day ${listpatientsurgery[0].name}');
      }
    }
    // for (int i = 0; i < listdruges.length; i++) {
    //   print(listdruges[i].druge);
    // }

    notifyListeners();
  }

  getpatientstoday() {
    listcheck = [];
    listpatientstoday = [];
    for (int i = 0; i < mypatient.length; i++) {
      final check = mypatient.getAt(i);

      if (check != null) {
        listcheck.add(check);
      }
    }

    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpatientstoday.add(listcheck[i]);

        //listid.add(int.parse(listpatientstoday[i].idpatient));
        //print('good patient today ${listpatientstoday[0].name}');
      }
    }
    for (int i = 0; i < listpatientstoday.length; i++) {
      //print(listpatientstoday[i].idpatient);
    }
    notifyListeners();
  }

  getsearch() {
    listpatientsearch = [];
    int i = mypatient.length;
    if (!search.text.isEmpty) {
      try {
        i = int.parse(search.text);
      } catch (e) {
        print("error");
      }
    }

    if (i < mypatient.length && !search.text.isEmpty) {
      find = 1;
      listpatientsearch.add(mypatient.getAt(i));

      print(listpatientsearch[0].name);
    } else {
      find = 0;
    }

    search.text = '';

    notifyListeners();
  }

  //mange server ///////////////////////////////////////////////////////

  //late Box mypatient = Hive.box<patient>("patient");
  TextEditingController messageController = TextEditingController();
  late Server server = Server(onData, onError);
  List<String> serverLogs = [];
  bool check = false;

  // @override
  void start() {
    server = Server(onData, onError);
    startOrStopServer();

    // super.onInit();
  }

  Future<void> startOrStopServer() async {
    if (server.running) {
      server.close();
      serverLogs.clear();
    } else {
      await server.start();
    }
    notifyListeners();
  }

  void onData(Uint8List data) async {
    serverLogs.clear();
    final receviedData = await String.fromCharCodes(data);
    serverLogs.add(receviedData);
    if (serverLogs[0] == 's') {
      serverLogs.clear();
    }
    await addpatientrecive();
    //update = true;

    notifyListeners();
  }

  void onError(dynamic error) {
    debugPrint("Error $error");
  }

  ///send date repeat and surgery

  // void handleMessage() {
  //   listdaterepeat = [];
  //   listcheck = [];
  //   datasend = {};
  //   for (int i = 0; i < myrepeat.length; i++) {
  //     listdaterepeat.add(myrepeat.getAt(i));
  //     datasend = {};
  //     datasend = {
  //       'type': 'repeat',
  //       'date': listdaterepeat[i].date,
  //       'idpatient': listdaterepeat[i].idpatient,
  //     };
  //     final encodedString = base64.encode(utf8.encode(jsonEncode(datasend)));
  //     server.broadcast(encodedString);
  //   }

  //   notifyListeners();
  // }

  //add to data recive to hive patient and payment
  addpatientrecive() async {
    for (int i = 0; i < serverLogs.length; i += 1) {
      final decodedBytes = await base64.decode(serverLogs[i]);
      final decodedString = await utf8.decode(decodedBytes);
      Map data = await jsonDecode(decodedString);

      if (data['type'] == "patient") {
        mypatient.add(patient(
            name: data['name'],
            phone: data['phone'],
            age: data['age'],
            date: data['date'],
            idpatient: data['idpatient']));
        serverLogs.clear();
        getpatientstoday();
      }
      if (data['type'] == "payment") {
        mypayment.add(salarys(
          idpatient: data['idpatient'],
          salary: data['salary'],
          why: data['why'],
          date: data['date'],
        ));
        getpaymettoday();
        getpaymet();
        serverLogs.clear();
      }
    }
    serverLogs = [];

    notifyListeners();
  }
  /////////////////////////////////////////////////endserver

  updatef() {
    update = false;
    notifyListeners();
  }

  //new//////////////////////////////////////////////////////////////////////
  //history//////////////////////////////////////
  addhistory() {
    if (!listproblem.isEmpty) {
      myhistory.add(history(
          idpatient: idpatient.toString(),
          problem: listproblem[0].problem,
          date: datef));

      print("add history ");
    } else {
      myhistory.add(
          history(idpatient: idpatient.toString(), problem: '', date: datef));

      print("add history ");
    }
    notifyListeners();
  }

  gethistory() {
    listhistory = [];
    List listcheck = [];
    for (int i = 0; i < myhistory.length; i++) {
      listcheck.add(myhistory.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpatient) == idpatient) {
        listhistory.add(myhistory.getAt(i));
        print("id ${listhistory[0].problem}");
      }
    }
    //print("id ${listcheck[0].problem}");

    notifyListeners();
  }

  adddaterepeat() {
    myrepeat.put("${idpatient}",
        repeat(idpatient: idpatient.toString(), date: daterepeat));

    //print('good date repeat');
    getdaterepeat();
    notifyListeners();
  }

  getpaymet() {
    listpayment = [];
    List listcheck = [];
    for (int i = 0; i < mypayment.length; i++) {
      listcheck.add(mypayment.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpatient) == idpatient) {
        listpayment.add(mypayment.getAt(i));
        print("id ${listpayment[0].why}");
      }
    }

    notifyListeners();
  }

  getpaymettoday() {
    monytoday = 0;
    listpaymenttoday = [];
    List listcheck = [];
    for (int i = 0; i < mypayment.length; i++) {
      listcheck.add(mypayment.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (listcheck[i].date == datef) {
        listpaymenttoday.add(mypayment.getAt(i));

        //print("id ${listpaymenttoday[0].why}");
      }
    }
    for (int i = 0; i < listpaymenttoday.length; i++) {
      monytoday = monytoday + int.parse(listpaymenttoday[i].salary);
    }

    notifyListeners();
  }

  chosedruges() {
    listchosedruges = [];
    for (int i = 0; i < mydrugeschose.length; i++) {
      listchosedruges.add(mydrugeschose.getAt(i));
    }
    notifyListeners();
  }

  adddrugechose(int i) {
    mydruges.add(druges(
        idpatient: idpatient.toString(),
        druge: mydrugeschose.getAt(i).druge,
        num: num.text,
        date: datef));

    druge.text = '';
    num.text = '';
    //print('good storage');

    getdruge();
    //chosedruges();
    notifyListeners();
  }

  adddiseace() {
    mydiseasechose.add(diseasechose(disease: disease.text));
    mypatientdisease.add(patientdisease(
        idpatient: idpatient.toString(),
        namedisease: disease.text,
        date: datef));
    print('${disease.text}');
    disease.text = '';
    notifyListeners();
  }

  adddiseacechoseonclick(int i) {
    mypatientdisease.add(patientdisease(
        idpatient: idpatient.toString(),
        namedisease: mydiseasechose.getAt(i).disease,
        date: datef));
    print('${mydiseasechose.getAt(i)}');
    disease.text = '';
    notifyListeners();
  }

  addnote() {
    mynotes.add(
        notes(idpatient: idpatient.toString(), note: note.text, date: datef));
    note.text = '';

    notifyListeners();
  }

  getpatientdiseace() {
    listpatientdiseace = [];
    List listcheck = [];
    for (int i = 0; i < mypatientdisease.length; i++) {
      listcheck.add(mypatientdisease.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpatient) == idpatient) {
        listpatientdiseace.add(mypatientdisease.getAt(i));
      }
    }
    notifyListeners();
  }

  getdiseacechose() {
    listdiseacechose = [];

    for (int i = 0; i < mydiseasechose.length; i++) {
      listdiseacechose.add(mydiseasechose.getAt(i));
    }

    notifyListeners();
  }

  getnotes() {
    listnote = [];
    List listcheck = [];
    for (int i = 0; i < mynotes.length; i++) {
      listcheck.add(mynotes.getAt(i));
    }
    for (int i = 0; i < listcheck.length; i++) {
      if (int.parse(listcheck[i].idpatient) == idpatient) {
        listnote.add(mynotes.getAt(i));
      }
    }
    notifyListeners();
  }
}
