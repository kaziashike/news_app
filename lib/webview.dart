import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

String x = 'www.youtube.com';

class FullNews extends StatefulWidget {
  final String newsUrl;
  FullNews(article, {this.newsUrl});
  @override
  _FullNewsState createState() => _FullNewsState();
}

class _FullNewsState extends State<FullNews> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: WebView(
              initialUrl: widget.newsUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              })),
    );
  }
}
