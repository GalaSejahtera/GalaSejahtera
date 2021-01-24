import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'news_layout_screen.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsModelChoice newsDetailChoice;
  NewsDetailScreen({ this.newsDetailChoice });

  @override
  _NewsDetailScreen createState() => _NewsDetailScreen();
}

class _NewsDetailScreen extends State<NewsDetailScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsDetailChoice.title),
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return Stack(
            children: <Widget>[
              WebView(
                userAgent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36",
                initialUrl: widget.newsDetailChoice.newsUrl,
                javascriptMode: JavascriptMode.disabled,
                navigationDelegate: (NavigationRequest request) {
                  return NavigationDecision.navigate;
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
            ]);
      }),
    );
  }
}