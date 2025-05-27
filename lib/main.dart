// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// --- Configuration for GoRouter (Flat Structure) ---
// This would typically be in a separate file e.g., 'app_routes.dart'

class AppRoutes {
  static const String home = '/';

  // Section A Routes
  static const String sectionA = '/a'; // Path for the shell/entry of section A
  static const String screenA1 = '/a/a1';

  // For GoRouter path definition (includes parameter placeholders)
  static const String screenA2PathDef = '/a/a1/a2/:paramA2';
  static const String screenA3PathDef = '/a/a1/a2/:paramA2/a3';

  // For navigation calls (constructs path with actual parameter values)
  static String screenA2({required String paramA2}) => '/a/a1/a2/$paramA2';

  static String screenA3({required String paramA2}) => '/a/a1/a2/$paramA2/a3';

  // Section B Routes
  static const String sectionB = '/b'; // Path for the shell/entry of section B
  static const String screenB1 = '/b/b1';

  // For GoRouter path definition
  static const String screenB2PathDef = '/b/b1/b2/:paramB2';
  static const String screenB3PathDef = '/b/b1/b2/:paramB2/b3';

  // For navigation calls
  static String screenB2({required String paramB2}) => '/b/b1/b2/$paramB2';

  static String screenB3({required String paramB2}) => '/b/b1/b2/$paramB2/b3';
}

// GoRouter configuration (Flat)
final GoRouter _router = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),

    // --- Section A Routes (All Top Level) ---
    GoRoute(
      path: AppRoutes.sectionA, // This is '/a'
      builder: (BuildContext context, GoRouterState state) {
        return SectionShellScreen(
          title: 'Section A',
          firstScreenPath: AppRoutes.screenA1,
          // Pass the full path to the first actual screen
          param: state.extra as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.screenA1, // This is '/a/a1'
      builder: (BuildContext context, GoRouterState state) {
        return ScreenA1(message: state.extra as String?);
      },
    ),
    GoRoute(
      path: AppRoutes.screenA2PathDef, // This is '/a/a1/a2/:paramA2'
      builder: (BuildContext context, GoRouterState state) {
        final paramA2 = state.pathParameters['paramA2']!;
        return ScreenA2(paramA2: paramA2, extraMessage: state.extra as String?);
      },
    ),
    GoRoute(
      path: AppRoutes.screenA3PathDef, // This is '/a/a1/a2/:paramA2/a3'
      builder: (BuildContext context, GoRouterState state) {
        final paramA2 =
            state
                .pathParameters['paramA2']!; // paramA2 is part of this route's path
        return ScreenA3(paramFromA2: paramA2, message: state.extra as String?);
      },
    ),

    // --- Section B Routes (All Top Level) ---
    GoRoute(
      path: AppRoutes.sectionB, // This is '/b'
      builder: (BuildContext context, GoRouterState state) {
        return SectionShellScreen(
          title: 'Section B',
          firstScreenPath: AppRoutes.screenB1, // Pass the full path
          param: state.extra as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.screenB1, // This is '/b/b1'
      builder: (BuildContext context, GoRouterState state) {
        return ScreenB1(message: state.extra as String?);
      },
    ),
    GoRoute(
      path: AppRoutes.screenB2PathDef, // This is '/b/b1/b2/:paramB2'
      builder: (BuildContext context, GoRouterState state) {
        final paramB2 = state.pathParameters['paramB2']!;
        return ScreenB2(paramB2: paramB2, extraMessage: state.extra as String?);
      },
    ),
    GoRoute(
      path: AppRoutes.screenB3PathDef, // This is '/b/b1/b2/:paramB2/b3'
      builder: (BuildContext context, GoRouterState state) {
        final paramB2 =
            state
                .pathParameters['paramB2']!; // paramB2 is part of this route's path
        return ScreenB3(paramFromB2: paramB2, message: state.extra as String?);
      },
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Flutter GetX GoRouter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      backButtonDispatcher: _router.backButtonDispatcher,
    );
  }
}

// --- GetX Controllers (Example) ---
class SimpleScreenController extends GetxController {
  final String screenName;
  final RxString message = "Initial Message".obs;
  final RxInt counter = 0.obs;

  SimpleScreenController(this.screenName);

  void increment() {
    counter.value++;
    message.value = "$screenName Counter: ${counter.value}";
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$screenName Controller Initialized");
  }

  @override
  void onClose() {
    debugPrint("$screenName Controller Closed");
    super.onClose();
  }
}

// --- Screen Widgets ---

// Base Screen for consistent styling
class BaseScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String? currentPath;

  const BaseScreen({
    super.key,
    required this.title,
    required this.children,
    this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading:
            GoRouter.of(context).canPop()
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => GoRouter.of(context).pop(),
                )
                : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (currentPath != null)
                  Card(
                    color: Colors.deepPurple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Current Path: $currentPath',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                ...children.map(
                  (child) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: child,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Home Screen',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        const Text(
          'Welcome! Choose a section to explore.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.go(
              AppRoutes.sectionA,
              extra: 'Hello from Home to Section A!',
            );
          },
          child: const Text('Go to Section A'),
        ),
        ElevatedButton(
          onPressed: () {
            context.go(AppRoutes.sectionB, extra: 'Greetings to Section B!');
          },
          child: const Text('Go to Section B'),
        ),
      ],
    );
  }
}

