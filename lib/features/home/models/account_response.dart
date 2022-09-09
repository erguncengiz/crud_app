class AccountResponse {
  AccountResponse({
    required this.name,
    required this.surname,
    required this.birthdate,
    required this.salary,
    required this.phoneNumber,
    required this.identity,
    required this.id,
  });

  String name;
  String surname;
  String birthdate;
  int salary;
  String phoneNumber;
  String identity;
  int id;

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      AccountResponse(
        name: json["name"],
        surname: json["surname"],
        birthdate: json["birthdate"],
        salary: json["salary"],
        phoneNumber: json["phoneNumber"],
        identity: json["identity"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "birthdate": birthdate,
        "salary": salary,
        "phoneNumber": phoneNumber,
        "identity": identity,
        "id": id,
      };
}
