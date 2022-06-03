import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_live_class/providers/provider_inc.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'providers/count_provider.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (BuildContext context) => CountProvider()),
      ChangeNotifierProvider(create: (BuildContext context) => CartProvider()),
    ], child: MyApp()));
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  getDeviceToken() async {
    // indidual
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    print("getDeviceToken >>> $deviceToken");

    // group of people
    FirebaseMessaging.instance.subscribeToTopic("love");
    FirebaseMessaging.instance.unsubscribeFromTopic("love");

    FirebaseMessaging.onMessage.listen((event) {});

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if (event.data["screen"] == "cart") {}
      // dialog
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    print('Handling a background message ${message.messageId}');
  }

  @override
  void initState() {
    super.initState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ProviderInc(),
    );
  }
}
