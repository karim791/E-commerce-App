import 'package:e_commerce_app/view_models/payment_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/views/widget/text_form_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumcontroller = TextEditingController();
  final TextEditingController _cardHoldercontroller = TextEditingController();
  final TextEditingController _cardDatecontroller = TextEditingController();
  final TextEditingController _cvvcontroller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodCubit>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add New Card'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                TextFormWithTitle(
                  title: 'Card Number',
                  controller: _cardNumcontroller,
                  hint: 'Enter card number',
                  icon: Icon(Icons.credit_card_outlined),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextFormWithTitle(
                  title: 'Card Holder Name',
                  controller: _cardHoldercontroller,
                  hint: 'Enter card holder name',
                  icon: Icon(Icons.person_2_outlined),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextFormWithTitle(
                  title: 'Expiry Date',
                  controller: _cardDatecontroller,
                  hint: 'Enter expiry date',
                  icon: Icon(Icons.calendar_month_outlined),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextFormWithTitle(
                  title: 'CVV',
                  controller: _cvvcontroller,
                  hint: 'Enter cvv',
                  icon: Icon(Icons.password_outlined),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                    bloc: BlocProvider.of<PaymentMethodCubit>(context),
                    listenWhen: (previous, current) =>
                        current is PaymentMethodSuccess ||
                        current is PaymentMethodFailure,
                    listener: (context, state) {
                      if (state is PaymentMethodSuccess) {
                        Navigator.of(context).pop();
                      } else if (state is PaymentMethodFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errorMessage)),
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        current is PaymentMethodLoading ||
                        current is PaymentMethodSuccess ||
                        current is PaymentMethodFailure,
                    builder: (context, state) {
                      if (state is PaymentMethodLoading) {
                        return ElevatedButton(
                          onPressed: null,
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            cubit.getCard(
                              _cardNumcontroller.text,
                              _cardHoldercontroller.text,
                              _cardDatecontroller.text,
                              _cvvcontroller.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Add Card',
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
