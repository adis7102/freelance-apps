import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dialog.dart';
import 'package:soedja_freelance/old_ver/models/feeds.dart';
import 'package:soedja_freelance/old_ver/models/portfolio.dart';

class PodCastScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PodCastScreen();
  }
}

class _PodCastScreen extends State<PodCastScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          ButtonPrimary(
              child: Icon(Icons.add),
              onTap: () => showPortfolio(
                  context: context,
                  type: 'update',
                  item: Portfolio(
                      title:
                          'Judul Portfolio Ini Panjang Kali Cuman Buat Tes aja Oke?',
                      category: 'Jasa Desain',
                      subCategory: 'Desain Website',
                      typeCategory: 'Aplikasi + Website',
                      createdAt: 1221122))),
        ],
      ),
    );
  }
}
