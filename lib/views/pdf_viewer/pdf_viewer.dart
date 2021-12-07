import 'package:bookledge/views/about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl(
      {Key? key, required this.url, required this.subName})
      : super(key: key);

  final String url;
  final String subName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subName), actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.info_outlined),
            tooltip: 'About',
            onPressed: () {
              aboutButtonClicked(context);
            })
      ]),
      body: const PDF(swipeHorizontal: true, preventLinkNavigation: false)
          .cachedFromUrl(
        url,
        placeholder: (double progress) => (LinearProgressIndicator(
          backgroundColor: const Color(0xff44CCFC).withOpacity(0.2),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff44CCFC)),
          value: progress / 100,
        )),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }

  void aboutButtonClicked(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => const AboutScreen(),
        ));
  }
}
