import 'package:crud_app/constants.dart';
import 'package:crud_app/features/create_account/models/create_account_request_model/create_account_request_model.dart';
import 'package:crud_app/i18n/LocalizationKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:localization/localization.dart';

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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocalizationKeys.name.i18n(),
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocalizationKeys.surname.i18n(),
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocalizationKeys.salary.i18n(),
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocalizationKeys.phone_number.i18n(),
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
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: LocalizationKeys.identity.i18n(),
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
                                ? Text(
                                    LocalizationKeys.user_update_message.i18n())
                                : Text(LocalizationKeys.user_create_message
                                    .i18n()),
                          ));
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                LocalizationKeys.fields_error_message.i18n()),
                          ));
                        }
                      },
                      child: (widget.isForUpdate ?? false)
                          ? Text(LocalizationKeys.update_button_title.i18n())
                          : Text(LocalizationKeys.create_button_title.i18n()),
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
