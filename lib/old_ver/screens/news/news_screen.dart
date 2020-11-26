import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewsScreen();
  }

}

class _NewsScreen extends State<NewsScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Column(children: <Widget>[Text('news')],),);
  }
}