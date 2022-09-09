import 'package:crud_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import '../cubit/create_account_cubit.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountCubit(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(appBarTitle),
          ),
          body: BlocBuilder<CreateAccountCubit, CreateAccountState>(
            builder: (context, state) {
              return Column(
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
                      controller:
                          context.read<CreateAccountCubit>().surnameController,
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
                      controller:
                          context.read<CreateAccountCubit>().identityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Identity",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (context
                          .read<CreateAccountCubit>()
                          .checkAllFieldsAreValid) {
                        context
                            .read<CreateAccountCubit>()
                            .createAccount(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('User creation request sent!'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Please make sure all fields are valid!'),
                        ));
                      }
                    },
                    child: const Text("Create Account"),
                  ),
                  const SizedBox(
                    height: 150,
                  )
                ],
              );
            },
          )),
    );
  }
}
