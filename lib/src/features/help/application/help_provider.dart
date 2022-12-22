import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/help_db.dart';

final helpDBProvider = Provider<HelpDB>((ref) {
  return HelpDB(ref);
});
