import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:soedja_freelance/old_ver/components/tile.dart';
import 'package:soedja_freelance/old_ver/screens/feeds/detail_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';

class ExpandableListScreen extends StatefulWidget {
  final List<dynamic> list;

  ExpandableListScreen({this.list});

  @override
  State<StatefulWidget> createState() {
    return _ExpandableListScreen();
  }

}

class _ExpandableListScreen extends State<ExpandableListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            dividerText(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Text(
                widget.list[index]['sub_kategori_tnc'] ?? '',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int data) {
                return ExpansionTileSubtitle(
                  leading: Icon(
                    Icons.info,
                    color: AppColors.black,
                  ),
                  title: Text(
                    widget.list[index]['value'][data]['title_tnc'] ?? '',
                    style: TextStyle(color: AppColors.black, fontSize: 15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.list[index]['value'][data]
                                  ['description_tnc'] ??
                              '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(height: 1.5),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  dividerLine(indent: 16.0, height: 8.0, endIndent: 16.0),
              itemCount: widget.list[index]['value'].length,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 8.0),
      itemCount: widget.list.length ?? 1,
    );
  }
}
