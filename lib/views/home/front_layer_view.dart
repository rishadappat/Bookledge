
import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/utility/constants.dart';
import 'package:bookledge/utility/utility.dart';
import 'package:bookledge/views/pdf_viewer/pdf_viewer.dart';
import 'package:bookledge/webservice/api_response.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utility/preferences.dart';

class FrontLayer extends StatefulWidget {
  const FrontLayer(
      {Key? key,
      required this.context,
      required this.response,
      required this.status,
      required this.clearSearch})
      : super(key: key);

  final GetBooksResponse? response;
  final BuildContext context;
  final Status status;
  final bool clearSearch;

  @override
  State<StatefulWidget> createState() {
    return FrontLayerState();
  }
}

class FrontLayerState extends State<FrontLayer> {
  var radius = const Radius.circular(Constants.gridRadius);
  var columnCount = 2;
  List<SubjectDatum>? subjectData = [];
  List<TextbookDatum>? textbookData = [];
  List<TextbookDatum>? filteredTextbookData = [];
  var searchKey = "";
  var searchController = TextEditingController();
  bool clearSearch = false;
  var selectedMedium = 0;
  var selectedStd = 0;
  Preferences? prefs;

  @override
  Widget build(BuildContext context) {
    textbookData = widget.response?.data.textbookData;
    subjectData = widget.response?.data.subjectData;
    filteredTextbookData = performSearch();
    var container = getContainer();
    return container;
  }

  Widget getContainer() {
    getValuesFromPrefs();
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      color: AppTheme.bgColor,
      child: getSizedBox(context),
    );
  }

  Widget getSizedBox(BuildContext context) {
    if (Utility().getDeviceType() == DeviceType.Tablet) {
      columnCount = 3;
    }
    var medium = Utility().getLookupForMedium(selectedMedium);
    return SizedBox.expand(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Center(
                  child: TextField(
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search books',
                      prefixIcon: const Icon(Icons.search),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        color: searchKey == ""
                            ? Colors.white
                            : AppTheme.accentColor,
                        onPressed: () {
                          setState(() {
                            searchKey = "";
                            searchController.clear();
                          });
                        },
                      ),
                    ),
                    onChanged: (text) {
                      print(text);
                      setState(() {
                        searchKey = text;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Utility().getNumberDigitIcon(selectedStd),
                      const SizedBox(width: 10),
                      Text("Standard $selectedStd",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(medium.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ImageIcon(
                          AssetImage(medium.logo),
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.count(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  childAspectRatio: 0.75,
                  crossAxisCount: columnCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children:
                      List.generate(filteredTextbookData?.length ?? 0, (index) {
                    return getGridItem(context, filteredTextbookData?[index],
                        subjectData, index);
                  }),
                ),
              ),
            ],
          )),
    );
  }

  Widget getGridItem(BuildContext context, TextbookDatum? textbookData,
      List<SubjectDatum>? subjectData, int index) {
    return GestureDetector(
        onTap: () => itemClicked(textbookData, subjectData, context),
        child: Card(
          shadowColor: AppTheme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(radius),
          ),
          elevation: 15,
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
                          color: AppTheme.accentColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: radius, bottomLeft: radius)),
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                      clipBehavior: Clip.hardEdge,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          subjectData
                                  ?.firstWhere(
                                      (element) =>
                                          element.id == textbookData.subjectId,
                                      orElse: () => SubjectDatum(
                                          id: -1,
                                          subjectName:
                                              textbookData.chapterName))
                                  .subjectName ??
                              "",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]),
                ),
              ])),
        ));
  }

  void itemClicked(TextbookDatum? textbookData, List<SubjectDatum>? subjectData,
      BuildContext context) async {
    Navigator.push(
        context,
        CupertinoPageRoute<dynamic>(
          builder: (_) => PDFViewerCachedFromUrl(
              textbookData: textbookData!, subjectData: subjectData!),
        ));
  }

  List<TextbookDatum>? performSearch() {
    if (searchKey == "") {
      return textbookData;
    }
    return textbookData
            ?.where((element) => element.chapterName
                .toLowerCase()
                .contains(searchKey.toLowerCase()))
            .toList() ??
        List.empty();
  }

  Future<void> getPreferences() async {
    prefs = await Preferences.instance();
  }

  Future<void> getValuesFromPrefs() async {
    getPreferences();
    var medium = await prefs?.getMedium() ?? 0;
    var std = await prefs?.getStandard() ?? 0;
    setState(() {
      selectedMedium = medium;
      selectedStd = std;
    });
  }
}
