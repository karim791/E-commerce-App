import 'package:e_commerce_app/utilities/app_router.dart';
import 'package:e_commerce_app/utilities/app_routes.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await handleNotification();
}

Future<void> handleNotification() async {
  //ask for permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();
  debugPrint('User granted permission: ${settings.authorizationStatus}');

  //handle foreground notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      String title = message.notification!.title ?? '';
      String body = message.notification!.body ?? '';
      debugPrint(
        'Message also contained a notification: ${message.notification}',
      );
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(navigatorKey.currentContext!).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  });

  // handle background notification
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('Message Data : ${message.data}');
    final messageDate = message.data;
    if (messageDate['product_id'] != null) {
      navigatorKey.currentState!.pushNamed(AppRoutes.productDetailsPage,arguments: messageDate['product_id']);
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.checkAuth();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: BlocProvider.of<AuthCubit>(context),
            buildWhen: (previous, current) =>
                current is AuthDone || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                title: 'E-commerce App',
                initialRoute: state is AuthDone
                    ? AppRoutes.homePage
                    : AppRoutes.loginPage,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
