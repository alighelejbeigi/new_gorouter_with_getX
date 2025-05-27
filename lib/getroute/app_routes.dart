class AppRoutes {
  static const String home = '/'; // Can be used for a potential global home screen

  // Section A Routes - Hierarchical
  static const String screenA1 = '/a1'; // Base for path A

  // Path definition for GetPage (e.g., /a1/a2/:paramA2)
  static const String screenA2PathDef = '${screenA1}/a2/:paramA2';
  // Navigation call helper
  static String screenA2({required String paramA2}) => '${screenA1}/a2/$paramA2';

  // Path definition for GetPage (e.g., /a1/a2/:paramA2/a3/:paramA3)
  static const String screenA3PathDef = '${screenA1}/a2/:paramA2/a3/:paramA3';
  // Navigation call helper
  static String screenA3({required String paramA2, required String paramA3}) => '${screenA1}/a2/$paramA2/a3/$paramA3';


  // Section B Routes - Hierarchical
  static const String screenB1 = '/b1'; // Base for path B

  // Path definition for GetPage (e.g., /b1/b2/:paramB2)
  static const String screenB2PathDef = '${screenB1}/b2/:paramB2';
  // Navigation call helper
  static String screenB2({required String paramB2}) => '${screenB1}/b2/$paramB2';

  // Path definition for GetPage (e.g., /b1/b2/:paramB2/b3/:paramB3)
  static const String screenB3PathDef = '${screenB1}/b2/:paramB2/b3/:paramB3';
  // Navigation call helper
  static String screenB3({required String paramB2, required String paramB3}) => '${screenB1}/b2/$paramB2/b3/$paramB3';
}