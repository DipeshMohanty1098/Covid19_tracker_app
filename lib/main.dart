import 'dart:ui';
import 'package:covid19/Drawer_pages/OfficialStats.dart';
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

const String testDevice = 'Mobile_ ID';

void main() => runApp(MaterialApp(
        //home: HomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => HomePage(),
          '/location': (context) => ChooseState(),
        }));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: false,
    keywords: <String>['Game', 'Mario'],
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-2352422574824794/8062633403',
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print('BannerAd $event');
        });
  }

  String loading = "Loading Data";
  String loading1 = "Loading Data";
  String loading2 = "Loading Data";
  String loading3 = "Loading Data";
  String loading4 = "Loading Data";

  Future<void> getData() async {
    Response response = await get(
        'https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');
    //Response response1 = await get('https://api.rootnet.in/covid19-in/stats/latest');
    Response response2 = await get(
        'https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise/history');
    Map data = jsonDecode(response.body);
    //Map time = jsonDecode(response1.body);
    Map latest = jsonDecode(response2.body);
    int totalcases = (data['data']['total']['confirmed']);
    int total1 = totalcases;
    int recovered = (data['data']['total']['recovered']);
    int deaths = (data['data']['total']['deaths']);
    String date = (data['lastRefreshed']);
    int lastDay = (latest['data']['history']
        [latest['data']['history'].length - 2]['total']['confirmed']);
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
    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-2352422574824794~1743695111');
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
    getData();
  }

  String commaAdder(String count) {
    RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    Function mathFunc = (Match match) => '${match[1]},';
    String commaAdded = count.replaceAllMapped(reg, mathFunc);
    return commaAdded;
  }

  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Covid-19 Tracker for India",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blueGrey,
          child: ListView(
            children: <Widget>[
              Container(
                height: 65.0,
                color: Colors.blueGrey[800],
                child: DrawerHeader(
                  child: Text("Other Options",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text("Official Stats",
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfficialHomePage()));
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('lib/images/globe.png'),
                ),
                title: Text("World Statistics",
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => World()));
                },
              ),
              ListTile(
                leading: Icon(Icons.contacts, size: 35.0),
                title: Text(
                  "Contact/Helplines",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Contact()));
                },
              ),
              ListTile(
                leading: Icon(Icons.show_chart, size: 35.0),
                title: Text("Trends",
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
                onTap: () {
                  // dispose();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Trends()));
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("  All data sourced from 'covid19india.org'"),
            ],
          ),
        ),
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
                  try {
                    dispose();
                  } catch (e) {
                    Navigator.pushNamed(context, '/location');
                  }
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
