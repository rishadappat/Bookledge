import 'dart:ui';

import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/utility/constants.dart';
import 'package:bookledge/views/about/about.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PDFViewerCachedFromUrl extends StatefulWidget {
  const PDFViewerCachedFromUrl(
      {Key? key, required this.textbookData, required this.subjectData})
      : super(key: key);
  final TextbookDatum textbookData;
  final List<SubjectDatum> subjectData;

  @override
  State<PDFViewerCachedFromUrl> createState() => _PDFViewerCachedFromUrlState();
}

class _PDFViewerCachedFromUrlState extends State<PDFViewerCachedFromUrl> {
  PDFViewController? pdfViewController;
  bool downloadComplete = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
                widget.subjectData
                    .firstWhere(
                        (element) =>
                            element.id == widget.textbookData.subjectId,
                        orElse: () => SubjectDatum(
                            id: -1,
                            subjectName: widget.textbookData.chapterName))
                    .subjectName,
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
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              getPdfViewer(),
              Align(
                alignment: Alignment.topCenter,
                child: Column(mainAxisSize: MainAxisSize.max, children: [
                  toolBarView(),
                  const Spacer(),
                ]),
              )
            ],
          ),
        ));
  }

  Widget getPdfViewer() {
    String url = Constants.fileBaseUrl + widget.textbookData.chapterPdfUrl;
    return PDF(
      swipeHorizontal: true,
      preventLinkNavigation: false,
      nightMode: false,
      onViewCreated: (controller) => {
        pdfViewController = controller,
        downloadComplete = true,
        doneClicked(0),
      },
      onPageChanged: (page, total) {
        totalPage = total ?? 0;
        txt.text = ((page ?? 0) + 1).toString();
        setState(() {});
      },
    ).cachedFromUrl(
      url,
      placeholder: (progress) => getPlaceHolderView(progress),
      errorWidget: (dynamic error) => Center(child: Text(error.toString())),
    );
  }

  var txt = TextEditingController();

  TextField inputField(String value) {
    return TextField(
      controller: txt,
      textAlign: TextAlign.center,
      onSubmitted: (value) => {doneClicked(int.parse(value))},
      keyboardType: const TextInputType.numberWithOptions(signed: true),
      textInputAction: TextInputAction.go,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      style:
          TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.bold),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }

  Widget toolBarView() {
    if (!downloadComplete) {
      return Container();
    }
    return Card(
      color: AppTheme.bgColor,
      margin: const EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      shadowColor: AppTheme.bgColor,
      elevation: 10,
      child: Container(
        height: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryColor,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                    ),
                    tooltip: 'Previous',
                    onPressed: () {
                      gotoPrevious();
                    })),
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            const Text(
              "Page",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: 50,
                child: inputField("1")),
            totalText(),
            Expanded(
              child: Container(
                color: Colors.transparent,
              ),
            ),
            CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.primaryColor,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                    tooltip: 'Next',
                    onPressed: () {
                      gotoNext();
                    })),
          ],
        ),
      ),
    );
  }

  var totalPage = 0;

  Text totalText() {
    return Text("of $totalPage",
        textAlign: TextAlign.start,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }

  void aboutButtonClicked(BuildContext context) {
    Navigator.push(
        context,
        CupertinoPageRoute<dynamic>(
          builder: (_) => const AboutScreen(),
        ));
  }

  void doneClicked(int page) async {
    await pdfViewController?.setPage(page - 1);
    var currentPage = await pdfViewController?.getCurrentPage();
    var total = await pdfViewController?.getPageCount();
    setState(() {
      txt.text = ((currentPage ?? 0) + 1).toString();
      totalPage = total ?? 0;
    });
  }

  void gotoNext() async {
    final int currentPage = (await pdfViewController?.getCurrentPage())! + 1;
    final int numberOfPages = await pdfViewController?.getPageCount() ?? 0;
    if (numberOfPages > currentPage) {
      await pdfViewController?.setPage(currentPage);
    }
  }

  void gotoPrevious() async {
    final int currentPage = (await pdfViewController?.getCurrentPage())! - 1;
    if (currentPage >= 0) {
      await pdfViewController?.setPage(currentPage);
    }
  }

  Stack getPlaceHolderView(double progress) {
    return Stack(children: <Widget>[
      CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              alignment: Alignment.center,
              child: getProgressIndicator(progress),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.fitWidth,
        imageUrl: Constants.fileBaseUrl + widget.textbookData.chapterThumbUrl,
        errorWidget: (context, url, error) => Image.network(
            "https://samagra.kite.kerala.gov.in/assets/img/placeholder.png"),
      ),
    ]);
  }

  CircularPercentIndicator getProgressIndicator(double percent) {
    downloadComplete = percent == 100;
    return CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 13.0,
      animation: false,
      percent: percent / 100,
      center: Text(
        "${percent.toInt()}%",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      footer: Container(
        margin: const EdgeInsets.all(0),
        child: const Text(
          "Downloading",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      arcBackgroundColor: AppTheme.accentColor.withOpacity(0.5),
      progressColor: AppTheme.accentColor,
      arcType: ArcType.FULL,
    );
  }
}
