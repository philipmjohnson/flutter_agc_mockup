import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chapter/domain/chapter.dart';
import 'garden/domain/garden.dart';
import 'news/domain/news.dart';
import 'user/domain/user.dart';

/// MultiAsyncValuesWidget simplifies the implementation of widgets that must wait
/// until multiple asynchronous requests have completed before building the view.
///
/// Consider the following scenario. Your domain model involves four collections,
/// A, B, C, and D.  One widget requires documents from A and B. Another requires documents
/// from A, B, C, and D. Yet another requires documents from B and C.  You want a way
/// to implement your widgets so that there is a (relatively) simple and consistent
/// way to obtain documents from any combination of collections, while hiding as
/// much as possible the details of asynchronicity (i.e. displaying the
/// [CircularProgressIndicator] while awaiting all of the requests to complete,
/// and showing errors if they occur).
///
/// After a lot of googling and conversations with ChatGPT, I failed to find a
/// pre-existing solution. The closest I got was AsyncValueWidget from Code
/// With Andrea, which only handles a single collection, but which gave me the
/// idea for how to support multiple collections.
///
/// Due to Dart's strong typing, and due to my lack of experience with Dart's
/// generics, I did not attempt a generic solution. Instead, I created a bespoke
/// class that builds in knowledge of the domain data types of interest. So, minor
/// modifications are needed to adapt this code to new contexts.
///
/// You use MultiAsyncValuesWidget in your build() method by first obtaining
/// the Riverpod StreamProvider or FutureProvider that accesses your Firebase
/// collection and the desired documents within it. These providers return an
/// [AsyncValue] that can be passed to MultiAsyncValuesWidget. You also pass a
/// function that will be called when all of the AsyncValues have values. I find
/// it most readable to not pass an anonymous function, but rather to explicitly
/// create a method called _build which is called with the values.  For example:
/// ```dart
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     final String currentUserID = ref.watch(currentUserIDProvider);
///     final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
///     final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
///     final AsyncValue<List<User>> asyncUsers = ref.watch(usersProvider);
///     return MultiAsyncValuesWidget(
///         context: context,
///         currentUserID: currentUserID,
///         asyncChapters: asyncChapters,
///         asyncGardens: asyncGardens,
///         asyncUsers: asyncUsers,
///         data: _build);
///   }
///
///   Widget _build(
///       {required BuildContext context,
///       required String currentUserID,
///       List<Chapter>? chapters,
///       List<Garden>? gardens,
///       List<News>? news,
///       List<User>? users}) {
///     ChapterCollection chapterCollection = ChapterCollection(chapters);
///     GardenCollection gardenCollection = GardenCollection(gardens);
///     UserCollection userCollection = UserCollection(users);
///     return Scaffold( ... );
/// ```
/// Thus, your build() method gets whatever combination of AsyncValues needed,
/// and the _build method does the actual UI generation. In this example, no
/// documents from the News collection are needed for this widget.
///
/// Note that MultiAsyncValuesWidget requires that you pass in the currentUserID
/// and the current context. These are passed through to the _build method, as
/// they are frequently (but not always) needed.
///
/// There are several things I don't like about this design. For example, the
/// _build method has to be a function with a parameter signature that specifies
/// all possible AsyncValue return values, regardless of whether it will actually
/// need them or not. Having the context and currentUserID parameters be required
/// is kind of funky because they aren't always needed, but making them optional
/// (or using an instance variable to pass them between build and _build) is
/// (arguably) more funky.  I have the gut feeling that there is a significantly
/// cleaner design to satisfy this use case. If you know of it, please let
/// me know.
class MultiAsyncValuesWidget extends StatelessWidget {
  const MultiAsyncValuesWidget(
      {super.key,
      required this.context,
      required this.currentUserID,
      this.asyncChapters = const AsyncValue.data(<Chapter>[]),
      this.asyncGardens = const AsyncValue.data(<Garden>[]),
      this.asyncNews = const AsyncValue.data(<News>[]),
      this.asyncUsers = const AsyncValue.data(<User>[]),
      required this.data});

  final BuildContext context;
  final String currentUserID;
  final AsyncValue<List<Chapter>> asyncChapters;
  final AsyncValue<List<Garden>> asyncGardens;
  final AsyncValue<List<News>> asyncNews;
  final AsyncValue<List<User>> asyncUsers;
  final Widget Function(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) data;

  @override
  Widget build(BuildContext context) {
    if (asyncChapters is AsyncError) {
      return Center(
          child: ErrorMessage(
        'Chapters',
        (asyncChapters as AsyncError).error.toString(),
        (asyncChapters as AsyncError).stackTrace.toString(),
      ));
    }
    if (asyncGardens is AsyncError) {
      return Center(
          child: ErrorMessage(
        'Gardens',
        (asyncGardens as AsyncError).error.toString(),
        (asyncGardens as AsyncError).stackTrace.toString(),
      ));
    }
    if (asyncNews is AsyncError) {
      return Center(
          child: ErrorMessage(
        'News',
        (asyncNews as AsyncError).error.toString(),
        (asyncNews as AsyncError).stackTrace.toString(),
      ));
    }
    if (asyncUsers is AsyncError) {
      return Center(
          child: ErrorMessage(
        'Users',
        (asyncUsers as AsyncError).error.toString(),
        (asyncUsers as AsyncError).stackTrace.toString(),
      ));
    }

    if ((asyncGardens.hasValue) &&
        (asyncChapters.hasValue) &&
        (asyncUsers.hasValue) &&
        (asyncNews.hasValue)) {
      return data(
          context: this.context,
          currentUserID: currentUserID,
          chapters: asyncChapters.value as List<Chapter>,
          gardens: asyncGardens.value as List<Garden>,
          news: asyncNews.value as List<News>,
          users: asyncUsers.value as List<User>);
    }
    return const Center(child: CircularProgressIndicator());
  }
}

/// Handle a single AsyncValue from Riverpod's [FutureProvider] or [StreamProvider].
/// Thanks: https://codewithandrea.com/articles/async-value-widget-riverpod/
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) =>
          Center(child: ErrorMessage('?', e.toString(), st.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(this.collection, this.errorMessage, this.stacktrace,
      {super.key});

  final String errorMessage;
  final String stacktrace;
  final String collection;

  @override
  Widget build(BuildContext context) {
    return Text(
        'Collection: $collection\nError: $errorMessage\nStack trace: $stacktrace',
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.white));
  }
}
