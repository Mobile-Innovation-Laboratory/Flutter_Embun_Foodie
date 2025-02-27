import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodie/app/modules/dashboard/dashboard_view.dart';
import 'package:foodie/app/modules/login/login_binding.dart';
import 'package:foodie/app/modules/login/login_view.dart';
import 'package:foodie/app/modules/myrecipe/myrecipe_view.dart';
import 'package:foodie/app/modules/newrecipe/newrecipe_view.dart';
import 'package:foodie/app/modules/profile/profile_view.dart';
import 'package:foodie/app/modules/signup/signup_binding.dart';
import 'package:foodie/app/modules/signup/signup_view.dart';
import 'package:foodie/app/modules/welcomescreen/welcomescreen_view.dart';
import 'package:foodie/dummydata.dart';
import 'package:get/get.dart';
import 'package:foodie/routes/app_pages.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('session');
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase failed to initialize: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( 
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.LOGIN,
      getPages: AppPages.routes,
      initialBinding: LoginBinding(), 
    );
  }
}
