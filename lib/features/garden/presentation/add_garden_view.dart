import 'package:flutter/material.dart';
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
import '../../user/data/user_providers.dart';
import '../../user/domain/user.dart';
import '../../user/domain/user_collection.dart';
import '../data/garden_database.dart';
import '../data/garden_provider.dart';
import '../domain/garden.dart';
import '../domain/garden_collection.dart';
import 'gardens_view.dart';

/// Builds a page containing a form for creation of a new [Garden].
class AddGardenView extends ConsumerStatefulWidget {
  const AddGardenView({Key? key}) : super(key: key);

  static const routeName = '/addGardenView';

  @override
  createState() => _AddGardenViewState();
}

class _AddGardenViewState extends ConsumerState<AddGardenView> {
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
    List<String> chapterNames() => chapterCollection.getChapterNames();

    validateUserNamesString(String val) {
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

    void addGarden(
        {required String name,
        required String description,
        required String imageFileName,
        required String chapterID,
        required String ownerID,
        required List<String> viewerIDs,
        required List<String> editorIDs,
        required numGardens}) {
      // TODO: Address possible race condition on next line.
      // If 2 users create a garden "simultaneously", the second user will
      // overwrite the first user's document (since the garden ID will be
      // the same.) The two adds have to happen in less than a second or so,
      // before the local list of gardens is reactively updated So, highly
      // unlikely, but still possible.
      String id = 'garden-${(numGardens + 1).toString().padLeft(3, '0')}';
      String imagePath = 'assets/images/$imageFileName';
      String lastUpdate = DateFormat.yMd().format(DateTime.now());
      Garden garden = Garden(
          id: id,
          name: name,
          description: description,
          imagePath: imagePath,
          chapterID: chapterID,
          lastUpdate: lastUpdate,
          ownerID: ownerID,
          viewerIDs: viewerIDs,
          editorIDs: editorIDs);
      GardenDatabase gardenDatabase = ref.watch(gardenDatabaseProvider);
      gardenDatabase.setGarden(garden);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Garden'),
          actions: const [HelpButton(routeName: AddGardenView.routeName)],
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
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          hintText: 'Example: "Rosebud Garden"',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'description',
                        key: _descriptionFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Example: "19 Beds, 162 Plantings (2022)"',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      FormBuilderDropdown<String>(
                        // autovalidate: true,
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
                        valueTransformer: (val) => val?.toString(),
                      ),
                      FormBuilderTextField(
                        name: 'photo',
                        key: _photoFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Photo',
                          hintText: 'garden-004.jpg (or garden-005.jpg)',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      FormBuilderTextField(
                        name: 'editors',
                        key: _editorsFieldKey,
                        decoration: const InputDecoration(
                          labelText: 'Editor(s)',
                          hintText:
                              'An optional, comma separated list of usernames.',
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
                        decoration: const InputDecoration(
                          labelText: 'Viewer(s)',
                          hintText:
                              'An optional, comma separated list of usernames.',
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
                            String imageFileName =
                                _photoFieldKey.currentState?.value;
                            String editorsString =
                                _editorsFieldKey.currentState?.value ?? '';
                            List<String> editorIDs =
                                usernamesToIDs(editorsString);
                            String viewersString =
                                _viewersFieldKey.currentState?.value ?? '';
                            List<String> viewerIDs =
                                usernamesToIDs(viewersString);
                            addGarden(
                              name: name,
                              description: description,
                              chapterID: chapterID,
                              imageFileName: imageFileName,
                              editorIDs: editorIDs,
                              ownerID: currentUserID,
                              viewerIDs: viewerIDs,
                              numGardens: gardenCollection.size(),
                            );
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
