import 'package:flutter/material.dart';
import 'package:flutter_agc_mockup/features/user/data/user_providers.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../async_value_widget.dart';
import '../../chapter/data/chapter_provider.dart';
import '../../chapter/domain/chapter.dart';
import '../../chapter/domain/chapter_collection.dart';
import '../../help/presentation/help_button.dart';
import '../../news/domain/news.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import '../data/garden_database.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';
import 'gardens_view.dart';

/// Builds a page containing a form allowing editing of an existing [Garden].
class EditGardenView extends ConsumerStatefulWidget {
  const EditGardenView({Key? key}) : super(key: key);

  static const routeName = '/editGardenView';

  @override
  createState() => _EditGardenViewState();
}

class _EditGardenViewState extends ConsumerState<EditGardenView> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _chapterFieldKey = GlobalKey<FormBuilderFieldState>();
  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();
  final _editorsFieldKey = GlobalKey<FormBuilderFieldState>();
  final _viewersFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context) {
    final String currentUserID = ref.watch(currentUserIDProvider);
    final AsyncValue<List<Chapter>> asyncChapters = ref.watch(chaptersProvider);
    final AsyncValue<List<Garden>> asyncGardens = ref.watch(gardensProvider);
    final AsyncValue<List<User>> asyncUsers = ref.watch(usersProvider);
    return MultiAsyncValuesWidget(
        context: context,
        currentUserID: currentUserID,
        asyncChapters: asyncChapters,
        asyncGardens: asyncGardens,
        asyncUsers: asyncUsers,
        data: _build);
  }

  Widget _build(
      {required BuildContext context,
      required String currentUserID,
      List<Chapter>? chapters,
      List<Garden>? gardens,
      List<News>? news,
      List<User>? users}) {
    ChapterCollection chapterCollection = ChapterCollection(chapters);
    GardenCollection gardenCollection = GardenCollection(gardens);
    UserCollection userCollection = UserCollection(users);
    String gardenID = ModalRoute.of(context)!.settings.arguments as String;
    Garden garden = gardenCollection.getGarden(gardenID);
    List<String> chapterNames() => chapterCollection.getChapterNames();
    String currChapterName() =>
        chapterCollection.getChapter(garden.chapterID).name;
    String currEditors() => garden.editorIDs
        .map((userID) => userCollection.getUser(userID).username)
        .toList()
        .join(', ');
    String currViewers() => garden.viewerIDs
        .map((userID) => userCollection.getUser(userID).username)
        .toList()
        .join(', ');

    validateUserNamesString(String val) {
      if (val == '') {
        return null;
      }
      List<String> userNames = val.split(',').map((val) => val.trim()).toList();
      if (!userCollection.areUserNames(userNames)) {
        return 'Non-existent user name(s)';
      }
      return null;
    }

    List<String> usernamesToIDs(String usernamesString) {
      if (usernamesString.isEmpty) {
        return [];
      }
      List<String> usernames =
          usernamesString.split(',').map((editor) => editor.trim()).toList();
      return usernames
          .map((username) => userCollection.getUserID(username))
          .toList();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Garden'),
          actions: const [HelpButton(routeName: EditGardenView.routeName)],
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'name',
                        key: _nameFieldKey,
                        initialValue: garden.name,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'description',
                        initialValue: garden.description,
                        key: _descriptionFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      FormBuilderDropdown<String>(
                        name: 'chapter',
                        key: _chapterFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Chapter',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: chapterNames()
                            .map((name) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: name,
                                  child: Text(name),
                                ))
                            .toList(),
                        initialValue: currChapterName(),
                        valueTransformer: (val) => val?.toString(),
                      ),
                      FormBuilderTextField(
                        name: 'photo',
                        key: _photoFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Photo',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                        initialValue: garden.imagePath,
                      ),
                      FormBuilderTextField(
                        name: 'editors',
                        key: _editorsFieldKey,
                        initialValue: currEditors(),
                        decoration: const InputDecoration(
                          labelText: 'Editor(s)',
                        ),
                        validator: (val) {
                          if (val is String) {
                            return validateUserNamesString(val);
                          }
                          return null;
                        },
                      ),
                      FormBuilderTextField(
                        name: 'viewers',
                        key: _viewersFieldKey,
                        initialValue: currViewers(),
                        decoration: const InputDecoration(
                          labelText: 'Viewer(s)',
                        ),
                        validator: (val) {
                          if (val is String) {
                            return validateUserNamesString(val);
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          bool isValid =
                              _formKey.currentState?.saveAndValidate() ?? false;
                          if (isValid) {
                            // Extract garden data from fields
                            String name = _nameFieldKey.currentState?.value;
                            String description =
                                _descriptionFieldKey.currentState?.value;
                            String chapterID =
                                chapterCollection.getChapterIDFromName(
                                    _chapterFieldKey.currentState?.value);
                            String imagePath =
                                _photoFieldKey.currentState?.value;
                            String editorsString =
                                _editorsFieldKey.currentState?.value ?? '';
                            List<String> editorIDs =
                                usernamesToIDs(editorsString);
                            String viewersString =
                                _viewersFieldKey.currentState?.value ?? '';
                            List<String> viewerIDs =
                                usernamesToIDs(viewersString);
                            String lastUpdate =
                                DateFormat.yMd().format(DateTime.now());
                            Garden garden = Garden(
                                id: gardenID,
                                name: name,
                                description: description,
                                imagePath: imagePath,
                                chapterID: chapterID,
                                lastUpdate: lastUpdate,
                                ownerID: currentUserID,
                                viewerIDs: viewerIDs,
                                editorIDs: editorIDs);
                            GardenDatabase gardenDatabase =
                                ref.watch(gardenDatabaseProvider);
                            gardenDatabase.setGarden(garden);
                            // Return to the list gardens page
                            Navigator.pushReplacementNamed(
                                context, GardensView.routeName);
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        // color: Theme.of(context).colorScheme.secondary,
                        child: Text(
                          'Reset',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
