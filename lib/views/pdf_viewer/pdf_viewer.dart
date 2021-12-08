import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/utility/constants.dart';
import 'package:bookledge/views/about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerCachedFromUrl extends StatelessWidget {
  PDFViewerCachedFromUrl({Key? key, required this.url, required this.subName})
      : super(key: key);

  final String url;
  final String subName;
  var radius = const Radius.circular(25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.bgColor,
        appBar: AppBar(
            title: Text(subName,
                maxLines: 2,
                style: const TextStyle(color: Colors.white, fontSize: 18)),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.info_outlined),
                  tooltip: 'About',
                  onPressed: () {
                    aboutButtonClicked(context);
                  })
            ]),
        body: Container(
          child: Stack(
            children: <Widget>[
              const PDF(
                      swipeHorizontal: true,
                      preventLinkNavigation: false,
                      nightMode: true)
                  .cachedFromUrl(
                url,
                placeholder: (double progress) => (LinearProgressIndicator(
                  backgroundColor: AppTheme.loaderColor.withOpacity(0.2),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.loaderColor),
                  value: progress / 100,
                )),
                errorWidget: (dynamic error) =>
                    Center(child: Text(error.toString())),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  Card(
                    margin: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(radius),
                    ),
                    elevation: 10,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppTheme.bgColor,
                          borderRadius: BorderRadius.all(radius)),
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      clipBehavior: Clip.hardEdge,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "New text",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ]),
              )
            ],
          ),
        ));
  }

  void aboutButtonClicked(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => const AboutScreen(),
        ));
  }
}
