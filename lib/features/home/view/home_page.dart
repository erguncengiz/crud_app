import 'package:crud_app/constants.dart';
import 'package:crud_app/features/create_account/view/create_account.dart';
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
      create: (context) => HomeCubit()..fetchAndCheckSharedPrefs(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber.shade700,
          centerTitle: true,
          title: Text(appBarTitle),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()),
                  );
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => SafeArea(
            child: Column(
              children: [
                _buildBody(context, state),
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
                    Text("${state.pageNumber ?? 0}"),
                    IconButton(
                      onPressed: (state.pageNumber ?? 0) ==
                              (state.totalPageCount ?? 1) - 1
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
                ),
              ],
            ),
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
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          ),
        );
      case PageState.done:
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: (state.maxRange ?? 0) - (state.minRange ?? 0),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ListTile(
                    leading: PopupMenuButton<ExecutionType>(
                        // Callback that sets the selected popup menu item.
                        icon: const Icon(Icons.more_vert),
                        onSelected: (ExecutionType item) {
                          context.read<HomeCubit>().editOrDelete(
                              item, state.accounts![index], context);
                        },
                        itemBuilder: (BuildContext context) => [
                              const PopupMenuItem<ExecutionType>(
                                value: ExecutionType.update,
                                child: Text('Update'),
                              ),
                              const PopupMenuItem<ExecutionType>(
                                value: ExecutionType.delete,
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ]),
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
                      ],
                    ),
                    trailing: Text("${state.accounts![index].salary} \$"),
                  ),
                  const Center(
                    child: Divider(
                      thickness: 0,
                      color: Colors.amber,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
