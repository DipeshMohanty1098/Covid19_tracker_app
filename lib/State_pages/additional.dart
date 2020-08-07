import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  String loading = "Loading";
  String loading1 = "Loading";
  String loading2 = "Loading";
  String loading3 = "Loading";
  String loading4 = "Loading";

  void getData() async{
    Response response = await get('https://api.rootnet.in/covid19-in/stats/latest');
    Response response1 = await get('https://api.rootnet.in/covid19-in/stats/testing/latest');
    Map tests = jsonDecode(response1.body);
    Map data = jsonDecode(response.body);
    int indian = await (data['data']['summary']['confirmedCasesIndian']);
    int foreign = await (data['data']['summary']['confirmedCasesForeign']);
    int tested = await (tests['data']['totalSamplesTested']);
    int indi = await (tests['data']['totalIndividualsTested']);
    int pos = await (tests['data']['totalPositiveCases']);

    setState(() {
      loading =  indian.toString();
      loading1 = foreign.toString();
      loading2 = tested.toString();
      loading3 = indi.toString();
      loading4 = pos.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Additional Information"),
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
                DataCell(Text('Indian Cases', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(Text('$loading', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Foreign Cases', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(Text('$loading1', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Samples Tested', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(Text('$loading2', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Individuals Tested', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(Text('$loading3', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Positive Cases', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(Text('$loading4', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
            ],
          ),
      ),
      );
  }
}
