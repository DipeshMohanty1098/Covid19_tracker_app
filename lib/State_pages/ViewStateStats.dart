import 'package:flutter/material.dart';

class ViewState extends StatelessWidget {
  ViewState({this.state, this.confirmed, this.recovered, this.deaths, this.active });
  String state = '';
  int confirmed;
  int recovered;
  int deaths;
  int active;

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
        backgroundColor: Colors.black87,
        title: Text(state,
            style: TextStyle(
              color: Colors.white,
            )
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(25.0,25.0,0.0,15.0),
              child: Text("Total Cases",
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.grey
                  )
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(confirmed.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 45.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0,25.0,0.0,15.0),
              child: Text("Recovered",
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.grey
                  )
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(recovered.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 45.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0,25.0,0.0,15.0),
              child: Text("Deaths",
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.grey
                  )
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(deaths.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 45.0,
                )),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(25.0,25.0,0.0,15.0),
              child: Text("Active",
                  style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.grey
                  )
              )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(25.0, 0.0, 0.0, 0.0),
            child: Text(commaAdder(active.toString()),
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 45.0,
                )),
          ),
        ],
      ) ,
    );
  }
}
