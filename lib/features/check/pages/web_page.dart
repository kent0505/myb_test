import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(
        Uri.parse('https://yandex.ru/search?text=%2B${widget.phone}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () async {
              await _controller.reload();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
