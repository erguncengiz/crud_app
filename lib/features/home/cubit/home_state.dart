// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState {
  final List<AccountsResponse>? accounts;
  final int? pageNumber;
  final String? errorMessage;
  final PageState? pageState;
  final int? totalPageCount;
  final int? minRange;
  final int? maxRange;
  //
  HomeState({
    this.accounts,
    this.pageNumber,
    this.errorMessage,
    this.pageState,
    this.totalPageCount,
    this.minRange,
    this.maxRange,
  });
  //
  HomeState copyWith({
    List<AccountsResponse>? accounts,
    int? pageNumber,
    String? errorMessage,
    PageState? pageState,
    int? totalPageCount,
    int? minRange,
    int? maxRange,
  }) {
    return HomeState(
      accounts: accounts ?? this.accounts,
      pageNumber: pageNumber ?? this.pageNumber,
      errorMessage: errorMessage ?? this.errorMessage,
      pageState: pageState ?? this.pageState,
      totalPageCount: totalPageCount ?? this.totalPageCount,
      minRange: minRange ?? this.minRange,
      maxRange: maxRange ?? this.maxRange,
    );
  }
}
