// To parse this JSON data, do
//
//     final accountsResponse = accountsResponseFromJson(jsonString);

import 'dart:convert';

List<AccountsResponse> accountsResponseFromJson(String str) =>
    List<AccountsResponse>.from(
        json.decode(str).map((x) => AccountsResponse.fromJson(x)));

String accountsResponseToJson(List<AccountsResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountsResponse {
  AccountsResponse({
    this.name,
    this.surname,
    this.birthdate,
    this.salary,
    this.phoneNumber,
    this.identity,
    this.id,
  });

  String? name;
  String? surname;
  DateTime? birthdate;
  int? salary;
  String? phoneNumber;
  String? identity;
  String? id;

  factory AccountsResponse.fromJson(Map<String, dynamic> json) =>
      AccountsResponse(
        name: json["name"],
        surname: json["surname"],
        birthdate: DateTime.parse(json["birthdate"]),
        salary: json["salary"],
        phoneNumber: json["phoneNumber"],
        identity: json["identity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "birthdate": birthdate?.toIso8601String(),
        "salary": salary,
        "phoneNumber": phoneNumber,
        "identity": identity,
        "id": id,
      };
}
