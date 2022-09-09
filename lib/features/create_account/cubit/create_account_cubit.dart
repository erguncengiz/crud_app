import 'package:crud_app/features/create_account/models/create_account_request_model/create_account_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../core/network/accounts_request_client.dart';
import '../../../core/extensions/date_time_extension.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountState());

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateController =
      TextEditingController(text: DateTime.now().yearMonthDayFormat());
  TextEditingController salaryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController identityController = TextEditingController();

  //Client
  AccountsRequestClient client = AccountsRequestClient(Dio(), baseUrl: baseUrl);

  Future<void> createOrUpdateAccount(
      BuildContext context, bool? isForUpdate, AccountRequest? model) async {
    try {
      if (isForUpdate ?? false) {
        await client.editAccount(
            body: AccountRequest(
              birthdate: DateTime.parse(dateController.text),
              identity: identityController.text,
              name: nameController.text,
              surname: surnameController.text,
              phoneNumber: phoneNumberController.text,
              salary: int.parse(salaryController.text),
            ),
            id: model?.id);
      } else {
        await client.createAccount(
          body: AccountRequest(
            birthdate: DateTime.parse(dateController.text),
            identity: identityController.text,
            name: nameController.text,
            surname: surnameController.text,
            phoneNumber: phoneNumberController.text,
            salary: int.parse(salaryController.text),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchIsForUpdate(bool isForUpdate, AccountRequest? model) {
    if (isForUpdate) {
      nameController.text = model!.name!;
      surnameController.text = model.surname!;
      dateController.text = model.birthdate!.yearMonthDayFormat();
      salaryController.text = model.salary.toString();
      phoneNumberController.text = model.phoneNumber!;
      identityController.text = model.identity!;
    }
  }

  bool get checkAllFieldsAreValid => (nameController.text.isNotEmpty &&
      surnameController.text.isNotEmpty &&
      dateController.text.isNotEmpty &&
      salaryController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      identityController.text.isNotEmpty);
}
