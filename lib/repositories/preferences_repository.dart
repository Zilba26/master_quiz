import 'package:master_quiz/models/difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';

class PreferencesRepository {

  Future<void> saveRecord(int record, Category category, Difficulty difficulty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('record_${category.name}_${difficulty.name}', record);
  }

  Future<int?> loadRecord(Category category, Difficulty difficulty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('record_${category.name}_${difficulty.name}')) {
      return prefs.getInt('record_${category.name}_${difficulty.name}')!;
    }
    return null;
  }

}