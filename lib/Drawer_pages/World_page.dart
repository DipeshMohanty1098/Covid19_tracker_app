import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}



class _WorldState extends State<World> {
  String loading = "Loading";
  String loading1 = "Loading";
  String loading2 = "Loading";
  String loading3 = "Loading";
  String loading4 = "Loading";
  String loading5 = "Loading";

  void getData() async{
    Response response = await get('https://api.thevirustracker.com/free-api?global=stats');
    Map data = jsonDecode(response.body);
    int totalcases = await (data['results'][0]['total_cases']);
    int current = await (data['results'][0]['total_unresolved']);
    int recovered = await (data['results'][0]['total_recovered']);
    int deaths = await (data['results'][0]['total_deaths']);
    int update = await (data['results'][0]['total_new_cases_today']);
    int death_today = await(data['results'][0]['total_new_deaths_today']);
    setState(() {
      loading =  totalcases.toString();
      loading1 = recovered.toString();
      loading2 = deaths.toString();
      loading3 = update.toString();
      loading4 = current.toString();
      loading5 = death_today.toString();
    });
  }


  @override
  void initState() {
    super.initState();
    getData();
  }
  String commaAdder(String count){
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
        title: Text("World Statistics"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(
          width: MediaQuery.of(context).size.width,
        ),
        child: DataTable(
          dataRowHeight: 75.0,
          columns: [
            DataColumn(label: Text('Title', style: TextStyle(fontSize:25.0,color: Colors.white ),)),
            DataColumn(label: Text('Count', style: TextStyle(fontSize: 25.0,color: Colors.white),)),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text('Total Cases', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
            DataRow(cells: [
              DataCell(Text('Currently Infected', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading4.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
            DataRow(cells: [
              DataCell(Text('Recovered', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading1.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
            DataRow(cells: [
              DataCell(Text('Deaths', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading2.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
            DataRow(cells: [
              DataCell(Text('Total Cases Today', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading3.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
            DataRow(cells: [
              DataCell(Text('Total Deaths Today', style: TextStyle(fontSize: 20.0,color: Colors.white))),
              DataCell(Text(commaAdder(loading5.toString()), style: TextStyle(fontSize: 20.0,color: Colors.amber))),
            ]),
          ],
        ),
      ),
    );
  }
}
