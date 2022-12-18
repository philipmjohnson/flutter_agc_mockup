import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../components/drawer_view.dart';
import '../../components/help_button.dart';
import '../../data_model/user_db.dart';

/// Presents the page containing fields to enter a username and password, plus buttons.
class AddGardenView extends ConsumerWidget {
  AddGardenView({Key? key}) : super(key: key);

  static const routeName = '/addGardenView';
  final _formKey = GlobalKey<FormBuilderState>();
  List<String> chapterOptions = ['chapter-001', 'chapter-002'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        decoration: const InputDecoration(
                          labelText: 'Chapter',
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: chapterOptions
                            .map((chapter) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: chapter,
                          child: Text(chapter),
                        ))
                            .toList(),
                        valueTransformer: (val) => val?.toString(),
                      ),
                      FormBuilderTextField(
                        name: 'photo',
                        decoration: const InputDecoration(
                          labelText: 'Photo',
                          hintText: 'A file name in the assets/images directory',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      FormBuilderTextField(
                        name: 'editors',
                        decoration: const InputDecoration(
                          labelText: 'Editor(s)',
                          hintText: 'An optional, comma separated list of usernames.',
                        ),
                      ),
                      FormBuilderTextField(
                        name: 'viewers',
                        decoration: const InputDecoration(
                          labelText: 'Viewer(s)',
                          hintText: 'An optional, comma separated list of usernames.',
                        ),
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
                          bool isValid = _formKey.currentState?.saveAndValidate() ?? false;
                          if (isValid) {
                            debugPrint(_formKey.currentState?.value.toString());
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
