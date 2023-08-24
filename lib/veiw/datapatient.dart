import 'package:doctor/provid/prov.dart';
import 'package:doctor/veiw/print.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiffy/jiffy.dart';

import 'package:provider/provider.dart';
//import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class datapationt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _datapationt();
  }
}

class _datapationt extends State<datapationt> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getonepatient();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getproblems();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdaterepeat();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdatesergery();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdruge();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false)
          .get_druge_to_day_to_print();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpaymet();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).chosedruges();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getdiseacechose();
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getpatientdiseace();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).getnotes();
    });
  }

  int num = 5;
  DateTime daterepeat = DateTime.now();
  void repeatdate() async {}

  DateTime datesurgery = DateTime.now();
  void surgerydate() async {}

  Future<void> _adddruge() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Druge'),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.druge,
                    decoration: InputDecoration(
                        label: Text('Name Druge'),
                        prefixIcon: Icon(Icons.bloodtype)),
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'\d')),
                    ],
                    controller: val.num,
                    decoration: InputDecoration(
                        label: Text('Number'), prefixIcon: Icon(Icons.numbers)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    //margin: EdgeInsets.all(10),
                    //color: Colors.grey,
                    height: 250,
                    width: 180,
                    child: ListView.builder(
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: val.listchosedruges.length,
                        itemBuilder: (context, i) {
                          return Card(
                              elevation: 10,
                              child: ListTile(
                                onTap: () {
                                  val.adddrugechose(i);
                                  val.get_druge_to_day_to_print();
                                  Navigator.of(context).pop();
                                },
                                title: Text("${val.listchosedruges[i].druge}"),
                              ));
                        }),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Consumer<changedata>(
                  builder: (context, val, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (val.druge.text != '') {
                          val.adddruge();
                          val.get_druge_to_day_to_print();
                          Navigator.of(context).pop();
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

  ///add diseace
  Future<void> _adddiseace() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add diseace'),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.disease,
                    decoration: InputDecoration(
                        label: Text('Name diseace'),
                        prefixIcon: Icon(Icons.bloodtype)),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 250,
                    width: 180,
                    child: ListView.builder(
                        itemCount: val.listdiseacechose.length,
                        itemBuilder: (context, i) {
                          return Card(
                              elevation: 10,
                              child: ListTile(
                                onTap: () {
                                  val.adddiseacechoseonclick(i);
                                  val.getpatientdiseace();
                                  Navigator.of(context).pop();
                                },
                                title:
                                    Text("${val.listdiseacechose[i].disease}"),
                              ));
                        }),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Consumer<changedata>(
                  builder: (context, val, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (val.disease.text != '') {
                          val.adddiseace();
                          val.getdiseacechose();
                          val.getpatientdiseace();

                          Navigator.of(context).pop();
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

  Future<void> _addnote() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Note'),
            elevation: 10,
            content: Form(
              child: TextFormField(
                controller: val.note,
                decoration: InputDecoration(
                    label: Text('Note'), prefixIcon: Icon(Icons.bloodtype)),
              ),
            ),
            actions: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Consumer<changedata>(
                  builder: (context, val, child) {
                    return IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (val.note.text != '') {
                          val.addnote();
                          val.getnotes();
                          Navigator.of(context).pop();
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

  Future<void> _adddproblempatient() async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Consumer<changedata>(builder: (context, val, child) {
          return AlertDialog(
            scrollable: true,
            title: const Text('Add Problme'),
            elevation: 10,
            content: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: val.problem,
                    decoration: InputDecoration(
                        label: Text('Problme'),
                        prefixIcon: Icon(Icons.explicit)),
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
                        if (val.problem.text != '') {
                          val.addproblems();
                          Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/body5.jpg'), fit: BoxFit.cover)),
        child: Row(
          children: [
///////////////////////////////////////////////////////////////////////roshta
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 30, top: 10, bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(50)),
                      child:
                          Consumer<changedata>(builder: (context, val, child) {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: val.listdruges.length + 1,
                            itemBuilder: (context, i) {
                              return i < val.listdruges.length
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      //height: 200,
                                      //width: 400,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${val.listdruges[i].druge}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontStyle:
                                                        FontStyle.italic),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'number: ${val.listdruges[i].num}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Date: ${val.listdruges[i].date}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(10),
                                      height: 200,
                                      width: 200,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Center(
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                                onPressed: () {
                                                  _adddruge();
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.black,
                                                ))),
                                      ));
                            });
                      }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, left: 30, right: 20),
                    height: 70,
                    child: Consumer<changedata>(builder: (context, val, child) {
                      return !val.listpayment.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: val.listpayment.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(30)),
                                  //color: ,
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${val.listpayment[i].why}: ${val.listpayment[i].salary}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          Icons.attach_money_outlined,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container();
                    }),
                  ),
                ],
              ),
            )),
/////////////////////////////////////////////////////////////////////data patient
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 30, top: 30, bottom: 30),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          height: 200,
                          width: 500,
                          margin: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 246, 236, 150),
                              borderRadius: BorderRadius.circular(30)),
                          child: Consumer<changedata>(
                              builder: (context, val, child) {
                            return val.listonepatiebt.isEmpty
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${val.listonepatiebt[0].name}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'num:${val.listonepatiebt[0].idpatient}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'Phone: ${val.listonepatiebt[0].phone}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'Age: ${val.listonepatiebt[0].age}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'Date: ${val.listonepatiebt[0].date}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  );
                          })),
                      ////////////////////////////////////////////////////////
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.only(bottom: 30, right: 30, left: 30),
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(255, 246, 236, 150),
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                            builder: (context, val, child) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Patient History Outside',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.all(10),
                                    width: 480,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount:
                                            val.listpatientdiseace.length,
                                        itemBuilder: (context, i) {
                                          return val.listpatientdiseace.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'not specify',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black38),
                                                  ),
                                                )
                                              : Text(
                                                  '${val.listpatientdiseace[i].namedisease}',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          _adddiseace();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          );
                        }),
                      ),
                      /////////////////////////////////////////////////////////////////////
                      Container(
                        padding: EdgeInsets.all(20),
                        margin:
                            EdgeInsets.only(bottom: 30, right: 30, left: 30),
                        height: 300,
                        width: 500,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(255, 246, 236, 150),
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                            builder: (context, val, child) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'whate patient have',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 480,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount: 1,
                                        itemBuilder: (context, i) {
                                          return val.listproblem.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'not specify',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black38),
                                                  ),
                                                )
                                              : Text(
                                                  '${val.listproblem[0].problem}',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          _adddproblempatient();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          );
                        }),
                      ),
                      ////////////////////////////////////////////////////////
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 30, right: 30, left: 30),
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(255, 246, 236, 150),
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                            builder: (context, val, child) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Re-examination',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, i) {
                                      return val.listrepeat.isEmpty
                                          ? Center(
                                              child: Text(
                                                'not specify',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black38),
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'Date: ${val.listrepeat[0].date}',
                                                style: TextStyle(fontSize: 30),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050),
                                          ).then((value) {
                                            if (value != null) {
                                              val.daterepeat = value.toString();
                                              val.daterepeat = Jiffy.parse(
                                                      '${val.daterepeat}')
                                                  .yMd;

                                              //print(val.daterepeat);
                                              val.adddaterepeat();
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.calendar_month,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          );
                        }),
                      ),
                      ////////////////////////////////////////////////////////
                      Container(
                        margin:
                            EdgeInsets.only(bottom: 30, right: 30, left: 30),
                        height: 150,
                        width: 500,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(255, 246, 236, 150),
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                            builder: (context, val, child) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Surgery',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 1,
                                    itemBuilder: (context, i) {
                                      return val.listsurgery.isEmpty
                                          ? Center(
                                              child: Text(
                                                'not specify',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black38),
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                'Date: ${val.listsurgery[0].date}',
                                                style: TextStyle(fontSize: 30),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            );
                                    }),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050),
                                          ).then((value) {
                                            if (value != null) {
                                              val.datesurgery =
                                                  value.toString();
                                              val.datesurgery = Jiffy.parse(
                                                      '${val.datesurgery}')
                                                  .yMd;

                                              //print(val.datesurgery);
                                              val.adddatesurgery();
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.calendar_month,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.only(bottom: 30, right: 30, left: 30),
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            //color: Color.fromARGB(255, 246, 236, 150),
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)),
                        child: Consumer<changedata>(
                            builder: (context, val, child) {
                          return Center(
                            child: Column(
                              children: [
                                Text(
                                  'Note',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Expanded(
                                  child: Container(
                                    width: 480,
                                    child: ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        // shrinkWrap: true,
                                        itemCount: val.listnote.length,
                                        itemBuilder: (context, i) {
                                          return val.listnote.isEmpty
                                              ? Center(
                                                  child: Text(
                                                    'not specify',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black38),
                                                  ),
                                                )
                                              : Text(
                                                  '${val.listnote[i].note}',
                                                  style:
                                                      TextStyle(fontSize: 30),
                                                  maxLines: 10,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                        }),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                        onPressed: () {
                                          _addnote();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        )))
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            )),

////////////////////////////////////////////////////////icons
            Consumer<changedata>(builder: (context, val, child) {
              return Container(
                width: 80,
                height: 350,
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              val.patienttodayscreen();
                              Navigator.of(context)
                                  .pushReplacementNamed('patienttoday');
                            },
                            icon: Icon(
                              Icons.co_present,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              val.repeatscreen();
                              Navigator.of(context)
                                  .pushReplacementNamed('repeatscreen');
                            },
                            icon: Icon(
                              Icons.flip_camera_android,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              val.surgeryscreen();
                              Navigator.of(context)
                                  .pushReplacementNamed('surgeryscreen');
                            },
                            icon: Icon(
                              Icons.airline_seat_flat_angled,
                              color: Colors.black,
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            val.patientsscreen();
                            Navigator.of(context).pushReplacementNamed('home');
                          },
                          icon: Icon(
                            Icons.people,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                          onPressed: () {
                            val.paymentscreen();
                            Navigator.of(context)
                                .pushReplacementNamed('paymentpage');
                          },
                          icon: Icon(
                            Icons.money,
                            color: Colors.black,
                          )),
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
      //////////////////////////////////////////////////////////////
      floatingActionButton:
          Consumer<changedata>(builder: (context, val, child) {
        return val.show == 0
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                elevation: 20,
                onPressed: () {
                  val.changeshow();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        val.changehide();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.history,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('history');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Consumer<changedata>(builder: (context, val, child) {
                      return IconButton(
                        icon: Icon(
                          Icons.print,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          String newdr = val.listrepeat.isEmpty
                              ? ''
                              : val.listrepeat[0].date;
                          String newds = val.listsurgery.isEmpty
                              ? ''
                              : val.listsurgery[0].date;
                          val.addhistory();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => print(
                                  name: val.listonepatiebt[0].name,
                                  id: val.listonepatiebt[0].idpatient,
                                  date: val.listonepatiebt[0].date,
                                  redate: newdr,
                                  sudate: newds,
                                  druge: val.listdrugestoday),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: IconButton(
                      icon: Icon(
                        Icons.next_plan,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // _addpationt();
                        val.getidpatient(val.idpatient + 1);
                        Navigator.of(context)
                            .pushReplacementNamed('datapatient');
                      },
                    ),
                  ),
                ],
              );
      }),
    );
  }
}
