import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/home/home_layout_view.dart';
import 'package:flutter_agc_mockup/src/pages/list_gardens/list_gardens_view.dart';
import 'package:flutter_agc_mockup/src/pages/signin/signin_view.dart';
import 'package:flutter_agc_mockup/src/pages/signup/signup_view.dart';
import 'pages/sample_feature/sample_item_details_view.dart';
import 'pages/sample_feature/sample_item_list_view.dart';
import 'pages/settings/settings_controller.dart';
import 'pages/settings/settings_view.dart';
import 'theme/color_schemes.g.dart';


/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: settingsController.themeMode,

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SigninView.routeName:
                    return const SigninView();
                  case SignupView.routeName:
                    return const SignupView();
                  case HomeLayoutView.routeName:
                    return const HomeLayoutView();
                  case ListGardensView.routeName:
                    return const ListGardensView();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SigninView.routeName:
                    return const SampleItemDetailsView();
                  case SampleItemListView.routeName:
                  default:
                    return const SampleItemListView();
                }
              },
            );
          },
        );
      },
    );
  }
}
