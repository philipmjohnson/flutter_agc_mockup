import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chapter/domain/chapter.dart';
import 'garden/domain/garden.dart';
import 'news/domain/news.dart';
import 'user/domain/user.dart';

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
