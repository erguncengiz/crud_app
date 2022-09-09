import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../core/network/accounts_request_client.dart';
import '../models/account_response.dart';
import '../models/accounts_response.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  late SharedPreferences sharedPreferences;
  late List<AccountResponse> accounts = [];
  AccountsRequestClient client = AccountsRequestClient(Dio(), baseUrl: baseUrl);

  HomeCubit() : super(HomeState());

  void totalPageCount(List<Page> values) {
    if (values.isNotEmpty) {
      emit(state.copyWith(totalPageCount: values.length));
    }
  }

  Future<void> getAccounts(int pageIndex) async {
    emit(state.copyWith(pageState: PageState.loading));
    try {
      var httpResponse = await client.getAccounts();
      var response = httpResponse?.data;
      accounts.clear();
      accounts.addAll(response?.first.page[pageIndex].value ?? []);
      if (state.totalPageCount == null) {
        totalPageCount(response?.first.page ?? []);
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
}
