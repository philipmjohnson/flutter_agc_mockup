import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/src/data_model/settings_db.dart';
import 'package:flutter_agc_mockup/src/pages/chapters/chapters_view.dart';
import 'package:flutter_agc_mockup/src/pages/discussions/discussions_view.dart';
import 'package:flutter_agc_mockup/src/pages/gardens/add_garden_view.dart';
import 'package:flutter_agc_mockup/src/pages/gardens/edit_garden_view.dart';
import 'package:flutter_agc_mockup/src/pages/gardens/gardens_view.dart';
import 'package:flutter_agc_mockup/src/pages/help/help_view.dart';
import 'package:flutter_agc_mockup/src/pages/help/help_view_local.dart';
import 'package:flutter_agc_mockup/src/pages/home/home_view.dart';
import 'package:flutter_agc_mockup/src/pages/users/users_view.dart';
import 'package:flutter_agc_mockup/src/pages/outcomes/outcomes_view.dart';
import 'package:flutter_agc_mockup/src/pages/page_not_found/page_not_found_view.dart';
import 'package:flutter_agc_mockup/src/pages/seeds/seeds_view.dart';
import 'package:flutter_agc_mockup/src/pages/signin/signin_view.dart';
import 'package:flutter_agc_mockup/src/pages/signup/signup_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/sample_feature/sample_item_details_view.dart';
import 'pages/settings/settings_view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

/// Top-level widget that implements routing to the appropriate page.
class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: FlexThemeData.light(scheme: FlexScheme.gold),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.gold),
      themeMode: ref.watch(currentThemeModeProvider),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SigninView.routeName:
                return SigninView();
              case SignupView.routeName:
                return const SignupView();
              case HomeView.routeName:
                return const HomeView();
              case GardensView.routeName:
                return const GardensView();
              case AddGardenView.routeName:
                return AddGardenView();
              case EditGardenView.routeName:
                return EditGardenView();
              case ChaptersView.routeName:
                return const ChaptersView();
              case OutcomesView.routeName:
                return const OutcomesView();
              case SeedsView.routeName:
                return const SeedsView();
              case UsersView.routeName:
                return const UsersView();
              case DiscussionsView.routeName:
                return const DiscussionsView();
              case HelpView.routeName:
                return const HelpView();
              case HelpViewLocal.routeName:
                return const HelpViewLocal();
              case SettingsView.routeName:
                return SettingsView();
              case SampleItemDetailsView.routeName:
                return const SampleItemDetailsView();
              default:
                return const PageNotFoundView();
            }
          },
        );
      },
    );
  }
}
