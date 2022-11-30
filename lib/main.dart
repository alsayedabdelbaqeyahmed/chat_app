import 'package:chatapp/constants/constants.dart';
import 'package:chatapp/constants/local_notififcation.dart';
import 'package:chatapp/constants/routes.dart';
import 'package:chatapp/multiuserchats/multi_user_screens.dart';

import 'package:chatapp/presentation/controller/providers/add_friend_provider.dart';
import 'package:chatapp/presentation/controller/providers/sign_up_provider.dart';
import 'package:chatapp/presentation/controller/providers/chat_screen_provider.dart';
import 'package:chatapp/splash_screen/splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> backgrounHandler(RemoteMessage messege) async {}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationServices.starting();
  FirebaseMessaging.onBackgroundMessage(backgrounHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SignUpProvider>(
            create: (ctx) => SignUpProvider()),
        ChangeNotifierProvider<ChatScreenProvider>(
            create: (ctx) => ChatScreenProvider()),
        ChangeNotifierProvider<AddFriendProvider>(
            create: (ctx) => AddFriendProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor: appBarColor,
          ),
        ),
        home: MyApp(),
        routes: routes,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var fcm = FirebaseMessaging.instance;
  @override
  void initState() {
    fcm.getInitialMessage().then((value) {
      if (value != null) {
        //  print(value.data['route']);
      }
    });

    // foregroun notifiction and must use local Notification
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationServices.display(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // LocalNotificationServices.display(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userData) {
        if (userData.hasData == true) {
          return MultiUserChats();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
