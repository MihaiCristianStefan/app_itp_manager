// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ro locale. All the
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
  String get localeName => 'ro';

  static String m0(SMS) => "SMS trimise ${SMS}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cancel": MessageLookupByLibrary.simpleMessage("Anuleaza"),
        "carPlates": MessageLookupByLibrary.simpleMessage("Nr. inmatriculare"),
        "createCustomer":
            MessageLookupByLibrary.simpleMessage("Utilizator nou"),
        "delete": MessageLookupByLibrary.simpleMessage("Sterge"),
        "editCustomer":
            MessageLookupByLibrary.simpleMessage("Modifica utilizatorul"),
        "lastITP": MessageLookupByLibrary.simpleMessage("Ultimul ITP"),
        "name": MessageLookupByLibrary.simpleMessage("Nume"),
        "nextITP": MessageLookupByLibrary.simpleMessage("Urmatorul ITP"),
        "oneYear": MessageLookupByLibrary.simpleMessage("1 an"),
        "phone": MessageLookupByLibrary.simpleMessage("Telefon"),
        "save": MessageLookupByLibrary.simpleMessage("Salveaza"),
        "search": MessageLookupByLibrary.simpleMessage("Cauta"),
        "sendSMS": MessageLookupByLibrary.simpleMessage("Trimite SMS"),
        "sixMonths": MessageLookupByLibrary.simpleMessage("6 luni"),
        "snackBarMsg": m0,
        "twoYears": MessageLookupByLibrary.simpleMessage("2 ani"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "wrongFormat": MessageLookupByLibrary.simpleMessage("Format gresit")
      };
}
