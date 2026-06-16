import 'package:shared_preferences/shared_preferences.dart';
import 'package:shinup/core/constants/app_constants.dart';

class CounterLocalDataSource {
  final SharedPreferences _prefs;

  CounterLocalDataSource(this._prefs);

  int readCounter() {
    return _prefs.getInt(AppConstants.counterKey) ?? 0;
  }

  Future<void> writeCounter(int value) async {
    await _prefs.setInt(AppConstants.counterKey, value);
  }
}
