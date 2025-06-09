class Lek {
  final int? id;
  final String nazwa;
  final int ilosc;
  final DateTime dataWaznosci;
  final String? opis;

  Lek({
    this.id,
    required this.nazwa,
    required this.ilosc,
    required this.dataWaznosci,
    this.opis,
  });

  Lek copyWith({
    int? id,
    String? nazwa,
    int? ilosc,
    DateTime? dataWaznosci,
    String? opis,
  }) {
    return Lek(
      id: id ?? this.id,
      nazwa: nazwa ?? this.nazwa,
      ilosc: ilosc ?? this.ilosc,
      dataWaznosci: dataWaznosci ?? this.dataWaznosci,
      opis: opis ?? this.opis,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nazwa': nazwa,
      'ilosc': ilosc,
      'dataWaznosci': dataWaznosci.toIso8601String(),
      'opis': opis,
    };
  }

  factory Lek.fromMap(Map<String, dynamic> map) {
    return Lek(
      id: map['id'],
      nazwa: map['nazwa'],
      ilosc: map['ilosc'],
      dataWaznosci: DateTime.parse(map['dataWaznosci']),
      opis: map['opis'],
    );
  }
}
