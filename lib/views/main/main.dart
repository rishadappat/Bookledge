import 'package:bookledge/bloc/books_bloc.dart';
import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/utility/app_theme.dart';
import 'package:bookledge/views/about/about.dart';
import 'package:bookledge/views/main/back_layer_view.dart';
import 'package:bookledge/views/main/front_layer_view.dart';
import 'package:bookledge/webservice/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookLedge',
      theme: AppTheme.theme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BooksBloc _booksBloc;
  var selectedMedium = 1;
  var selectedGrade = 11;

  @override
  void initState() {
    super.initState();
    _booksBloc = BooksBloc();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: const Text("BookLedge"),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.info_outlined),
                tooltip: 'About',
                onPressed: () {
                  aboutButtonClicked();
                })
          ],
        ),
        backLayer: BackLayer(context: context).getView(),
        frontLayer: RefreshIndicator(
          onRefresh: () => getBooks(),
          child: StreamBuilder<ApiResponse<GetBooksResponse>>(
            stream: _booksBloc.booksStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data?.status) {
                  case Status.LOADING:
                    break;
                  case Status.COMPLETED:
                    return FrontLayer()
                        .getContainer(snapshot.data!.data, context);
                  case Status.ERROR:
                    return FrontLayer().getContainer(null, context);
                  case null:
                    return FrontLayer().getContainer(null, context);
                }
              }
              return FrontLayer().getContainer(null, context);
            },
          ),
        ),
        frontLayerScrim: Colors.black.withOpacity(0.6),
        frontLayerBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        stickyFrontLayer: true);
  }

  Future<void> getBooks() {
    return _booksBloc.fetchBooks(selectedMedium, selectedGrade);
  }

  void aboutButtonClicked() {
    Navigator.push(
        context,
        CupertinoPageRoute<dynamic>(
          builder: (_) => const AboutScreen(),
        ));
  }
}
