import 'package:doctor/provid/prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class repeatscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _repeatscreen();
  }
}

class _repeatscreen extends State<repeatscreen> {
  int num = 20;
  List  id =[];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpatientrepeat();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpaymettoday();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "home",
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      backgroundColor: Color(0xf3f3f3f3f3),
      body: Row(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              child: Consumer<changedata>(builder: (context, val, child) {
                return GridView.builder(
                    // controller: ScrollController(
                    //     initialScrollOffset: val.mypatient.length / 4 * 200),
                    // reverse: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemCount: val.listpatientrepeat.length,
                    itemBuilder: (context, i) {
                      val.displaypatient(i);
                      //id.add(int.parse(val.listpatientrepeat[i].idpatient));
                      
                      return Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(30),
                        height: 250,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                          builder: (context, val, child) {
                            return MaterialButton(
                              //button person
                              
                              onPressed: () {
                               // val.getidpatient(id[i]);
                                val.getidpatient(int.parse(
                                    val.listpatientrepeat[i].idpatient));
                                Navigator.of(context).pushNamed('datapatient');
                              },
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Color.fromARGB(
                                              255, 246, 236, 150),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '${val.listpatientrepeat[i].name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${val.listpatientrepeat[i].idpatient}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              }),
            ),
          ),
          ///////////////////////////////////////
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(30),
              //margin: EdgeInsets.all(30),
              height: double.infinity,
              //width: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      //topLeft: Radius.circular(100),
                      //bottomLeft: Radius.circular(100)
                      )),
              child: Column(
                children: [
                  Consumer<changedata>(builder: (context, val, child) {
                    return TextFormField(
                      inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                      controller: val.search,
                      decoration: InputDecoration(
                        label: Text('Id Patient'),
                        prefixIcon: IconButton(
                            ///////////icon search
                            onPressed: () {
                              val.getsearch();
                              if (val.find == 1) {
                                int i = int.parse(
                                    val.listpatientsearch[0].idpatient);
                                val.getidpatient(i);

                                Navigator.of(context).pushNamed('datapatient');
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Not Fount Patient'),
                                    duration: Duration(seconds: 2),
                                    action: SnackBarAction(
                                      label: 'Doctor',
                                      onPressed: () {
                                        
                                      },
                                    ),
                                  ),
                                );

                              }
                            },
                            icon: Icon(
                              Icons.person_search,
                              color: Colors.black,
                            )),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 30,
                  ),
                  // Card(
                  //   color: Colors.white,
                  //   elevation: 10,
                  //   child: ListTile(
                  //     leading: Icon(Icons.home),
                  //     title: Text('Home',maxLines: 1,overflow: TextOverflow.ellipsis,),
                  //   ),
                  // ),
                  Consumer<changedata>(builder: ((context, val, child) {
                    return Card(
                      color:
                          val.screen == 1 ? Colors.grey.shade300 : Colors.white,
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          val.patienttodayscreen();
                          Navigator.of(context).pushReplacementNamed('patienttoday');
                        },
                        leading: Icon(Icons.co_present),
                        title: Text(
                          'Patients Today',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })),
                  Consumer<changedata>(builder: ((context, val, child) {
                    return Card(
                      color:
                          val.screen == 2 ? Colors.grey.shade300 : Colors.white,
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          val.repeatscreen();
                          Navigator.of(context).pushReplacementNamed('repeatscreen');
                        },
                        leading: Icon(Icons.flip_camera_android),
                        title: Text(
                          'Re-examination today',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })),
                  Consumer<changedata>(builder: ((context, val, child) {
                    return Card(
                      color:
                          val.screen == 3 ? Colors.grey.shade300 : Colors.white,
                      elevation: 10,
                      child: ListTile(
                        onTap: () {
                          val.surgeryscreen();
                          Navigator.of(context).pushReplacementNamed('surgeryscreen');
                        },
                        leading: Icon(Icons.airline_seat_flat_angled),
                        title: Text(
                          'Surgeries Today',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  })),
                  Consumer<changedata>(
                    builder: ((context, val, child) {
                      return Card(
                        color: val.screen == 4
                            ? Colors.grey.shade300
                            : Colors.white,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.patientsscreen();
                            Navigator.of(context).pushReplacementNamed('home');
                          },
                          leading: Icon(Icons.people),
                          title: Text(
                            'Patients',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                  ),
                  Consumer<changedata>(
                    builder: ((context, val, child) {
                      return Card(
                        color: val.screen == 5
                            ? Colors.grey.shade300
                            : Colors.white,
                        elevation: 10,
                        child: ListTile(
                          onTap: () {
                            val.paymentscreen();
                            Navigator.of(context)
                                .pushReplacementNamed('paymentpage');
                          },
                          leading: Icon(Icons.money),
                          trailing: Text("${val.monytoday}"),
                          title: Text(
                            'Paymenttoday',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
      /////////////////////////////////////////////////
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   elevation: 20,
      //   onPressed: () {
      //     _addpationt();
      //   },
      //   child: Icon(
      //     Icons.person_add,
      //     color: Colors.black,
      //   ),
      // ),
    );
  }

  ///////////////////////////////////////////////////////////////////add pationt
  Future<void> _addpationt() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Patient'),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.namef,
                    decoration: InputDecoration(
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.attribution)),
                  ),
                  TextFormField(
                    controller: val.phonef,
                    //initialValue: '01',
                    decoration: InputDecoration(
                        label: Text('Phone'), prefixIcon: Icon(Icons.phone)),
                  ),
                  TextFormField(
                    controller: val.agef,
                    decoration: InputDecoration(
                        label: Text('age'), prefixIcon: Icon(Icons.av_timer)),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Consumer<changedata>(
                  builder: (context, value, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (val.namef.text != '') {
                          val.addpatient();
                          
                          //val.getidpatient();
                          Navigator.of(context)
                              .pushReplacementNamed('datapatient');
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
