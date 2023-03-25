// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'card_model.g.dart';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class CardModel {
  CardModel({
    required this.cardnumber,
    required this.name,
    required this.date,
    required this.balance,
    required this.id,
  });

  @HiveField(1)
  String cardnumber;
  @HiveField(2)
  String name;
  @HiveField(3)
  String date;
  @HiveField(4)
  String balance;
  @HiveField(5)
  String id;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    cardnumber: json["cardnumber"],
    name: json["name"],
    date: json["date"],
    balance: json["balance"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "cardnumber": cardnumber,
    "name": name,
    "date": date,
    "balance": balance,
    "id": id,
  };
}
