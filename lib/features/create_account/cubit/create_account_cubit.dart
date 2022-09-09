import 'package:crud_app/features/create_account/models/create_account_request_model/create_account_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../core/network/accounts_request_client.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit() : super(CreateAccountState());

  //Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController identityController = TextEditingController();

  //Client
  AccountsRequestClient client = AccountsRequestClient(Dio(), baseUrl: baseUrl);

  Future<void> createAccount(BuildContext context) async {
    emit(state.copyWith(pageState: PageState.loading));
    try {
      var httpResponse = await client.createAccount(
        body: AccountRequest(
          birthdate: DateTime.parse(dateController.text),
          identity: identityController.text,
          name: nameController.text,
          surname: surnameController.text,
          phoneNumber: phoneNumberController.text,
          salary: int.parse(salaryController.text),
        ),
      );
      var response = httpResponse?.data;

      Navigator.of(context).pop();
      //
      emit(state.copyWith(
        pageState: PageState.done,
      ));
    } catch (e) {
      emit(state.copyWith(pageState: PageState.error));
    }
  }

  bool get checkAllFieldsAreValid => (nameController.text.isNotEmpty &&
      surnameController.text.isNotEmpty &&
      dateController.text.isNotEmpty &&
      salaryController.text.isNotEmpty &&
      phoneNumberController.text.isNotEmpty &&
      identityController.text.isNotEmpty);
}
