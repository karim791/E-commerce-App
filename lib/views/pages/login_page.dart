import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/views/widget/other_login_methods.dart';
import 'package:e_commerce_app/views/widget/text_form_with_title.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.04),
                Text(
                  'Login Account',
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                Text(
                  'Please login with registered account',
                  style: textTheme.bodyMedium!.copyWith(color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.06),
                TextFormWithTitle(
                  title: 'Email',
                  controller: _emailController,
                  icon: Icon(Icons.email_outlined, color: Colors.grey),
                  hint: 'Enter Your Account',
                ),
                SizedBox(height: size.height * 0.03),

                TextFormWithTitle(
                  title: 'Password',
                  controller: _passwordController,
                  icon: Icon(Icons.password_outlined, color: Colors.grey),
                  hint: 'Enter Your Password',
                  suffexIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                  isScure: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(AppRoutes.homePage);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Enter Valid Email,Password')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.createAccountPage);
                        },
                        child: Text('Create New Account'),
                      ),

                      Text(
                        'Or using other method',
                        style: textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      OtherLoginMethods(
                        onTap: () {},
                        imgUrl:
                            'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                        title: 'Sign in with Google',
                      ),
                      SizedBox(height: size.height * 0.01),

                      OtherLoginMethods(
                        onTap: () {},
                        imgUrl:
                            'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                        title: 'Sign in with Facebook',
                      ),
                    ],
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
