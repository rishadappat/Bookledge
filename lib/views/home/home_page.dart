import 'package:bookledge/bloc/books_bloc.dart';
import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/utility/preferences.dart';
import 'package:bookledge/views/about/about.dart';
import 'package:bookledge/views/home/back_layer_view.dart';
import 'package:bookledge/views/home/front_layer_view.dart';
import 'package:bookledge/webservice/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BooksBloc _booksBloc;
  var selectedMedium = 0;
  var selectedStd = 0;
  Preferences? prefs;

  @override
  void initState() {
    super.initState();
    _booksBloc = BooksBloc();
    getPreferences().then((value) => getBooks());
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("BookLedge"),
          actions: <Widget>[
            LayoutBuilder(
                builder: (context, constraints) => IconButton(
                    icon: const Icon(Icons.info_outlined),
                    tooltip: 'About',
                    onPressed: () {
                      Backdrop.of(context).concealBackLayer();
                      aboutButtonClicked();
                    }))
          ],
        ),
        backLayer: LayoutBuilder(
            builder: (context, constraints) => BackLayer(
                context: context,
                callback: (medium, std) => {
                      saveValues(medium, std),
                      Backdrop.of(context).concealBackLayer()
                    })),
        frontLayer: RefreshIndicator(
          onRefresh: () => getBooks(),
          child: StreamBuilder<ApiResponse<GetBooksResponse>>(
            stream: _booksBloc.booksStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    break;
                  case Status.COMPLETED:
                    return FrontLayer(
                        context: context,
                        response: snapshot.data!.data,
                        status: snapshot.data!.status,
                        clearSearch: true);
                  case Status.ERROR:
                    return FrontLayer(
                        context: context,
                        response: null,
                        status: snapshot.data!.status,
                        clearSearch: true);
                }
              }
              return FrontLayer(
                  context: context,
                  response: null,
                  status: Status.ERROR,
                  clearSearch: true);
            },
          ),
        ),
        frontLayerScrim: Colors.black.withOpacity(0.6),
        frontLayerBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        stickyFrontLayer: true);
  }

  Future<void> saveValues(int medium, int std) {
    return saveValuesToPrefs(medium, std).whenComplete(() => getBooks());
  }

  Future<void> getBooks() {
    return getValuesFromPrefs()
        .whenComplete(() => _booksBloc.fetchBooks(selectedMedium, selectedStd));
  }

  void aboutButtonClicked() {
    Navigator.push(
        context,
        CupertinoPageRoute<dynamic>(
          builder: (_) => const AboutScreen(),
        ));
  }

  Future<void> getPreferences() async {
    prefs = await Preferences.instance();
  }

  Future<void> saveValuesToPrefs(int medium, int std) async {
    prefs?.saveMedium(medium);
    prefs?.saveStandard(std);
  }

  Future<void> getValuesFromPrefs() async {
    selectedMedium = await prefs?.getMedium() ?? 0;
    selectedStd = await prefs?.getStandard() ?? 0;
  }
}
