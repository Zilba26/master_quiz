import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_quiz/models/difficulty.dart';

import '../models/category.dart';
import '../repositories/preferences_repository.dart';

class RecordCubit extends Cubit<Map<int, Map<int, int?>>> {
  final PreferencesRepository preferencesRepository = PreferencesRepository();

  RecordCubit() : super(<int, Map<int, int?>>{});

  Future<void> saveRecord(int record, Category category, Difficulty difficulty) async {
    final Map<int, Map<int, int?>> records = state;
    records[category.index]![difficulty.index] = record;
    await preferencesRepository.saveRecord(record, category, difficulty);
    emit(records);
  }

  Future<void> loadRecords() async {
    final Map<int, Map<int, int?>> records = state;
    for (Category category in Category.values) {
      records[category.index] = <int, int?>{};
      for (Difficulty difficulty in Difficulty.values) {
        records[category.index]![difficulty.index] = await preferencesRepository.loadRecord(category, difficulty);
      }
    }
    print(records);
    emit(records);
  }

}