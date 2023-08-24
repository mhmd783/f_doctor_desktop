import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../server/server.dart';
import 'package:hive/hive.dart';
import 'package:doctor/model/dbhive.dart';

class mange extends GetxController {
  late Box mypatient = Hive.box<patient>("patient");
  TextEditingController messageController = TextEditingController();
  Server? server;
  List<String> serverLogs = [];
  bool check = false;

  @override
  void onInit() {
    server = Server(onData, onError);
    //startOrStopServer();

    super.onInit();
  }

  Future<void> startOrStopServer() async {
    if (server!.running) {
      server!.close();
      serverLogs.clear();
      
    } else {
      
        await server!.start();
        
      
    }
    update();
  }

  void onData(Uint8List data) {
    final receviedData = String.fromCharCodes(data);
    serverLogs.add(receviedData);
    if (serverLogs[0] == 's') {
      serverLogs.clear();
    }

    update();
  }

  void onError(dynamic error) {
    debugPrint("Error $error");
  }

  // void handleMessage() {
  //   debugPrint(messageController.text);
  //   server!.broadcast('${messageController.text}');
  //   //serverLogs.add(messageController.text);
  //   update();
  // }

  //add to data recive to hive
  addpatient() {
    for (int i = 0; i < serverLogs.length; i += 1) {
      Map data = jsonDecode(serverLogs[i]);
      mypatient.add(patient(
          name: data['name'],
          phone: data['phone'],
          age: data['age'],
          date: data['date'],
          idpatient: data['idpatient']));
    }
    serverLogs = [];

    update();
  }

 
}