// Updated SectionShellScreen
class SectionShellScreen extends StatelessWidget {
  final String title;
  final String firstScreenPath; // Now expects the full path to navigate to
  final String? param;

  const SectionShellScreen({
    super.key,
    required this.title,
    required this.firstScreenPath,
    this.param,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: title,
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'This is the main screen for $title.',
          style: const TextStyle(fontSize: 16),
        ),
        if (param != null)
          Text(
            'Received param: "$param"',
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to the first actual screen of this section using the full path
            context.go(
              firstScreenPath,
              extra: 'Navigating to $firstScreenPath',
            );
          },
          child: Text('Go to Initial Screen of $title'),
        ),
      ],
    );
  }
}

// --- Screens for Section A ---
class ScreenA1 extends StatelessWidget {
  final String? message;

  const ScreenA1({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A1"), tag: "A1");
    final SimpleScreenController controller = Get.find(tag: "A1");

    return BaseScreen(
      title: 'Screen A1',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A1 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String paramForA2 = "paramForA2_from_A1";
            // Use the updated AppRoutes method for navigation
            context.go(
              AppRoutes.screenA2(paramA2: paramForA2),
              extra: 'Data for A2',
            );
          },
          child: const Text('Go to Screen A2 (with param)'),
        ),
      ],
    );
  }
}

class ScreenA2 extends StatelessWidget {
  final String paramA2;
  final String? extraMessage;

  const ScreenA2({super.key, required this.paramA2, this.extraMessage});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A2"), tag: "A2");
    final SimpleScreenController controller = Get.find(tag: "A2");

    return BaseScreen(
      title: 'Screen A2',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Received Path Parameter for A2: "$paramA2"',
          style: const TextStyle(color: Colors.orange, fontSize: 16),
        ),
        if (extraMessage != null)
          Text(
            'Extra Message: "$extraMessage"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A2 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Use the updated AppRoutes method, passing the required paramA2
            context.go(
              AppRoutes.screenA3(paramA2: paramA2),
              extra: 'Hello A3!',
            );
          },
          child: const Text('Go to Screen A3'),
        ),
      ],
    );
  }
}

class ScreenA3 extends StatelessWidget {
  final String
  paramFromA2; // This is the 'paramA2' from the path /a/a1/a2/:paramA2/a3
  final String? message;

  const ScreenA3({super.key, required this.paramFromA2, this.message});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A3"), tag: "A3");
    final SimpleScreenController controller = Get.find(tag: "A3");

    return BaseScreen(
      title: 'Screen A3',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Deepest Screen in Section A.',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Parameter from A2 context (paramA2): "$paramFromA2"',
          style: const TextStyle(color: Colors.purple, fontSize: 16),
        ),
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A3 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          onPressed: () {
            String paramForB2 = "param_from_A3_for_B2";
            context.go(
              AppRoutes.screenB2(paramB2: paramForB2),
              extra: 'Jumped from A3 to B2!',
            );
          },
          child: const Text('Go to Screen B2 (Cross-Branch)'),
        ),
      ],
    );
  }
}

// --- Screens for Section B ---
class ScreenB1 extends StatelessWidget {
  final String? message;

  const ScreenB1({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B1',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String paramForB2 = "paramForB2_from_B1";
            context.go(AppRoutes.screenB2(paramB2: paramForB2), extra: 'Hi B2');
          },
          child: const Text('Go to Screen B2 (with param)'),
        ),
      ],
    );
  }
}

class ScreenB2 extends StatelessWidget {
  final String paramB2;
  final String? extraMessage;

