// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    required this.houseware,
    required this.grocery,
  });

  Houseware houseware;
  Grocery grocery;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        houseware: Houseware.fromJson(json["Houseware"]),
        grocery: Grocery.fromJson(json["grocery"]),
      );

  Map<String, dynamic> toJson() => {
        "Houseware": houseware.toJson(),
        "grocery": grocery.toJson(),
      };
}

class Grocery {
  Grocery({
    required this.fruits,
    required this.vegetables,
  });

  List<String> fruits;
  List<String> vegetables;

  factory Grocery.fromJson(Map<String, dynamic> json) => Grocery(
        fruits: List<String>.from(json["fruits"].map((x) => x)),
        vegetables: List<String>.from(json["vegetables"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fruits": List<dynamic>.from(fruits.map((x) => x)),
        "vegetables": List<dynamic>.from(vegetables.map((x) => x)),
      };
}

class Houseware {
  Houseware({
    required this.electronic,
  });

  List<String> electronic;

  factory Houseware.fromJson(Map<String, dynamic> json) => Houseware(
        electronic: List<String>.from(json["electronic"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "electronic": List<dynamic>.from(electronic.map((x) => x)),
      };
}
