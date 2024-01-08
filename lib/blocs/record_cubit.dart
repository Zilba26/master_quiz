import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:master_quiz/models/difficulty.dart';

import '../models/category.dart';
import '../repositories/preferences_repository.dart';

/// Déclaration d'un "Cubit" pour stocker les records pour chaque catégorie
class RecordCubit extends Cubit<List<int>> {
  final PreferencesRepository preferencesRepository;

  RecordCubit(this.preferencesRepository) : super([]);

  /// Méthode pour sauvegarder un record en fonction de la catégorie
  Future<void> saveRecord(int record, Category category, Difficulty difficulty) async {
    final List<int> records = state;
    records[category.index] = record;
    await preferencesRepository.saveRecord(record, category, difficulty);
    emit(records);
  }

  /// Méthode pour charger les records en fonction de la catégorie
  Future<void> loadRecords(Category category, Difficulty difficulty) async {
    final List<int> records = state;
    records[category.index] = await preferencesRepository.loadRecord(category, difficulty);
    emit(records);
  }

}