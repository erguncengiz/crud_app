import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../core/environments/environments.dart';
import '../../../core/network/accounts_request_client.dart';
import '../../create_account/models/create_account_request_model/create_account_request_model.dart';
import '../../create_account/view/create_account.dart';
import '../models/accounts_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences? sharedPreferences;
  late List<AccountsResponse> accounts = [];
  int perPageCount = 10;
  AccountsRequestClient client =
      AccountsRequestClient(Dio(), baseUrl: Environments.apiBaseUrl);

  HomeCubit() : super(HomeState());

  void fetchAndCheckSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences?.containsKey(Constants.keys.savedPageIndex) ??
        false) {
      int lastIndex = sharedPreferences!.getInt(Constants.keys.savedPageIndex)!;
      emit(state.copyWith(pageNumber: lastIndex));
      getAccounts(lastIndex);
    } else {
      getAccounts(0);
    }
  }

  void totalPageCount(List<AccountsResponse> values) {
    if (values.isNotEmpty) {
      emit(state.copyWith(
          totalPageCount: (values.length / perPageCount).ceil()));
    }
  }

  Future<void> getAccounts(int pageIndex) async {
    emit(state.copyWith(pageState: PageState.loading));
    try {
      var httpResponse = await client.getAccounts();
      var response = httpResponse?.data;
      accounts.clear();
      int minRange = pageIndex * perPageCount;
      int maxRange = maxRangeCalculator(pageIndex, response);
      accounts.addAll(response?.getRange(minRange, maxRange) ?? []);
      if (state.totalPageCount == null) {
        totalPageCount(response ?? []);
      }
      if (accounts.isEmpty) {
        throw (Exception("Empty array!"));
      } else {
        emit(state.copyWith(
          minRange: minRange,
          maxRange: maxRange,
          pageState: PageState.done,
          accounts: accounts,
        ));
      }
    } catch (e) {
      emit(state.copyWith(pageState: PageState.error));
    }
  }

  void changePageNumber({bool? isForIncrement}) {
    var number = state.pageNumber ?? 0;
    if (isForIncrement ?? false) {
      number = number + 1;
      emit(state.copyWith(pageNumber: number));
    } else {
      number = number - 1;
      emit(state.copyWith(pageNumber: number));
    }
    sharedPreferences!.setInt(Constants.keys.savedPageIndex, number);
    getAccounts(number);
  }

  int maxRangeCalculator(int pageIndex, List<AccountsResponse>? response) {
    return ((pageIndex + 1) * perPageCount) > (response?.length ?? 0)
        ? (response?.length ?? 0)
        : (pageIndex + 1) * perPageCount;
  }

  Future<void> editOrDelete(
      ExecutionType type, AccountsResponse model, BuildContext context) async {
    try {
      if (type == ExecutionType.update) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateAccountPage(
              isForUpdate: true,
              model: AccountRequest(
                birthdate: model.birthdate,
                id: model.id,
                identity: model.identity,
                name: model.name,
                phoneNumber: model.phoneNumber,
                salary: model.salary,
                surname: model.surname,
              ),
            ),
          ),
        ).then((value) {
          emit(state.copyWith(pageState: PageState.loading));
          Future.delayed(const Duration(milliseconds: 1300))
              .then((value) => getAccounts(state.pageNumber ?? 0));
        });
      } else {
        emit(state.copyWith(pageState: PageState.loading));
        await client.deleteAccount(
            body: AccountRequest(
              birthdate: model.birthdate,
              id: model.id,
              identity: model.identity,
              name: model.name,
              phoneNumber: model.phoneNumber,
              salary: model.salary,
              surname: model.surname,
            ),
            id: model.id);
      }
      getAccounts(state.pageNumber ?? 0);
    } catch (e) {
      print(e);
    }
  }
}
