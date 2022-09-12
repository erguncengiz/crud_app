import 'package:bloc_test/bloc_test.dart';
import 'package:crud_app/constants.dart';
import 'package:crud_app/core/environments/environments.dart';
import 'package:crud_app/core/network/accounts_request_client.dart';
import 'package:crud_app/features/home/cubit/home_cubit.dart';
import 'package:crud_app/features/home/models/accounts_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

main() async {
  HomeCubit? homeCubit;
  AccountsRequestClient? client;
  List<AccountsResponse>? values = [
    AccountsResponse(
      birthdate: DateTime.now(),
      id: "999",
      identity: "12345678901",
      name: "Mock",
      phoneNumber: "5556667788",
      salary: 1,
      surname: "Test",
    )
  ];
  await dotenv.load(fileName: Environments.fileName);
  BuildContext? context;

  setUp(() {
    homeCubit = HomeCubit();
    client = AccountsRequestClient(Dio(), baseUrl: Environments.apiBaseUrl);
  });

  tearDown(() {
    homeCubit?.close();
  });

  test("cubit should have only one state and its HomeState", () {
    expect(homeCubit?.state.runtimeType, HomeState);
  });

  blocTest<HomeCubit, HomeState>(
    'fetches SharedPreferences to save user last page',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(cubit?.fetchAndCheckSharedPrefs().then((_) => null));
    },
    expect: () => [],
  );

  blocTest<HomeCubit, HomeState>(
    'calculate total page count for pagination',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(cubit?.totalPageCount(values));
    },
    expect: () => [isA<HomeState>()],
  );

  blocTest<HomeCubit, HomeState>(
    'decrement page number when user tap the left arrow button',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(cubit?.changePageNumber(isForIncrement: false));
    },
    expect: () => [isA<HomeState>(), isA<HomeState>()],
  );

  blocTest<HomeCubit, HomeState>(
    'increment page number when user tap the right arrow button',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(cubit?.changePageNumber(isForIncrement: true));
    },
    expect: () => [isA<HomeState>(), isA<HomeState>()],
  );

  blocTest<HomeCubit, HomeState>(
    'emits [PageState.loading, PageState.done] when getAccounts() is done',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(client?.getAccounts().then((_) => []));
      cubit?.getAccounts(3);
    },
    expect: () => [isA<HomeState>()],
  );

  blocTest<HomeCubit, HomeState>(
    'calculate maximum and minimum ranges for itemCount of ListView widget',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(cubit?.maxRangeCalculator(1, values));
    },
    expect: () => [],
  );

  blocTest<HomeCubit, HomeState>(
    'navigate user to update screen',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(client?.editAccount());
      cubit?.editOrDelete(ExecutionType.update, values.first, context);
    },
    expect: () => [],
  );

  blocTest<HomeCubit, HomeState>(
    'deleting the account and refreshing the HomeState',
    build: () => homeCubit!,
    act: (HomeCubit? cubit) {
      when(client?.editAccount());
      cubit?.editOrDelete(ExecutionType.delete, values.first, context);
    },
    expect: () => [isA<HomeState>()],
  );
}
