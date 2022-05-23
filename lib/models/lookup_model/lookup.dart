import 'dart:convert';

Lookup lookupFromJson(String str) => Lookup.fromJson(json.decode(str));

String lookupToJson(Lookup data) => json.encode(data.toJson());

class Lookup {
  Lookup({
    required this.name,
    required this.id,
    required this.logo,
  });

  String name;
  int id;
  String logo;

  factory Lookup.fromJson(Map<String, dynamic> json) => Lookup(
        name: json["name"],
        id: json["id"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "logo": logo,
      };
}
