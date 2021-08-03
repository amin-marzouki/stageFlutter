import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_laravel/models/promotion.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter_laravel/services/dio.dart';

class ListProm extends StatefulWidget {
  String token;
  ListProm(String token) {
    this.token = token;
  }
  @override
  _ListPromState createState() => _ListPromState(this.token);
  //State<StatefulWidget> createState() {
  // TODO: implement createState
  // return new Page();
  // }
}

class _ListPromState extends State<ListProm> {
  String token;
  _ListPromState(String token) {
    this.token = token;
  }
  String dataStr = "";

  List<Promotion> _items = [];
  //Dio _client;

  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  @override
  void initState() {
    super.initState();
    fetchAllPromotion(this.token);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body:
          new ListView.builder(itemCount: _items.length, itemBuilder: itemView),
    );
  }

  Widget itemView(BuildContext context, int index) {
    Promotion model = this._items[index];
    //Set the dividing line
    if (index.isOdd) return new Divider(height: 2.0);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Card(
          margin: EdgeInsets.all(10),
          color: Colors.green[100],
          shadowColor: Colors.green[100],
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.album, color: Colors.cyan, size: 45),
                title: Text(
                  'Promotion title : ${model.title}',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text('Description : ${model.description}'),
              ),
              Text(
                'Partenaire : ${model.partenaire}',
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
    );

    /* return new Container(
        color: Color.fromARGB(0x22, 0x49, 0xa9, 0x8d),
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('${model.partenaire}',
                            style: new TextStyle(fontSize: 15.0)),
                        new Text('(${model.type})',
                            style: new TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    new Center(
                      heightFactor: 6.0,
                      child: new Text("${model.description}",
                          style: new TextStyle(fontSize: 17.0)),
                    )
                  ],
                ))));*/
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('list Promotion'));
  }

  void fetchAllPromotion($token) async {
    print('hihhhhhhhhhhh');
    Dio.Response response = await dio().get('/show',
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
    // It's better to return a Model class instead but this is
    // only for example purposes only
    //  print(response);
    // final item = json.decode(response.data);
    //final feeds = body['result'];
    //print(feeds);

    var l = response.data;
    List<Promotion> items = List<Promotion>.from(
        l.map((model) => Promotion.fromJson(model)).toList());
    /* var items = [];
    //body.forEach((item) {
    items.add(Promotion(
        item["title"], item["description"], item["type"], item["partenaire"]));
    print(item['title']);
    //});*/
    setState(() {
      _items = items;
    });
  }
}
