import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/note.dart';

class HiveService extends ChangeNotifier {
  List<Note> _notes = [];
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);
  final String noteHiveBox = 'note-box';

  // Create new note
  Future<void> createItem(Note note) async {
    Box<Note> box = await Hive.openBox<Note>(noteHiveBox);
    await box.add(note);
    _notes.add(note);
    _notes = box.values.toList();
    notifyListeners();
  }

  // Get notes
  Future<void> getItems() async {
    Box<Note> box = await Hive.openBox<Note>(noteHiveBox);
    _notes = box.values.toList();
    notifyListeners();
  }

  // remove a note
  Future<void> deleteItem(Note note) async {
    Box<Note> box = await Hive.openBox<Note>(noteHiveBox);
    await box.delete(note.key);
    _notes = box.values.toList();
    notifyListeners();
  }
}
