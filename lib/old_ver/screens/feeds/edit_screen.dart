import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';

class EditFeedsScreen extends StatefulWidget {
  final Feeds item;

  EditFeedsScreen({
    this.item,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditFeedsScreen();
  }
}

class _EditFeedsScreen extends State<EditFeedsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: appBarSection(
        context: context,
      ),
    );
  }
}

Widget appBarSection({BuildContext context,}){
  return AppBar();
}
