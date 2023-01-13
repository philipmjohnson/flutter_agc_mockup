import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' hide ForgotPasswordView;
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configuration.dart';
import 'features/authentication/presentation/forgot_password_view.dart';
import 'features/authentication/presentation/signin_view.dart';
import 'features/authentication/presentation/verify_email_view.dart';
import 'features/chapter/domain/chapter.dart';
import 'features/chapter/domain/chapter_db.dart';
import 'features/chapter/presentation/chapters_view.dart';
import 'features/discussion/presentation/discussions_view.dart';
import 'features/garden/domain/garden.dart';
import 'features/garden/domain/garden_db.dart';
import 'features/garden/presentation/add_garden_view.dart';
import 'features/garden/presentation/edit_garden_view.dart';
import 'features/garden/presentation/gardens_view.dart';
import 'features/help/presentation/help_view.dart';
import 'features/help/presentation/help_view_local.dart';
import 'features/home_view.dart';
import 'features/news/domain/news.dart';
import 'features/news/domain/news_db.dart';
import 'features/outcome/presentation/outcomes_view.dart';
import 'features/page_not_found_view.dart';
import 'features/sample_feature/presentation/sample_item_details_view.dart';
import 'features/seed/presentation/seeds_view.dart';
import 'features/settings/application/settings_db.dart';
import 'features/settings/presentation/settings_view.dart';
import 'features/user/domain/user.dart';
import 'features/user/domain/user_db.dart';
import 'features/user/presentation/users_view.dart';
import 'firebase_options.dart';
import 'logger.dart';

Future<bool> initializeDB() async {
  logger.i('Checking for DB initialization');
  List<Chapter> chapters = await ChapterDB.getInitialData();
  List<Garden> gardens = await GardenDB.getInitialData();
  List<News> news = await NewsDB.getInitialData();
  List<User> users = await UserDB.getInitialData();
  logger.i(users);
  return true;
}

/// Set up settings and wrap app in ProviderScope
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  await Configuration().load('config');
  await initializeDB();
  String admin = Configuration().get('config', 'admin_email');
  logger.i('Starting up. Admin: $admin');
  runApp(const ProviderScope(child: MyApp()));
}

/// Top-level widget that implements routing to the appropriate page.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: FlexThemeData.light(
          scheme: FlexScheme.gold,
          subThemesData: const FlexSubThemesData(
              inputDecoratorBorderType: FlexInputBorderType.outline)),
      darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.gold,
          subThemesData: const FlexSubThemesData(
              inputDecoratorBorderType: FlexInputBorderType.outline)),
      themeMode: ref.watch(currentThemeModeProvider),
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SignInView.routeName:
                return const SignInView();
              case VerifyEmailView.routeName:
                return const VerifyEmailView();
              case ForgotPasswordView.routeName:
                return const ForgotPasswordView();
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
