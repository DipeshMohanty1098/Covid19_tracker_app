import 'dart:ui';
import 'package:covid19/state_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:covid19/Drawer_pages/World_page.dart';
import 'package:covid19/State_pages/additional.dart';
import 'file:///D:/AndroidStudioProjects/covid19/lib/shared/loading.dart';
import 'package:covid19/Drawer_pages/Emergency.dart';
import 'package:covid19/Drawer_pages/Trends.dart';
import 'package:firebase_admob/firebase_admob.dart';

class OfficialHomePage extends StatefulWidget {
  @override
  _OfficialHomePageState createState() => _OfficialHomePageState();
}

class _OfficialHomePageState extends State<OfficialHomePage> {
  String loading = "Loading Data";
  String loading1 = "Loading Data";
  String loading2 = "Loading Data";
  String loading3 = "Loading Data";
  String loading4 = "Loading Data";

  Future<void> getData() async {
    Response response =
        await get('https://api.rootnet.in/covid19-in/stats/latest');
    //Response response1 = await get('https://api.rootnet.in/covid19-in/stats/latest');
    Response response2 =
        await get('https://api.rootnet.in/covid19-in/stats/history');
    Map data = jsonDecode(response.body);
    //Map time = jsonDecode(response1.body);
    Map latest = jsonDecode(response2.body);
    int totalcases = (data['data']['summary']['total']);
    int total1 = totalcases;
    int recovered = (data['data']['summary']['discharged']);
    int deaths = (data['data']['summary']['deaths']);
    String date = (data['lastRefreshed']);
    int lastDay =
        (latest['data'][latest['data'].length - 2]['summary']['total']);
    print(lastDay);
    setState(() {
      loading = totalcases.toString();
      loading1 = recovered.toString();
      loading2 = deaths.toString();
      loading4 = (total1 - lastDay).toString();
      if (int.parse(date.substring(11, 13)) > 11) {
        loading3 = date.substring(8, 10) +
            '/' +
            date.substring(5, 7) +
            '/' +
            date.substring(0, 4) +
            " - " +
            date.substring(11, 19) +
            'PM';
      } else
        loading3 = date.substring(8, 10) +
            '/' +
            date.substring(5, 7) +
            '/' +
            date.substring(0, 4) +
            " - " +
            date.substring(11, 19) +
            'AM';
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  String commaAdder(String count) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    String commaAdded = count.replaceAllMapped(reg, mathFunc);
    return commaAdded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Official Stats",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
              child: Text("Total Cases",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(loading.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 26.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
              child: Text("Total Cases today",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(loading4.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 26.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
              child: Text("Recovered",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(loading1.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 26.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
              child: Text("Deaths",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(loading2.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 26.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0, 25.0, 0.0, 15.0),
              child: Text("Last Updated",
                  style: TextStyle(fontSize: 16.0, color: Colors.white))),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text("$loading3",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 23.0,
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton.icon(
                color: Colors.green,
                onPressed: () {
                  Navigator.pushNamed(context, '/location');
                },
                label: Text("Check Statewise Numbers"),
                icon: Icon(Icons.edit_location)),
          )
        ],
      ),
    );
  }
}