  const ScreenB2({super.key, required this.paramB2, this.extraMessage});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B2',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Received Path Parameter for B2: "$paramB2"',
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
        if (extraMessage != null)
          Text(
            'Extra Message: "$extraMessage"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.go(AppRoutes.screenB3(paramB2: paramB2));
          },
          child: const Text('Go to Screen B3'),
        ),
      ],
    );
  }
}

class ScreenB3 extends StatelessWidget {
  final String paramFromB2; // This is 'paramB2' from path /b/b1/b2/:paramB2/b3
  final String? message;

  const ScreenB3({super.key, required this.paramFromB2, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B3',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Deepest Screen in Section B.',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Parameter from B2 context (paramB2): "$paramFromB2"',
          style: const TextStyle(color: Colors.pink, fontSize: 16),
        ),
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
          onPressed: () {
            String paramForA2 = "param_from_B3_for_A2";
            context.go(
              AppRoutes.screenA2(paramA2: paramForA2),
              extra: 'Jumped from B3 to A2!',
            );
          },
          child: const Text('Go to Screen A2 (Cross-Branch)'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
          onPressed: () {
            context.go(AppRoutes.home);
          },
          child: const Text('Go to Home Screen'),
        ),
      ],
    );
  }
}

// --- Error Screen ---
class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Not Found")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Oops, something went wrong or the page doesn't exist.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            if (error != null)
              Text(error.toString(), style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

/*
// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// --- Configuration for GoRouter ---
// This would typically be in a separate file e.g., 'app_routes.dart'

// Define route paths to avoid magic strings
class AppRoutes {
  static const String home = '/';
  static const String sectionA = '/a';
  static const String screenA1 = 'a1'; // Relative to sectionA
  static const String screenA2 = 'a2'; // Relative to screenA1
  static const String screenA3 = 'a3'; // Relative to screenA2

  static const String sectionB = '/b';
  static const String screenB1 = 'b1'; // Relative to sectionB
  static const String screenB2 = 'b2'; // Relative to screenB1
  static const String screenB3 = 'b3'; // Relative to screenB2

  // Helper methods to build paths with parameters
  static String pathScreenA2(String paramForA2) =>
      '$sectionA/$screenA1/$screenA2/$paramForA2';

  static String pathScreenA3(String paramForA2) =>
      '$sectionA/$screenA1/$screenA2/$paramForA2/$screenA3';

  static String pathScreenB2(String paramForB2) =>
      '$sectionB/$screenB1/$screenB2/$paramForB2';

  static String pathScreenB3(String paramForB2) =>
      '$sectionB/$screenB1/$screenB2/$paramForB2/$screenB3';
}

// GoRouter configuration
final GoRouter _router = GoRouter(
  initialLocation: AppRoutes.home,
  debugLogDiagnostics: true, // Useful for debugging navigation
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.sectionA,
      builder: (BuildContext context, GoRouterState state) {
        // This screen could act as a shell or just the first screen of section A
        return SectionShellScreen(
          title: 'Section A',
          childPath: AppRoutes.screenA1,
          param: state.extra as String?,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.screenA1, // Full path: /a/a1
          builder: (BuildContext context, GoRouterState state) {
            return ScreenA1(message: state.extra as String?);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '${AppRoutes.screenA2}/:paramA2',
              // Full path: /a/a1/a2/:paramA2
              builder: (BuildContext context, GoRouterState state) {
                final paramA2 = state.pathParameters['paramA2']!;
                return ScreenA2(
                  paramA2: paramA2,
                  extraMessage: state.extra as String?,
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.screenA3, // Full path: /a/a1/a2/:paramA2/a3
                  builder: (BuildContext context, GoRouterState state) {
                    final paramA2 = state.pathParameters['paramA2']!;
                    return ScreenA3(
                      paramFromA2: paramA2,
                      message: state.extra as String?,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.sectionB,
      builder: (BuildContext context, GoRouterState state) {
        return SectionShellScreen(
          title: 'Section B',
          childPath: AppRoutes.screenB1,
          param: state.extra as String?,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.screenB1, // Full path: /b/b1
          builder: (BuildContext context, GoRouterState state) {
            return ScreenB1(message: state.extra as String?);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '${AppRoutes.screenB2}/:paramB2',
              // Full path: /b/b1/b2/:paramB2
              builder: (BuildContext context, GoRouterState state) {
                final paramB2 = state.pathParameters['paramB2']!;
                return ScreenB2(
                  paramB2: paramB2,
                  extraMessage: state.extra as String?,
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.screenB3, // Full path: /b/b1/b2/:paramB2/b3
                  builder: (BuildContext context, GoRouterState state) {
                    final paramB2 = state.pathParameters['paramB2']!;
                    return ScreenB3(
                      paramFromB2: paramB2,
                      message: state.extra as String?,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
  // --- Error handling (optional but recommended) ---
  errorBuilder: (context, state) => ErrorScreen(error: state.error),
);

void main() {
  // It's good practice to initialize GetX bindings if you have global services
  // For this example, we'll keep it simple.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use GetMaterialApp for GetX features, integrating GoRouter explicitly
    return GetMaterialApp.router(
      title: 'Flutter GetX GoRouter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 3,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      // Explicitly provide the router components to GetMaterialApp.router
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      backButtonDispatcher:
          _router.backButtonDispatcher, // Optional: manage back button behavior
    );
  }
}

// --- GetX Controllers (Example) ---
// This would typically be in a separate file e.g., 'home_controller.dart'
class SimpleScreenController extends GetxController {
  final String screenName;
  final RxString message = "Initial Message".obs;
  final RxInt counter = 0.obs;

  SimpleScreenController(this.screenName);

  void increment() {
    counter.value++;
    message.value = "$screenName Counter: ${counter.value}";
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint("$screenName Controller Initialized");
  }

  @override
  void onClose() {
    debugPrint("$screenName Controller Closed");
    super.onClose();
  }
}

// --- Screen Widgets ---
// These would typically be in separate files under a 'screens' or 'features' directory.

// Base Screen for consistent styling
class BaseScreen extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String? currentPath;

  const BaseScreen({
    super.key,
    required this.title,
    required this.children,
    this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading:
            GoRouter.of(context).canPop()
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => GoRouter.of(context).pop(),
                )
                : null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (currentPath != null)
                  Card(
                    color: Colors.deepPurple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Current Path: $currentPath',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                ...children.map(
                  (child) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: child,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example of initializing a GetX controller for this screen
    // Get.lazyPut(() => SimpleScreenController("Home")); // Or Get.put()
    // final SimpleScreenController controller = Get.find();

    return BaseScreen(
      title: 'Home Screen',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        const Text(
          'Welcome! Choose a section to explore.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to Section A, optionally pass 'extra' data
            context.go(
              AppRoutes.sectionA,
              extra: 'Hello from Home to Section A!',
            );
          },
          child: const Text('Go to Section A'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navigate to Section B
            context.go(AppRoutes.sectionB, extra: 'Greetings to Section B!');
          },
          child: const Text('Go to Section B'),
        ),
        // Obx(() => Text(controller.message.value)),
        // ElevatedButton(onPressed: controller.increment, child: Text("Increment Home Counter")),
      ],
    );
  }
}

// A generic shell for sections if needed, or just use the first screen of a section.
class SectionShellScreen extends StatelessWidget {
  final String title;
  final String childPath; // e.g. 'a1' or 'b1'
  final String? param; // Example of receiving 'extra'

  const SectionShellScreen({
    super.key,
    required this.title,
    required this.childPath,
    this.param,
  });

  @override
  Widget build(BuildContext context) {
    // Construct the full path for the first child screen
    String fullChildPath =
        '${GoRouterState.of(context).matchedLocation}/$childPath';

    return BaseScreen(
      title: title,
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'This is the main screen for $title.',
          style: const TextStyle(fontSize: 16),
        ),
        if (param != null)
          Text(
            'Received param: "$param"',
            style: const TextStyle(color: Colors.green, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to the first actual screen of this section
            context.go(fullChildPath, extra: 'Navigating to $childPath');
          },
          child: Text('Go to Screen $childPath'),
        ),
      ],
    );
  }
}

// --- Screens for Section A ---
class ScreenA1 extends StatelessWidget {
  final String? message; // Parameter received via 'extra'
  const ScreenA1({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A1"), tag: "A1");
    final SimpleScreenController controller = Get.find(tag: "A1");

    return BaseScreen(
      title: 'Screen A1',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A1 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to Screen A2, passing a path parameter and 'extra'
            String paramForA2 = "paramForA2_from_A1";
            context.go(
              AppRoutes.pathScreenA2(paramForA2),
              extra: 'Data for A2',
            );
          },
          child: const Text('Go to Screen A2 (with param)'),
        ),
      ],
    );
  }
}

class ScreenA2 extends StatelessWidget {
  final String paramA2; // Parameter from path
  final String? extraMessage; // Parameter from 'extra'
  const ScreenA2({super.key, required this.paramA2, this.extraMessage});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A2"), tag: "A2");
    final SimpleScreenController controller = Get.find(tag: "A2");

    return BaseScreen(
      title: 'Screen A2',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Received Path Parameter for A2: "$paramA2"',
          style: const TextStyle(color: Colors.orange, fontSize: 16),
        ),
        if (extraMessage != null)
          Text(
            'Extra Message: "$extraMessage"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A2 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to Screen A3
            // The paramA2 is already part of the path context for A3
            context.go(AppRoutes.pathScreenA3(paramA2), extra: 'Hello A3!');
          },
          child: const Text('Go to Screen A3'),
        ),
      ],
    );
  }
}

class ScreenA3 extends StatelessWidget {
  final String
  paramFromA2; // Parameter from A2's path, implicitly part of A3's context
  final String? message;

  const ScreenA3({super.key, required this.paramFromA2, this.message});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SimpleScreenController("A3"), tag: "A3");
    final SimpleScreenController controller = Get.find(tag: "A3");

    return BaseScreen(
      title: 'Screen A3',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Deepest Screen in Section A.',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Parameter from A2 context: "$paramFromA2"',
          style: const TextStyle(color: Colors.purple, fontSize: 16),
        ),
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.blueAccent, fontSize: 16),
          ),
        const SizedBox(height: 10),
        Obx(() => Text(controller.message.value, textAlign: TextAlign.center)),
        ElevatedButton(
          onPressed: controller.increment,
          child: const Text("Increment A3 Counter"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          onPressed: () {
            // Navigate to Screen B2 (different branch)
            // We need to provide the required path parameter for B2
            String paramForB2 = "param_from_A3_for_B2";
            context.go(
              AppRoutes.pathScreenB2(paramForB2),
              extra: 'Jumped from A3 to B2!',
            );
          },
          child: const Text('Go to Screen B2 (Cross-Branch)'),
        ),
      ],
    );
  }
}

// --- Screens for Section B ---
class ScreenB1 extends StatelessWidget {
  final String? message;

  const ScreenB1({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B1',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            String paramForB2 = "paramForB2_from_B1";
            context.go(AppRoutes.pathScreenB2(paramForB2), extra: 'Hi B2');
          },
          child: const Text('Go to Screen B2 (with param)'),
        ),
      ],
    );
  }
}

class ScreenB2 extends StatelessWidget {
  final String paramB2;
  final String? extraMessage;

  const ScreenB2({super.key, required this.paramB2, this.extraMessage});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B2',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Received Path Parameter for B2: "$paramB2"',
          style: const TextStyle(color: Colors.redAccent, fontSize: 16),
        ),
        if (extraMessage != null)
          Text(
            'Extra Message: "$extraMessage"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.go(AppRoutes.pathScreenB3(paramB2));
          },
          child: const Text('Go to Screen B3'),
        ),
      ],
    );
  }
}

class ScreenB3 extends StatelessWidget {
  final String paramFromB2;
  final String? message;

  const ScreenB3({super.key, required this.paramFromB2, this.message});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Screen B3',
      currentPath: GoRouterState.of(context).uri.toString(),
      children: [
        Text(
          'Deepest Screen in Section B.',
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          'Parameter from B2 context: "$paramFromB2"',
          style: const TextStyle(color: Colors.pink, fontSize: 16),
        ),
        if (message != null)
          Text(
            'Message: "$message"',
            style: const TextStyle(color: Colors.cyan, fontSize: 16),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent),
          onPressed: () {
            // Navigate to Screen A2 (different branch)
            String paramForA2 = "param_from_B3_for_A2";
            context.go(
              AppRoutes.pathScreenA2(paramForA2),
              extra: 'Jumped from B3 to A2!',
            );
          },
          child: const Text('Go to Screen A2 (Cross-Branch)'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
          onPressed: () {
            // Navigate to Home
            context.go(AppRoutes.home);
          },
          child: const Text('Go to Home Screen'),
        ),
      ],
    );
  }
}

// --- Error Screen ---
class ErrorScreen extends StatelessWidget {
  final Exception? error;

  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page Not Found")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Oops, something went wrong or the page doesn't exist.",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            if (error != null)
              Text(error.toString(), style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
