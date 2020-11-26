import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/components/button.dart';
import 'package:soedja_freelance/old_ver/components/dots.dart';
import 'package:soedja_freelance/old_ver/constants/lists.dart';
import 'package:soedja_freelance/old_ver/constants/local_storage.dart';
import 'package:soedja_freelance/old_ver/constants/strings.dart';
import 'package:soedja_freelance/old_ver/screens/auth/auth_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/local_storage.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OnBoardScreen();
  }
}

class _OnBoardScreen extends State<OnBoardScreen> {
  int index = 0;
  PageController _controller = PageController();

  void onSkip() async {
    await LocalStorage.set(LocalStorageKey.FirstTime, 'true').then((value) {
      Navigation().navigateReplacement(context, AuthScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: <Widget>[
          contentSection(
              context: context,
              controller: _controller,
              index: index,
              onChanged: (val) {
                setState(() {
                  index = val;
                });
              },
              size: size),
          bottomNavSection(
              context: context,
              index: index,
              onChanged: (val) {
                if (index != 2) {
                  setState(() {
                    index = val;
                    _controller.animateToPage(
                      index,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  });
                } else {
                  onSkip();
                }
              },
              onSkip: () => onSkip()),
        ],
      ),
    );
  }
}

Widget contentSection({
  BuildContext context,
  PageController controller,
  int index,
  Function(int) onChanged,
  Size size,
}) {
  return Expanded(
    child: PageView(
        controller: controller,
        onPageChanged: (int page) => onChanged(page),
        children: List.generate(listOnBoard.length,
            (index) => pageScreen(data: listOnBoard[index], size: size))),
  );
}

Widget pageScreen({var data, Size size}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Image.asset(
        data['image'],
        width: size.width,
        height: size.height / 1.8,
        fit: BoxFit.fitHeight,
      ),
      SizedBox(height: 32.0),
      Text(
        data['title'],
        style: TextStyle(
          fontSize: 25.0,
          color: AppColors.black,
        ),
      ),
      SizedBox(height: 24.0),
      Text(
        data['subtitle'],
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 15.0,
            color: AppColors.black,
            height: 1.5),
      ),
    ],
  );
}

Widget bottomNavSection({
  BuildContext context,
  int index,
  Function(int) onChanged,
  Function onSkip,
}) {
  return Container(
    decoration: BoxDecoration(
        color: AppColors.white,
        border:
            Border(top: BorderSide(color: AppColors.black.withOpacity(.2)))),
    padding: EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ButtonPrimary(
            context: context,
            buttonColor: AppColors.white,
            child: Text(
              Strings.skip.toUpperCase(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 12.0,),
            ),
            onTap: () => onSkip()),
        Dots(index: index),
        ButtonPrimary(
            context: context,
            buttonColor: AppColors.white,
            child: Icon(
              Icons.chevron_right,
              color: AppColors.black,
            ),
            onTap: () => onChanged(index + 1)),
      ],
    ),
  );
}
