import 'package:flutter/material.dart';
import '../../../common_widgets/mockup_markdown.dart';

const pageSpecification = '''
# Help Page Specification

## Motivation/Goals

We need a way for folks to obtain help when they don't understand a feature of the app.

Help can occur in a variety of ways:

* When the user registers, we could have some onboarding screens to help them understand the major features of the app.

* At the top of various pages, we can have dismissable documentation boxes that explain the contents of the page. 

* Lastly, there is this dedicated page.  

We probably also want a Discord server.

Note that folks will probably use this in two ways:

* Help with the app.
* Help with gardening problems.

## Contents 

* FAQ

* Maybe a special section of the "Discussion Board" devoted to help?


## Actions 

* Ask a new question. 
* Answer a posted question.

''';



/// Displays Help information.
class HelpView extends StatelessWidget {
  const HelpView({
    super.key,
  });
  final String title = 'Help';
  static const routeName = '/help';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
