// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_account_cubit.dart';

class CreateAccountState {
  final PageState? pageState;

  CreateAccountState({
    this.pageState,
  });

  CreateAccountState copyWith({
    PageState? pageState,
  }) {
    return CreateAccountState(
      pageState: pageState ?? this.pageState,
    );
  }
}
