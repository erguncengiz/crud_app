// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState {
  final List<AccountsResponse>? accounts;
  final int? pageNumber;
  final String? errorMessage;
  final PageState? pageState;
  final int? totalPageCount;
  //
  HomeState({
    this.accounts,
    this.pageNumber,
    this.errorMessage,
    this.pageState,
    this.totalPageCount,
  });
  //
  HomeState copyWith({
    List<AccountsResponse>? accounts,
    int? pageNumber,
    String? errorMessage,
    PageState? pageState,
    int? totalPageCount,
  }) {
    return HomeState(
      accounts: accounts ?? this.accounts,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      pageState: pageState ?? this.pageState,
      totalPageCount: totalPageCount ?? this.totalPageCount,
    );
  }
}
