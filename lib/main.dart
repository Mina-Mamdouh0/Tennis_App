import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tennis_app/Auth/cubit/auth_cubit.dart';
import 'package:tennis_app/core/utils/app_router.dart';
import 'package:tennis_app/core/utils/widgets/input_date.dart';

import 'Main-Features/Featured/create_club/view/widgets/Age_restriction.dart';
import 'Main-Features/Featured/create_club/view/widgets/club_type.dart';
import 'Main-Features/Featured/create_event/cubit/create_event_cubit.dart';
import 'Main-Features/Featured/create_event/view/widgets/input_end_date.dart';
import 'Main-Features/Featured/create_event/view/widgets/player_level.dart';
import 'Main-Features/Featured/create_profile/cubits/Gender_Cubit.dart';
import 'Main-Features/Featured/create_profile/cubits/player_type_cubit.dart';
import 'Main-Features/Featured/create_profile/cubits/time_cubit.dart';
import 'Main-Features/Featured/set_reminder/model/evenet_data.dart';
import 'core/utils/widgets/input_date_and_time.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  // Add this method to load the selected locale from shared preferences
  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('selected_locale');
    if (localeCode != null) {
      setState(() {
        _locale = Locale(localeCode);
      });
    }
  }

  // Add this method to save the selected locale to shared preferences
  Future<void> _saveLocale(String localeCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', localeCode);
  }

  void setLocale(Locale newLocale) {
    _saveLocale(newLocale.languageCode); // Save the selected locale
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLocale(); // Load the selected locale when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<GenderCubit>(
          create: (context) => GenderCubit(),
        ),
        BlocProvider(
          create: (context) => TimeCubit(),
        ),
        BlocProvider(
          create: (context) => DateCubit(),
        ),
        BlocProvider(
          create: (context) => PlayerTypeCubit(),
        ),
        BlocProvider(
          create: (context) => ClubTypeCubit(),
        ),
        BlocProvider(
          create: (context) => AgeRestrictionCubit(),
        ),
        BlocProvider<EndDateTimeCubit>(
          create: (context) => EndDateTimeCubit(),
        ),
        BlocProvider(
          create: (context) => DateTimeCubit(),
        ),
        BlocProvider(
          create: (context) => CreateEventCubit(context),
        ),
        BlocProvider<SliderCubit>(create: (_) => SliderCubit()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        builder: DevicePreview.appBuilder,
        locale: _locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        ),
      ),
    );
  }
}
