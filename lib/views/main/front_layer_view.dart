import 'dart:ui';

import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/utility/constants.dart';
import 'package:bookledge/views/pdf_viewer/pdf_viewer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FrontLayer {
  Widget getContainer(GetBooksResponse? response, BuildContext context) {
    return Container(
      child: getSizedBox(response, context),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: const Color(0xff28293B),
    );
  }

  var radius = const Radius.circular(Constants.gridRadius);

  Widget getSizedBox(GetBooksResponse? response, BuildContext context) {
    return SizedBox.expand(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GridView.count(
            childAspectRatio: 0.75,
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children:
                List.generate(response?.data.textbookData.length ?? 0, (index) {
              return getGridItem(context, response?.data.textbookData[index],
                  response?.data.subjectData, index);
            }),
          )),
    );
  }

  Widget getGridItem(BuildContext context, TextbookDatum? textbookData,
      List<SubjectDatum>? subjectData, int index) {
    return GestureDetector(
        onTap: () => itemClicked(textbookData, context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius),
          ),
          elevation: 5,
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(radius),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    imageUrl:
                        Constants.fileBaseUrl + textbookData!.chapterThumbUrl,
                    errorWidget: (context, url, error) => Image.network(
                        "https://samagra.kite.kerala.gov.in/assets/img/placeholder.png"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF5855D5),
                          borderRadius: BorderRadius.only(
                              bottomRight: radius, bottomLeft: radius)),
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      clipBehavior: Clip.hardEdge,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subjectData!
                              .firstWhere((element) =>
                                  element.id == textbookData.subjectId)
                              .subjectName,
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ),
              ])),
        ));
  }

  void itemClicked(TextbookDatum? textbookData, BuildContext context) async {
    String url = Constants.fileBaseUrl + textbookData!.chapterPdfUrl;
    print(url);
    Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => PDFViewerCachedFromUrl(
            url: url,
            subName: textbookData.chapterName,
          ),
        ));
  }
}