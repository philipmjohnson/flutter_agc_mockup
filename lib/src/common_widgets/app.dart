import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/presentation/signin_view.dart';
import '../features/authentication/presentation/signup_view.dart';
import '../features/chapter/presentation/chapters_view.dart';
import '../features/discussion/presentation/discussions_view.dart';
import '../features/garden/presentation/add_garden_view.dart';
import '../features/garden/presentation/edit_garden_view.dart';
import '../features/garden/presentation/gardens_view.dart';
import '../features/help/presentation/help_view.dart';
import '../features/help/presentation/help_view_local.dart';
import '../features/outcome/presentation/outcomes_view.dart';
import '../features/sample_feature/presentation/sample_item_details_view.dart';
import '../features/seed/presentation/seeds_view.dart';
import '../features/settings/application/settings_db.dart';
import '../features/settings/presentation/settings_view.dart';
import '../features/user/presentation/users_view.dart';
import 'home_view.dart';
import 'page_not_found_view.dart';

/// Top-level widget that implements routing to the appropriate page.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
                return const SettingsView();
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
