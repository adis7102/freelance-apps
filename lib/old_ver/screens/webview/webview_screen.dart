import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soedja_freelance/old_ver/screens/works/works_screen.dart';
import 'package:soedja_freelance/old_ver/themes/color.dart';
import 'package:soedja_freelance/old_ver/utils/navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final int index;
  final String title;

  WebViewScreen({
    this.index,
    this.title,
  });

  @override
  State<StatefulWidget> createState() {
    return _WebViewScreen();
  }
}

class _WebViewScreen extends State<WebViewScreen> {
  String link = '';

  Completer<WebViewController> _controller = Completer<WebViewController>();
  void fetchLink(int index) {
    switch (index) {
      case 2:
        link = 'https://blog-b6b798.webflow.io/';
        break;
      case 3:
        link = 'https://blog-b6b798.webflow.io/';
        break;
      case 4:
        link = 'https://blog-b6b798.webflow.io/';
        break;
      case 5:
        link = 'https://blog-b6b798.webflow.io/';
        break;
      default:
        link = 'https://blog-b6b798.webflow.io/';
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLink(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBarSection(
        context: context,
        size: size,
        title: widget.title,
        controller: _controller,
      ),
      body: bodySection(
        context: context,
        size: size,
        controller: _controller,
        link: link,
      ),
    );
  }
}

Widget appBarSection({
  BuildContext context,
  Size size,
  String title,
  Completer<WebViewController> controller,
}) {
  return AppBar(
    backgroundColor: AppColors.white,
    elevation: 1.0,
    iconTheme: IconThemeData(),
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: AppColors.black,
      ),
      onPressed: ()=> Navigation().navigateBack(context),
    ),
    title: Text(title, style: TextStyle(color: AppColors.black),),
    actions: <Widget>[
      NavigationControls(controller.future),
//      Menu(_controller.future, () => _favorites),
    ],
  );
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: true),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () => navigate(context, controller, goBack: false),
            ),
          ],
        );
      },
    );
  }

  navigate(BuildContext context, WebViewController controller,
      {bool goBack: false}) async {
    bool canNavigate =
        goBack ? await controller.canGoBack() : await controller.canGoForward();
    if (canNavigate) {
      goBack ? controller.goBack() : controller.goForward();
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text("No ${goBack ? 'back' : 'forward'} history item")),
      );
    }
  }
}

Widget bodySection({
  BuildContext context,
  Size size,
  Completer<WebViewController> controller,
  String link,
}) {
  return WebView(
    initialUrl: link,
    onWebViewCreated: (WebViewController webViewController) {
      controller.complete(webViewController);
    },
  );
}
