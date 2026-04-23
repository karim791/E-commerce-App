import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.06,
          child: BlocConsumer<AuthCubit, AuthState>(
            bloc: cubit,
            listenWhen: (previous, current) =>
                current is Loggedout || current is LogoutFailure,
            listener: (context, state) {
              if (state is Loggedout) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginPage,
                  (route) => false,
                );
              } else if (state is LogoutFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Logout Failure')));
              }
            },
            buildWhen: (previous, current) => current is Loggingout,
            builder: (context, state) {
              if (state is Loggingout) {
                return ElevatedButton(
                  onPressed: null,
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  cubit.logout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
