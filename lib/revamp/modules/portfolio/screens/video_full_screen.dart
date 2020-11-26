import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soedja_freelance/revamp/helpers/helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoFullScreen extends StatefulWidget {
  final String url;

  const VideoFullScreen({Key key, this.url}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VideoFullScreen();
  }
}

class _VideoFullScreen extends State<VideoFullScreen> {
  String url;
  @override
  void initState() {
    getVideoId();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  getVideoId(){

    if (widget.url.contains("youtube")) {
      url = YoutubePlayer.convertUrlToId(widget.url);
    } else {
      showDialogMessage(context, "Url Youtube Tidak Ditemukan",
          "Silahkan coba dengan portfolio lainnya.");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: WebView(
          initialUrl: "https://www.youtube.com/embed/$url",
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
