import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:soedja_freelance/revamp/assets/texts.dart';

void shareApp(BuildContext context){

  final RenderBox box = context.findRenderObject();
  Share.share(Texts.shareContent,
      subject: "Subjects",
      sharePositionOrigin:
      box.localToGlobal(Offset.zero) & box.size);
}