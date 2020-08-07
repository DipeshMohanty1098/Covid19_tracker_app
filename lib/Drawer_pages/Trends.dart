import 'package:covid19/main.dart';
import 'package:covid19/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_echarts/flutter_echarts.dart';

class Trends extends StatefulWidget {

  @override
  _TrendsState createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {

  List<double> cases1 = [];
  List<String> dates1 = [];
  void getData() async {
    int i  = 0;
    List<double> cases = [];
    List<String> dates = [];
    Response response = await get('https://api.rootnet.in/covid19-in/stats/history');
    Map data = jsonDecode(response.body);
    for (i;i<data['data'].length; i++){
      cases.add((data['data'][i]['summary']['total'])/1000.0);
      dates.add(i.toString());

    }
    setState(() {
      cases1 = cases;
      dates1 = dates;
    });
    print(dates1);
  }
  bool loading = false;
  @override
  void initState(){
    super.initState();
    try {
      getData();
    }catch(e){
      setState(() {
        loading = true;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        //padding: Edge,
            child: Echarts(
              option: '''
        {
          xAxis: {
            type: 'category',
            data: $dates1,
            show: false,
            name: 'time',
            nameLocation: 'middle',
            verticalAlign: 'top'
            
          },
          yAxis: {
            type: 'value',
            name: 'Cases',
            
          },
          series: [{
            data: $cases1,
            type: 'line'
          }]
    }
  ''',
            ),
            width: 1000.0,

          ),

    );
  }
}






