import 'dart:convert';

import 'package:manager_mobile_app/src/models/person_compressor_coalescent_model.dart';

class PersonCompressorModel {
  final int id;
  final int personId;
  final String name;
  final List<PersonCompressorCoalescentModel> coalescents;

  PersonCompressorModel({
    required this.id,
    required this.personId,
    required this.name,
    required this.coalescents,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'personId': personId,
      'name': name,
      'coalescents': coalescents.map((x) => x.toMap()).toList(),
    };
  }

  factory PersonCompressorModel.fromMapAndCollection(Map<String, dynamic> map, List<PersonCompressorCoalescentModel> coalescents) {
    return PersonCompressorModel(
      id: (map['id'] ?? 0) as int,
      personId: (map['personid'] ?? 0) as int,
      name: (map['name'] ?? '') as String,
      coalescents: coalescents,
    );
  }

  factory PersonCompressorModel.fromMap(Map<String, dynamic> map) {
    return PersonCompressorModel(
        id: (map['id'] ?? 0) as int,
        personId: (map['personid'] ?? 0) as int,
        name: (map['name'] ?? '') as String,
        coalescents: (map['coalescents'] as List<dynamic>).map((coalescentMap) {
          return PersonCompressorCoalescentModel.fromMap(coalescentMap);
        }).toList());
  }

  factory PersonCompressorModel.fromJson(String source) => PersonCompressorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PersonCompressorModel copyWith({
    int? id,
    int? personId,
    String? name,
    List<PersonCompressorCoalescentModel>? coalescents,
  }) {
    return PersonCompressorModel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      name: name ?? this.name,
      coalescents: coalescents ?? this.coalescents,
    );
  }

  String toJson() => json.encode(toMap());
  @override
  String toString() => 'CompressorModel(id: $id, personId: $personId, name: $name, coalescents: [${coalescents.map((e) => e.name).join(', ')}])';
}
