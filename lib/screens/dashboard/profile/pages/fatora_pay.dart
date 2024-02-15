import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FatoraPay extends StatefulWidget{
  final String currencyCode;
  final double amount;
  final String customerEmail;
  final String customerName;
  final String customerPhone;
  final String customerCountry;
  final String lang;
  final String note;

  FatoraPay({
    required this.currencyCode,
    required this.amount,
    required this.customerEmail,
    required this.customerName,
    required this.customerPhone,
    required this.customerCountry,
    required this.lang,
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  _FatoraPayState createState() => _FatoraPayState();



}
class _FatoraPayState extends State<FatoraPay> {



  @override
  Widget build(BuildContext context) {

    final String url =
        'https://fatora.hashnate.com?currencyCode=${widget.currencyCode}'
        '&amount=${widget.amount}'
        '&customerEmail=${widget.customerEmail}'
        '&customerName=${widget.customerName}'
        '&customerPhone=${widget.customerPhone}'
        '&customerCountry=${widget.customerCountry}'
        '&lang=${widget.lang}'
        '&note=${widget.note}';

    // Create a webview controller
    final _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // print the loading progress to the console
            // you can use this value to show a progress bar if you want
            debugPrint("Loading: $progress%");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print("******Nav Request**********$request");
            return NavigationDecision.navigate;
          },
          onUrlChange: (value){
            // print("******URL change**********$value");
          }
        ),
      )
      ..loadRequest(Uri.parse(url));


    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Payment'),
      ),
      body: SizedBox(
          width: double.infinity,
          // the most important part of this example
          child: WebViewWidget(
            controller: _controller,
          )),
    );
  }
  // final Completer<WebViewController> _webViewController =
  // Completer<WebViewController>();
  // bool _isLoading = true;
  //
  // @override
  // Widget build(BuildContext context) {
  //   final String url =
  //       'https://fatora.hashnate.com?currencyCode=${widget.currencyCode}'
  //       '&amount=${widget.amount}'
  //       '&customerEmail=${widget.customerEmail}'
  //       '&customerName=${widget.customerName}'
  //       '&customerPhone=${widget.customerPhone}'
  //       '&customerCountry=${widget.customerCountry}'
  //       '&lang=${widget.lang}'
  //       '&note=${widget.note}';
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       // ... your existing code
  //     ),
  //     body: Stack(
  //       children: <Widget>[
  //         WebView(
  //           initialUrl: url,
  //           javascriptMode: JavascriptMode.unrestricted,
  //           onWebViewCreated: (WebViewController webViewController) {
  //             _webViewController.complete(webViewController);
  //           },
  //           onPageStarted: (String url) {
  //             setState(() {
  //               _isLoading = true; // Set loading to true when the page starts loading
  //             });
  //           },
  //           onPageFinished: (String url) {
  //             setState(() {
  //               _isLoading = false; // Set loading to false when the page finishes loading
  //             });
  //           },
  //           onWebResourceError: (WebResourceError error) {
  //             // Handle web resource error
  //             print("Web Resource Error: $error");
  //           },
  //           navigationDelegate: (NavigationRequest request) {
  //             // Handle navigation requests
  //             if (request.url.startsWith(url)) {
  //               return NavigationDecision.prevent;
  //             }
  //             return NavigationDecision.navigate;
  //           },
  //         ),
  //
  //         if (_isLoading)
  //           Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //       ],
  //     ),
  //   );
  // }
}

