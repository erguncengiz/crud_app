// To parse this JSON data, do
//
//     final accountsResponse = accountsResponseFromJson(jsonString);

import 'dart:convert';

import 'account_response.dart';

AccountsResponse accountsResponseFromJson(String str) =>
    AccountsResponse.fromJson(json.decode(str));

String accountsResponseToJson(AccountsResponse data) =>
    json.encode(data.toJson());

class AccountsResponse {
  AccountsResponse({
    required this.page,
  });

  List<Page> page;

  factory AccountsResponse.fromJson(Map<String, dynamic> json) =>
      AccountsResponse(
        page: List<Page>.from(json["page"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": List<dynamic>.from(page.map((x) => x.toJson())),
      };
}

class Page {
  Page({
    required this.id,
    required this.value,
  });

  int id;
  List<AccountResponse> value;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        value: List<AccountResponse>.from(
            json["value"].map((x) => AccountResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}
