import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/address_cubit/address_cubit.dart';
import 'package:e_commerce_app/view_models/payment_cubit/payment_method_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalBottomSheetMethod extends StatelessWidget {
  const ModalBottomSheetMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final paymentMethodCubit = BlocProvider.of<PaymentMethodCubit>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 36, right: 24, left: 24, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
              bloc: paymentMethodCubit,
              buildWhen: (previous, current) =>
                  current is FetchingPaymentMethod ||
                  current is FetchedPaymentMethod ||
                  current is FetchingPaymentMethodFailure,
              builder: (context, state) {
                if (state is FetchingPaymentMethod) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is FetchingPaymentMethodFailure) {
                  return Center(child: Text(state.message));
                } else if (state is FetchedPaymentMethod) {
                  final paymentCards = state.paymentCards;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: paymentCards.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        color: Colors.white,
                        child: ListTile(
                          onTap: () {
                            paymentMethodCubit.changePaymentMethod(
                              paymentCards[index].id,
                            );
                          },
                          leading: DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/MasterCard_early_1990s_logo.svg/1280px-MasterCard_early_1990s_logo.svg.png',

                                width: size.width * 0.1,
                                height: size.height * 0.1,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          title: Text(paymentCards[index].holderName),
                          subtitle: Text(paymentCards[index].cardNumber),
                          trailing:
                              BlocBuilder<
                                PaymentMethodCubit,
                                PaymentMethodState
                              >(
                                bloc: paymentMethodCubit,
                                buildWhen: (previous, current) =>
                                    current is ChosenCardMethod,
                                builder: (context, state) {
                                  if (state is ChosenCardMethod) {
                                    final chosenPaymentCard = state.choosenCard;
                                    return Radio<String>(
                                      value: paymentCards[index].id,
                                      groupValue: chosenPaymentCard.id,
                                      onChanged: (id) {
                                        if (id != null) {
                                          paymentMethodCubit
                                              .changePaymentMethod(id);
                                        }
                                      },
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                        ),
                      );
                    },
                  );
                }
                return SizedBox();
              },
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(
                      AppRoutes.paymentPage,
                      arguments: paymentMethodCubit,
                    )
                    .then(
                      (value) async =>
                          await paymentMethodCubit.fetchPaymentMethod(),
                    );
              },
              child: SizedBox(
                height: size.height * 0.07,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Icon(Icons.add, size: size.height * 0.04),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Text('Add New Payment Method'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.06,
              child: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
                bloc: paymentMethodCubit,
                listenWhen: (previous, current) => current is ConfirmCardMethod,
                buildWhen: (previous, current) =>
                    current is ConfirmingCardMethod ||
                    current is ConfirmCardMethod ||
                    current is ConfirmingCardMethodError,
                listener: (context, state) {
                  if (state is ConfirmCardMethod) {
                    Navigator.of(context).pop(true);
                  }
                },
                builder: (context, state) {
                  if (state is ConfirmingCardMethod) {
                    return ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    );
                  }

                  return ElevatedButton(
                    onPressed: () {
                      paymentMethodCubit.confirmCard();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Confirm Payment Card',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
    );
  }
}
