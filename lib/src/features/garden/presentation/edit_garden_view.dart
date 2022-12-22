import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../chapter/application/chapter_provider.dart';
import '../../chapter/domain/chapter_db.dart';
import '../../help/presentation/help_button.dart';
import '../../user/application/user_providers.dart';
import '../../user/domain/user_db.dart';
import '../application/garden_provider.dart';
import '../domain/garden_db.dart';
import 'gardens_view.dart';

/// Provides the page enabling the user to edit the data associated with an existing Garden.
class EditGardenView extends ConsumerWidget {
  EditGardenView({Key? key}) : super(key: key);

  static const routeName = '/editGardenView';
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameFieldKey = GlobalKey<FormBuilderFieldState>();
  final _descriptionFieldKey = GlobalKey<FormBuilderFieldState>();
  final _chapterFieldKey = GlobalKey<FormBuilderFieldState>();
  final _photoFieldKey = GlobalKey<FormBuilderFieldState>();
  final _editorsFieldKey = GlobalKey<FormBuilderFieldState>();
  final _viewersFieldKey = GlobalKey<FormBuilderFieldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChapterDB chapterDB = ref.watch(chapterDBProvider);
    final UserDB userDB = ref.watch(userDBProvider);
    final GardenDB gardenDB = ref.watch(gardenDBProvider);
    final String currentUserID = ref.watch(currentUserIDProvider);
    String gardenID = ModalRoute.of(context)!.settings.arguments as String;
    GardenData gardenData = gardenDB.getGarden(gardenID);
    List<String> chapterNames = chapterDB.getChapterNames();
    String currChapterName = chapterDB.getChapter(gardenData.chapterID).name;
    String currEditors = gardenData.editorIDs
        .map((userID) => userDB.getUser(userID).username)
        .toList()
        .join(', ');
    String currViewers = gardenData.viewerIDs
        .map((userID) => userDB.getUser(userID).username)
        .toList()
        .join(', ');

    validateUserNamesString(String val) {
      List<String> userNames = val.split(',').map((val) => val.trim()).toList();
      if (!userDB.areUserNames(userNames)) {
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
      return usernames.map((username) => userDB.getUserID(username)).toList();
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
                        initialValue: gardenData.name,
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
                        initialValue: gardenData.description,
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
                        items: chapterNames
                            .map((name) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: name,
                                  child: Text(name),
                                ))
                            .toList(),
                        initialValue: currChapterName,
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
                        initialValue: gardenData.imagePath,
                      ),
                      FormBuilderTextField(
                        name: 'editors',
                        key: _editorsFieldKey,
                        initialValue: currEditors,
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
                        initialValue: currViewers,
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
                            String chapterID = chapterDB.getChapterIDFromName(
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
                            // Add the new garden.
                            gardenDB.updateGarden(
                                id: gardenID,
                                name: name,
                                description: description,
                                chapterID: chapterID,
                                imagePath: imagePath,
                                editorIDs: editorIDs,
                                ownerID: currentUserID,
                                viewerIDs: viewerIDs);
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
