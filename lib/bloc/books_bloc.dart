import 'dart:async';

import 'package:bookledge/models/books_response_model/get_books_response.dart';
import 'package:bookledge/webservice/api_response.dart';
import 'package:bookledge/webservice/repository/books_repository.dart';

class BooksBloc {
  late BooksRepository _booksRepository;
  late StreamController<ApiResponse<GetBooksResponse>> _booksListController;

  StreamSink<ApiResponse<GetBooksResponse>>? get booksSink =>
      _booksListController.sink;
  Stream<ApiResponse<GetBooksResponse>>? get booksStream =>
      _booksListController.stream;

  BooksBloc() {
    _booksListController = StreamController<ApiResponse<GetBooksResponse>>();
    _booksRepository = BooksRepository();
  }

  fetchBooks(int medium, int grade) async {
    booksSink?.add(ApiResponse.loading('Fetching Movies'));
    try {
      GetBooksResponse book = await _booksRepository.getBooks(medium, grade);
      print("-------");
      print(book);
      booksSink?.add(ApiResponse.completed(book));
    } catch (e) {
      booksSink?.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _booksListController.close();
  }
}
