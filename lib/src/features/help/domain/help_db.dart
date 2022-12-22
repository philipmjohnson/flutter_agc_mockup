import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/home_view.dart';
import '../../chapter/presentation/chapters_view.dart';
import '../../user/presentation/users_view.dart';

/// Provides a help string (if available) for each page.
/// Pages are identified by their routeName because that's guaranteed to be unique.
class HelpDB {
  HelpDB(this.ref);
  final ProviderRef<HelpDB> ref;
  final Map<String, String> _helpMap = {
    HomeView.routeName: '''
# About the Home Page

Your home page provides information about "what's new" in your Garden(s) and Chapter(s), as well as quick access to frequently used pages.

## My News

The "My News" subsection provides alerts of recent occurrences.  You can tap each one for more details, or swipe right to remove the alert from this Home View.

## My Gardens

The "My Gardens" subsection provides cards with summaries for each Garden that you own, or have Editor or Viewer access.  Tap a Garden card to go to details on the garden, or swipe right if you want to remove this garden (i.e. delete it if you are the owner, or remove your access to it if you are an editor or viewer).

## My Discussions

The "My Discussions" subsection provides summaries for each Discussion that you are currently participating in (or is a new Discussion).  Tap the card to go to the discussion, or else swipe right to remove it from this Home View. 
        ''',
    UsersView.routeName: '''
# About the Members Page.

This page provides a list of all of the Members in the Chapters associated with your Gardens.         

It also includes your listing, so you can see how your information appears in the public directory.

The buttons at the bottom enable you to filter or sort the list of members. 
        ''',
    ChaptersView.routeName: '''
# About the Chapters Page.

This page provides a list of all of the Chapters with which you have membership.        

You become a member of a Chapter by being associated with a garden in that Chapter as an owner, editor, or viewer.

Most people will only be a member of a single Chapter.

The buttons at the bottom enable you to filter or sort the list of Chapters. 
        ''',
  };

  String getHelpString(String routeName) {
    return (_helpMap.containsKey(routeName)
        ? _helpMap[routeName]!
        : 'No help available');
  }
}
