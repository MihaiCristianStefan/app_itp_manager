// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(SMS) => "Sent SMS ${SMS}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "carPlates": MessageLookupByLibrary.simpleMessage("Car plates"),
        "createCustomer":
            MessageLookupByLibrary.simpleMessage("Create customer"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "editCustomer": MessageLookupByLibrary.simpleMessage("Edit customer"),
        "lastITP": MessageLookupByLibrary.simpleMessage("Last ITP"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "nextITP": MessageLookupByLibrary.simpleMessage("Next ITP"),
        "oneYear": MessageLookupByLibrary.simpleMessage("1 year"),
        "phone": MessageLookupByLibrary.simpleMessage("Phone"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "sendSMS": MessageLookupByLibrary.simpleMessage("Send SMS"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6 months"),
        "snackBarMsg": m0,
        "twoYears": MessageLookupByLibrary.simpleMessage("2 years"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "wrongFormat": MessageLookupByLibrary.simpleMessage("Wrong format")
      };
}
