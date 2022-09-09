import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../core/network/accounts_request_client.dart';
import '../models/accounts_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences sharedPreferences;
  late List<AccountsResponse> accounts = [];
  int perPageCount = 10;
  AccountsRequestClient client = AccountsRequestClient(Dio(), baseUrl: baseUrl);

  HomeCubit() : super(HomeState());

  void totalPageCount(List<AccountsResponse> values) {
    if (values.isNotEmpty) {
      emit(state.copyWith(
          totalPageCount: (values.length ~/ perPageCount).ceil()));
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
    getAccounts(number);
  }

  int maxRangeCalculator(int pageIndex, List<AccountsResponse>? response) {
    return ((pageIndex + 1) * perPageCount) > (response?.length ?? 0)
        ? (response?.length ?? 0)
        : (pageIndex + 1) * perPageCount;
  }
}
