import 'package:doctor/veiw/printreport.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provid/prov.dart';

class historypage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _historypage();
  }
}

class _historypage extends State<historypage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<changedata>(context, listen: false).gethistory();
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/body.jpeg'), fit: BoxFit.cover)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //name and details////////////////////////////////////////
          Expanded(child: Consumer<changedata>(builder: (context, val, child) {
            return Container(
              // padding: EdgeInsets.all(30),
              // color: Colors.black.withOpacity(0.4),
              // height: double.infinity,
              margin: EdgeInsets.only(left: 30, top: 30, bottom: 30),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(50)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "History",
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Column(
                        children: [
                          Text(
                            "${val.listonepatiebt[0].name}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(fontSize: 80, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20, right: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Id: ${val.listonepatiebt[0].idpatient}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text(
                            "Phone: ${val.listonepatiebt[0].phone}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text(
                            "Age: ${val.listonepatiebt[0].age}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text(
                            "Date: ${val.listonepatiebt[0].date}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })),
          //history patient ////////////////////////////////////////////////////
          Expanded(child: Consumer<changedata>(builder: (context, val, child) {
            return Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),

              //list history//////////////////////////////////////////////////////
              child: ListView.builder(
                itemCount: val.listhistory.length,
                itemBuilder: (context, i) {
                  return Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 20),

                    width: double.infinity,
                    decoration: BoxDecoration(
                        //boxShadow: ,
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(30)),
                    //height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Diseace",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: val.listpatientdiseace.length,
                                      itemBuilder: (context, j) {
                                        return val.listpatientdiseace[j].date ==
                                                val.listhistory[i].date
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.all(10),
                                                height: 100,

                                                //width: 100,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.white.withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                child: Center(
                                                    child: Text(
                                                  '${val.listpatientdiseace[j].namedisease}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )),
                                              )
                                            : Container();
                                      }),
                                ),
                                Text(
                                  "Report",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    "${val.listhistory[i].problem}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 20,
                                  ),
                                ),
                              ],
                            )),
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.all(10),
                              child: Text(
                                "Date: ${val.listhistory[i].date}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //druge
                        Text(
                          "Drugs",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: val.listdruges.length,
                              itemBuilder: (context, j) {
                                return val.listdruges[j].date ==
                                        val.listhistory[i].date
                                    ? Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.all(10),
                                        height: 100,

                                        //width: 100,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Center(
                                            child: Text(
                                          '${val.listdruges[j].druge}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                      )
                                    : Container();
                              }),
                        ),

                        Text(
                                  "Notes",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: val.listnote.length,
                                      itemBuilder: (context, j) {
                                        return val.listnote[j].date ==
                                                val.listhistory[i].date
                                            ? Container(
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.all(10),
                                                height: 100,

                                                //width: 100,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.white.withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                child: Center(
                                                    child: Text(
                                                  '${val.listnote[j].note}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                )),
                                              )
                                            : Container();
                                      }),
                                ),
                        Text(
                          "Payments",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 70,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: val.listpayment.length,
                            itemBuilder: (context, j) {
                              return val.listpayment[j].date ==
                                      val.listhistory[i].date
                                  ? Container(
                                      margin: EdgeInsets.all(10),
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      //color: ,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Text(
                                              "${val.listpayment[j].why}: ${val.listpayment[j].salary}",
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
                                    )
                                  : Container();
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.topRight,
                          child: CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  late List listdiseace = [];
                                    for (int j = 0;
                                      j < val.listpatientdiseace.length;
                                      j++) {
                                    if (val.listpatientdiseace[j].date ==
                                        val.listhistory[i].date) {
                                      listdiseace.add(val.listpatientdiseace[j]);
                                    }
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => printreport(
                                          name: val.listonepatiebt[0].name,
                                          id: val.listonepatiebt[0].idpatient,
                                          date: val.listhistory[i].date,
                                          report: val.listhistory[i].problem,
                                          diseace: listdiseace),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.print)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          })),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 20,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}
