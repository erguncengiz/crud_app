import 'package:crud_app/core/environments/environments.dart';
import 'package:crud_app/core/network/accounts_request_client.dart';
import 'package:crud_app/features/create_account/cubit/create_account_cubit.dart';
import 'package:crud_app/features/create_account/models/create_account_request_model/create_account_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

main() async {
  CreateAccountCubit? createAccountCubit;
  AccountsRequestClient? client;
  BuildContext? context;
  await dotenv.load(fileName: Environments.fileName);
  AccountRequest requestMock = AccountRequest(
    birthdate: DateTime.now(),
    id: "999",
    identity: "12345678901",
    name: "Mock",
    phoneNumber: "5556667788",
    salary: 1,
    surname: "Test",
  );

  setUp(() {
    createAccountCubit = CreateAccountCubit();
    client = AccountsRequestClient(Dio(), baseUrl: Environments.apiBaseUrl);
  });

  tearDown(() {
    createAccountCubit?.close();
  });

  test("cubit should have only one state and its CreateAccountState", () {
    expect(createAccountCubit?.state.runtimeType, CreateAccountState);
  });

  blocTest<CreateAccountCubit, CreateAccountState>(
    'emits new list member for HomePage when createOrUpdateAccount() is done',
    build: () => createAccountCubit!,
    act: (CreateAccountCubit? cubit) {
      when(client?.createAccount().then((_) => null));
      cubit?.createOrUpdateAccount(context, false, requestMock);
    },
    expect: () => [],
  );

  blocTest<CreateAccountCubit, CreateAccountState>(
    'emits updated list member for HomePage when createOrUpdateAccount() is done',
    build: () => createAccountCubit!,
    act: (CreateAccountCubit? cubit) {
      when(client?.editAccount().then((_) => null));
      cubit?.createOrUpdateAccount(context, true, requestMock);
    },
    expect: () => [],
  );

  blocTest<CreateAccountCubit, CreateAccountState>(
    'checks all fields are valid when user tapped to done button',
    build: () => createAccountCubit!,
    act: (CreateAccountCubit? cubit) {
      when(cubit?.checkAllFieldsAreValid().then((_) => true));
    },
    expect: () => [],
  );

  blocTest<CreateAccountCubit, CreateAccountState>(
    'fetches all fields when user comes for update',
    build: () => createAccountCubit!,
    act: (CreateAccountCubit? cubit) {
      when(cubit?.fetchIsForUpdate(true, requestMock).then((_) => true));
    },
    expect: () => [],
  );

  blocTest<CreateAccountCubit, CreateAccountState>(
    'not working when user not comes for update',
    build: () => createAccountCubit!,
    act: (CreateAccountCubit? cubit) {
      when(cubit?.fetchIsForUpdate(false, requestMock).then((_) => true));
    },
    expect: () => [],
  );
}
