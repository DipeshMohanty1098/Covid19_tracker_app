import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text("Helplines"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(
          //width: MediaQuery.of(context).size.width,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            dataRowHeight: 75.0,
            columns: [
              DataColumn(label: Text('Contact', style: TextStyle(fontSize:25.0,color: Colors.white ),)),
              DataColumn(label: Text('Info', style: TextStyle(fontSize: 25.0,color: Colors.white),)),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Number', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(SelectableText(' +91-11-23978046 ', style: TextStyle(fontSize: 17.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Tollfree Number', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(SelectableText('1075', style: TextStyle(fontSize: 20.0,color: Colors.amber))),
              ]),
              DataRow(cells: [
                DataCell(Text('Email', style: TextStyle(fontSize: 20.0,color: Colors.white))),
                DataCell(SelectableText('ncov2019@gov.in', style: TextStyle(fontSize: 15.0,color: Colors.amber))),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
