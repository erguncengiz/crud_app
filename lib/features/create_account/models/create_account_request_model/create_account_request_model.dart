// To parse this JSON data, do
//
//     final accountsRequest = accountsRequestFromJson(jsonString);

import 'dart:convert';

List<AccountRequest> accountsRequestFromJson(String str) =>
    List<AccountRequest>.from(
        json.decode(str).map((x) => AccountRequest.fromJson(x)));

String accountsRequestToJson(List<AccountRequest> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountRequest {
  AccountRequest({
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

  factory AccountRequest.fromJson(Map<String, dynamic> json) => AccountRequest(
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
