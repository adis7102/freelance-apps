import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/expansion_tile_helper.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';

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
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            DividerWidget(
              padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              child: Text(
                widget.list[index]['sub_kategori_tnc'] ?? '',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int data) {
                return ExpansionTileSubtitle(
                  leading: Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  title: Text(
                    widget.list[index]['value'][data]['title_tnc'] ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        ScreenUtil().setWidth(20),
                        ScreenUtil().setHeight(0),
                        ScreenUtil().setWidth(20),
                        ScreenUtil().setHeight(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.list[index]['value'][data]
                                  ['description_tnc'] ??
                              '',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            height: 1.5,
                            fontSize: ScreenUtil().setSp(12),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(10)),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                  indent: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(10),
                  endIndent: ScreenUtil().setWidth(20)),
              itemCount: widget.list[index]['value'].length,
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: ScreenUtil().setHeight(10)),
      itemCount: widget.list.length ?? 1,
    );
  }
}
