import 'package:flutter/material.dart';
import '../models/lek.dart';
import '../db/lek_database.dart';

class LekProvider with ChangeNotifier {
  List<Lek> _leki = [];

  List<Lek> get leki => _leki;

  /// Wczytaj leki z lokalnej bazy danych
  Future<void> loadLeki() async {
    _leki = await LekDatabase.instance.getAll();
    notifyListeners();
  }

  /// Dodaj nowy lek do bazy danych i odśwież listę
  Future<void> dodajLek(Lek lek) async {
    await LekDatabase.instance.create(lek);
    await loadLeki();
  }

  /// Usuń lek po ID i odśwież listę
  Future<void> usunLek(int id) async {
    await LekDatabase.instance.delete(id);
    await loadLeki();
  }

  /// Wyczyść wszystkie dane (np. do testów lub resetu)
  Future<void> wyczyscLeki() async {
    await LekDatabase.instance.clear();
    await loadLeki();
  }
}
