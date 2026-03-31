import 'package:flutter/material.dart';
import 'package:p_papper/core/constant/app_colors.dart';
import 'package:p_papper/core/utils/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebviewPage extends StatefulWidget {
  final String url;
  final String title;

  const ArticleWebviewPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<ArticleWebviewPage> createState() =>
      _ArticleWebviewPageState();
}

class _ArticleWebviewPageState
    extends State<ArticleWebviewPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = CustomAppBar(
      title: widget.title,
      context: context,
    );

    return Scaffold(
      appBar: appBar.customAppbar,
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.spinnerColor,
              ),
            ),
        ],
      ),
    );
  }
}
