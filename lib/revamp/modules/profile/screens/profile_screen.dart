import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';
import 'package:soedja_freelance/revamp/helpers/navigation_helper.dart';
import 'package:soedja_freelance/revamp/modules/account/screens/account_screen.dart';
import 'package:soedja_freelance/revamp/modules/auth/bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget{
  final AuthBloc authBloc;

  const ProfileScreen({Key key, this.authBloc,}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true, width: 415, height: 740);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        textTheme: TextTheme(),
        automaticallyImplyLeading: false,
        leading: null,
        title:Text(
          Texts.myProfile,
          style: TextStyle(
            color: Colors.black,
            fontSize: ScreenUtil().setSp(15),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              onPressed: () => {}),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () => Navigation().navigateScreen(
                context,
                AccountScreen(
                  authBloc: widget.authBloc,
//                  version: widget.version,
                )),
          ),
        ],),
    );
  }
}