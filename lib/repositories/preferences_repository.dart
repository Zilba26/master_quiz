import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {

  final String _recordKey = 'record';

  Future<void> saveNewRecord(int record) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_recordKey, record);
  }

  Future<int> loadRecord() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? record = prefs.getInt(_recordKey);
    if (record == null) {
      return 0;
    }
    return record;
  }

}