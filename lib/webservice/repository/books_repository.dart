import 'package:bookledge/models/books_response_model/get_books_response.dart';

import '../api_base_helper.dart';

class BooksRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<GetBooksResponse> getBooks(int medium, int grade) async {
    final response = await _helper.get("$medium/$grade");
    print("--------");
    print(response);
    return GetBooksResponse.fromJson(response);
  }
}
