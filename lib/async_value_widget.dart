import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/chapter/domain/chapter.dart';
import 'features/garden/domain/garden.dart';
import 'features/news/domain/news.dart';
import 'features/user/domain/user.dart';

class AsyncValuesAGCWidget extends StatelessWidget {
  const AsyncValuesAGCWidget(
      {super.key,
      this.currentUserID = '',
      this.asyncChapters = const AsyncValue.data([]),
      this.asyncGardens = const AsyncValue.data([]),
      this.asyncNews = const AsyncValue.data([]),
      this.asyncUsers = const AsyncValue.data([]),
      required this.data});

  final String currentUserID;
  final AsyncValue<List<Chapter>> asyncChapters;
  final AsyncValue<List<Garden>> asyncGardens;
  final AsyncValue<List<News>> asyncNews;
  final AsyncValue<List<User>> asyncUsers;
  final Widget Function(
      {String? currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) data;

  @override
  Widget build(BuildContext context) {
    if (asyncChapters is AsyncError) {
      return Center(
          child: ErrorMessage((asyncChapters as AsyncError).error.toString()));
    }
    if (asyncGardens is AsyncError) {
      return Center(
          child: ErrorMessage((asyncGardens as AsyncError).error.toString()));
    }
    if (asyncNews is AsyncError) {
      return Center(
          child: ErrorMessage((asyncNews as AsyncError).error.toString()));
    }
    if (asyncUsers is AsyncError) {
      return Center(
          child: ErrorMessage((asyncUsers as AsyncError).error.toString()));
    }
    if ((asyncGardens is AsyncLoading) ||
        (asyncChapters is AsyncLoading) ||
        (asyncUsers is AsyncLoading) ||
        (asyncNews is AsyncLoading)) {
      return const Center(child: CircularProgressIndicator());
    }
    return data(
        currentUserID: currentUserID,
        chapters: asyncChapters.value,
        gardens: asyncGardens.value,
        news: asyncNews.value,
        users: asyncUsers.value);
  }
}

/// Handle AsyncValues from Riverpod's [FutureProvider] or [StreamProvider].
/// Thanks: https://codewithandrea.com/articles/async-value-widget-riverpod/
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Center(child: ErrorMessage(e.toString())),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class ScaffoldAsyncValueWidget<T> extends StatelessWidget {
  const ScaffoldAsyncValueWidget(
      {super.key, required this.value, required this.data});

  final AsyncValue<T> value;
  final Widget Function(T) data;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) => Scaffold(
        appBar: AppBar(),
        body: Center(child: ErrorMessage(e.toString())),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage(this.errorMessage, {super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorMessage,
      style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),
    );
  }
}
