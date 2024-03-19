import 'dart:convert';

class PersonCompressorCoalescentModel {
  final int id;
  final int personCompressorId;
  final String name;
  PersonCompressorCoalescentModel({required this.id, required this.personCompressorId, required this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personCompressorid': personCompressorId,
      'name': name,
    };
  }

  factory PersonCompressorCoalescentModel.fromMap(Map<String, dynamic> map) {
    return PersonCompressorCoalescentModel(
      id: (map['id'] ?? 0) as int,
      personCompressorId: (map['personcompressorid'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonCompressorCoalescentModel.fromJson(String source) => PersonCompressorCoalescentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PersonCompressorCoalescentModel copyWith({
    int? id,
    int? personCompressorId,
    String? name,
  }) {
    return PersonCompressorCoalescentModel(
      id: id ?? this.id,
      personCompressorId: personCompressorId ?? this.personCompressorId,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'CoalescentModel(id: $id, personCompressorId: $personCompressorId,  name: $name)';
  }
}
