import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/pages/chapters/chapters_view.dart';
import 'package:flutter_agc_mockup/src/pages/discussions/discussions_view.dart';
import 'package:flutter_agc_mockup/src/pages/gardens/gardens_view.dart';
import 'package:flutter_agc_mockup/src/pages/help/help_view.dart';
import 'package:flutter_agc_mockup/src/pages/home/home_view.dart';
import 'package:flutter_agc_mockup/src/pages/members/members_view.dart';
import 'package:flutter_agc_mockup/src/pages/outcomes/outcomes_view.dart';
import 'package:flutter_agc_mockup/src/pages/page_not_found/page_not_found_view.dart';
import 'package:flutter_agc_mockup/src/pages/seeds/seeds_view.dart';
import 'package:flutter_agc_mockup/src/pages/signin/signin_view.dart';
import 'package:flutter_agc_mockup/src/pages/signup/signup_view.dart';
import 'pages/sample_feature/sample_item_details_view.dart';
import 'pages/sample_feature/sample_item_list_view.dart';
import 'pages/settings/settings_controller.dart';
import 'pages/settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp(
      {super.key, required this.settingsController, required this.theme});

  final SettingsController settingsController;
  final ThemeData theme;

  final theme2 =
      ThemeData(colorSchemeSeed: const Color(0xFF33691e), useMaterial3: true);

  @override
  Widget build(BuildContext context) {
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: theme, // or could be theme
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
                  case HomeView.routeName:
                    return HomeView();
                  case GardensView.routeName:
                    return GardensView();
                  case ChaptersView.routeName:
                    return ChaptersView();
                  case OutcomesView.routeName:
                    return OutcomesView();
                  case SeedsView.routeName:
                    return SeedsView();
                  case MembersView.routeName:
                    return MembersView();
                  case DiscussionsView.routeName:
                    return DiscussionsView();
                  case HelpView.routeName:
                    return HelpView();
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case SigninView.routeName:
                    return const SampleItemDetailsView();
                  default:
                    return const PageNotFoundView();
                }
              },
            );
          },
        );
      },
    );
  }
}
