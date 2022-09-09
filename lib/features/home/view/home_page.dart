import 'package:crud_app/constants.dart';
import 'package:crud_app/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/date_time_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAccounts(0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(appBarTitle),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => SafeArea(
            child: _buildBody(context, state),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    switch (state.pageState) {
      case PageState.error:
        return const Center(
          child: Text("Something went wrong!"),
        );
      case PageState.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        );
      case PageState.done:
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: context.read<HomeCubit>().perPageCount,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.grey.shade100,
                    title: Text(
                      ("${state.accounts?[index].name ?? "-"} ${state.accounts?[index].surname ?? "-"}"),
                      style: Constants.textStyle.blackRegular,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${state.accounts?[index].phoneNumber}"),
                        Text(
                            "${state.accounts?[index].birthdate?.yearMonthDayFormat()}"),
                        Text("${state.accounts?[index].identity}"),
                        const Center(
                          child: Divider(
                            thickness: 1,
                          ),
                        )
                      ],
                    ),
                    trailing:
                        Text("${state.accounts![index].salary! * 100} \$"),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: (state.pageNumber ?? 0) == 0
                      ? null
                      : () {
                          print("go for left!");
                          context
                              .read<HomeCubit>()
                              .changePageNumber(isForIncrement: false);
                        },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed:
                      (state.pageNumber ?? 0) == (state.totalPageCount ?? 1) - 1
                          ? null
                          : () {
                              print("go for right!");
                              context
                                  .read<HomeCubit>()
                                  .changePageNumber(isForIncrement: true);
                            },
                  icon: const Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        );
      default:
        return const SizedBox();
    }
  }
}
