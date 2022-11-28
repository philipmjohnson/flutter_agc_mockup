import 'package:flutter/material.dart';
import '../mockup_markdown/mockup_markdown.dart';

const pageSpecification = '''
# Members Page Specification

## Motivation/Goals

We want this page to facilitate the creation of a local "Community of Practice".

On the other hand, we want to preserve privacy. 

So, we will need to ability for members to manage how much of their information is made available to others. 

## Contents

Since people can be part of more than one Chapter, we might have to have a top-level card or maybe an expandable card? 

It should list the "public profile" for a member, which could include their username, the gardens they own, maybe something about their crops.  

## Actions 

It should be possible to message members.  This seems crucial to create a community of practice.

If folks can be messaged, then it should also be possible for a member to block messages from another person. 

Maybe you can request "messaging privilege" or something from another member, so by default you can't message others? 

''';



/// Displays Chapter information.
class MembersView extends StatelessWidget {
  const MembersView({
    super.key,
  });
  final String title = 'Members';
  static const routeName = '/members';


  @override
  Widget build(BuildContext context) {
    return MockupMarkdownView(title: title, data: pageSpecification);
  }
}
