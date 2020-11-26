import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';

class QrCodeScanScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _QrCodeScanScreen();
  }

}

class _QrCodeScanScreen extends State<QrCodeScanScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.5),
        elevation: 0,
        leading: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: Container(
              margin: EdgeInsets.all(ScreenUtil().setSp(8)),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius:
                BorderRadius.circular(AppBar().preferredSize.height / 2),
              ),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: ScreenUtil().setSp(24),
                ),
                onPressed: () => Navigation().navigateBack(context),
              )),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(height: size.width,width: size.width,),
          Expanded(
            child: Container(),
          ),

        ],
      ),
    );
  }
}