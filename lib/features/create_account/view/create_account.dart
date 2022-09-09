import 'package:crud_app/constants.dart';
import 'package:crud_app/features/create_account/models/create_account_request_model/create_account_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../cubit/create_account_cubit.dart';

class CreateAccountPage extends StatefulWidget {
  final AccountRequest? model;
  final bool? isForUpdate;
  const CreateAccountPage({
    super.key,
    this.model,
    this.isForUpdate = false,
  });

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit()
        ..fetchIsForUpdate((widget.isForUpdate ?? false), widget.model),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber.shade700,
            centerTitle: true,
            title: Text(appBarTitle),
          ),
          body: BlocBuilder<CreateAccountCubit, CreateAccountState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller:
                            context.read<CreateAccountCubit>().nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: context
                            .read<CreateAccountCubit>()
                            .surnameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Surname",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DateTimeField(
                        controller:
                            context.read<CreateAccountCubit>().dateController,
                        format: DateFormat("yyyy-MM-dd"),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(8, 20, 20, 20),
                          border: OutlineInputBorder(),
                        ),
                        initialValue: DateTime.now(),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller:
                            context.read<CreateAccountCubit>().salaryController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Salary",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: context
                            .read<CreateAccountCubit>()
                            .phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: context
                            .read<CreateAccountCubit>()
                            .identityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Identity",
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade700),
                      onPressed: () {
                        if (context
                            .read<CreateAccountCubit>()
                            .checkAllFieldsAreValid) {
                          context
                              .read<CreateAccountCubit>()
                              .createOrUpdateAccount(
                                  context, widget.isForUpdate, widget.model);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: (widget.isForUpdate ?? false)
                                ? const Text("User update request sent!")
                                : const Text('User creation request sent!'),
                          ));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text('Please make sure all fields are valid!'),
                          ));
                        }
                      },
                      child: (widget.isForUpdate ?? false)
                          ? const Text("Update Account")
                          : const Text("Create Account"),
                    ),
                    const SizedBox(
                      height: 150,
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
