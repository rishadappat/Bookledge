//
//  GetBooksResponse.dart
//  Model Generated using http://www.jsoncafe.com/
//  Created on November 7, 2021

// To parse this JSON data, do
//
//     final getBooksResponse = getBooksResponseFromJson(jsonString);

import 'dart:convert';

GetBooksResponse getBooksResponseFromJson(String str) =>
    GetBooksResponse.fromJson(json.decode(str));

String getBooksResponseToJson(GetBooksResponse data) =>
    json.encode(data.toJson());

class GetBooksResponse {
  GetBooksResponse({
    required this.status,
    required this.data,
  });

  String status;
  Data data;

  factory GetBooksResponse.fromJson(Map<String, dynamic> json) =>
      GetBooksResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.subjectData,
    required this.textbookData,
  });

  List<SubjectDatum> subjectData;
  List<TextbookDatum> textbookData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subjectData: List<SubjectDatum>.from(
            json["subjectData"].map((x) => SubjectDatum.fromJson(x))),
        textbookData: List<TextbookDatum>.from(
            json["textbookData"].map((x) => TextbookDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjectData": List<dynamic>.from(subjectData.map((x) => x.toJson())),
        "textbookData": List<dynamic>.from(textbookData.map((x) => x.toJson())),
      };
}

class SubjectDatum {
  SubjectDatum({
    required this.id,
    required this.subjectName,
  });

  int id;
  String subjectName;

  factory SubjectDatum.fromJson(Map<String, dynamic> json) => SubjectDatum(
        id: json["id"],
        subjectName: json["subjectName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectName": subjectName,
      };
}

class TextbookDatum {
  TextbookDatum({
    required this.id,
    required this.subjectId,
    required this.chapterName,
    required this.chapterPdfUrl,
    required this.chapterThumbUrl,
  });

  int id;
  int subjectId;
  String chapterName;
  String chapterPdfUrl;
  String chapterThumbUrl;

  factory TextbookDatum.fromJson(Map<String, dynamic> json) => TextbookDatum(
        id: json["id"],
        subjectId: json["subjectId"],
        chapterName: json["chapterName"],
        chapterPdfUrl: json["chapterPdfUrl"],
        chapterThumbUrl: json["chapterThumbUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subjectId": subjectId,
        "chapterName": chapterName,
        "chapterPdfUrl": chapterPdfUrl,
        "chapterThumbUrl": chapterThumbUrl,
      };
}
