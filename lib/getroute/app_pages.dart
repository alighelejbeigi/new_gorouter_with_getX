import 'package:get/get.dart';

import 'app_routes.dart';
import 'screen_a1.dart';
import 'screen_a2.dart';
import 'screen_a3.dart';
import 'screen_b1.dart';
import 'screen_b2.dart';
import 'screen_b3.dart';



class AppPages {
  // initialRoute in main.dart now points to AppRoutes.screenA1 directly

  static final routes = [
    GetPage(
      name: AppRoutes.screenA1,
      page: () => ScreenA1(),
    ),
    GetPage(
      name: AppRoutes.screenA2PathDef, // Uses hierarchical PathDef
      page: () => ScreenA2(),
    ),
    GetPage(
      name: AppRoutes.screenA3PathDef, // Uses hierarchical PathDef
      page: () => ScreenA3(),
    ),
    GetPage(
      name: AppRoutes.screenB1,
      page: () => ScreenB1(),
    ),
    GetPage(
      name: AppRoutes.screenB2PathDef, // Uses hierarchical PathDef
      page: () => ScreenB2(),
    ),
    GetPage(
      name: AppRoutes.screenB3PathDef, // Uses hierarchical PathDef
      page: () => ScreenB3(),
    ),
  ];
}