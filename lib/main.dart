import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routers/app_router.dart';
import 'theme/colors.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('fr', 'FR'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
      startLocale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      assetLoader: const RootBundleAssetLoader(),
      useFallbackTranslations: true,
      child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RITCO',
      theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSeed(seedColor: primarySwatch),
          primaryColor: primarySwatch,
          scaffoldBackgroundColor: scaffold,
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.black87)),
          cardTheme: CardTheme(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          bottomSheetTheme: const BottomSheetThemeData(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primarySwatch),
            padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32))),
            elevation: MaterialStateProperty.all(0),
          )),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 17),
            fillColor: fieldsBackground,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: fieldsBorder), // Set the default border color to grey
              borderRadius: BorderRadius.circular(3),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: fieldsBorder), // Set the focused border color to grey
              borderRadius: BorderRadius.circular(1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: fieldsBorder), // Set the enabled border color to grey
              borderRadius: BorderRadius.circular(1),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: fieldsBorder), // Set the error border color to red
              borderRadius: BorderRadius.circular(1),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey
                      .shade400), // Set the disabled border color to light grey
              borderRadius: BorderRadius.circular(1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.red), // Set the focused error border color to red
              borderRadius: BorderRadius.circular(1),
            ),
          ),
          dialogTheme: DialogTheme(
            elevation: 0,
            backgroundColor: Colors.white, // Set your desired background color
            // titleTextStyle: TextStyle(color: Colors.white), // Set title text color
            // contentTextStyle: TextStyle(color: Colors.white), // Set content text color
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10.0), // Set dialog border radius
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  textStyle: const TextStyle(color: primarySwatch),
                  foregroundColor: primarySwatch,
                  side: const BorderSide(color: primarySwatch),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32))))),
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: ref.watch(localeProvider),
    );
  }
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final document = await path_provider.getApplicationDocumentsDirectory();
//
//   await EasyLocalization.ensureInitialized();
//   // Hive.init(document.path);
//   //
//   // Hive.registerAdapter(UserProfileAdapter());
//   //
//   // Hive.registerAdapter(CompanyModelAdapter());
//   //
//   // await Hive.openBox(userProfileBoxName);
//   // await Hive.openBox(currentCompanyBoxName);
//
//   runApp(EasyLocalization(
//       startLocale: const Locale('fr', 'FR'),
//       fallbackLocale: const Locale('en', 'US'),
//       path: 'assets/translations',
//       assetLoader: const RootBundleAssetLoader(),
//       useFallbackTranslations: true,
//       supportedLocales: const [Locale('fr', 'FR'), Locale('en', 'US')],
//       child: const ProviderScope(child: MyApp())));
// }
//
// class MyApp extends ConsumerStatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends ConsumerState<MyApp> {
//   var mode = ThemeMode.system;
//   @override
//   Widget build(BuildContext context) {
//     var modes = ref.watch(modeProvider);
//     return MaterialApp.router(
//       theme: ThemeData(primarySwatch: Colors.green),
//       darkTheme: ThemeData.dark(),
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       themeMode: modes ?? mode,
//       debugShowCheckedModeBanner: false,
//       title: 'KudiBooks',
//       routerDelegate: router.routerDelegate,
//       routeInformationParser: router.routeInformationParser,
//       routeInformationProvider: router.routeInformationProvider,
//     );
//   }
// }
