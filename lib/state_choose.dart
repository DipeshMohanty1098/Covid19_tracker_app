import 'package:covid19/State_pages/ViewStateStats.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:covid19/shared/loading.dart';

class ChooseState extends StatefulWidget {
  @override
  _ChooseStateState createState() => _ChooseStateState();
}

class _ChooseStateState extends State<ChooseState> {

  List stateList;
  Future<void> getData() async {
    Response response = await get('https://api.rootnet.in/covid19-in/unofficial/covid19india.org/statewise');
    Map data = jsonDecode(response.body);
    //print(data);
    setState(() {
      stateList = data['data']['statewise'];
    });

  }

  @override
  void initState(){
    super.initState();
    getData();
    //print(commaAdder('123456'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black87,
        title: Text("Choose State",
            style: TextStyle(
              color: Colors.white,
            )
        ),
        centerTitle: true,),
      body: buildList(stateList),
    );
  }
}

String commaAdder(String count){
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';
  String commaAdded = count.replaceAllMapped(reg, mathFunc);
  return commaAdded;

}

Widget buildList(List stateList) {
  try {
    stateList.length;
  } catch (e) {
    return Loading();
  }
  return ListView.builder(
      itemCount: stateList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            trailing: IconButton(icon: Icon(Icons.arrow_forward_ios),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewState(state: stateList[index]['state'],
                confirmed: stateList[index]['confirmed'],
                recovered: stateList[index]['recovered'],
                deaths: stateList[index]['deaths'],
                active: stateList[index]['active'],)));
            },),
            subtitle: Text('Total cases: ' + commaAdder(stateList[index]['confirmed'].toString())),
            title: Text(stateList[index]['state']),
          ),
        );
      }
  );
}