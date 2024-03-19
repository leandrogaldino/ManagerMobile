import 'dart:convert';
import 'package:manager_mobile_app/src/models/person_compressor_model.dart';

class PersonModel {
  final int id;
  final String document;
  final String name;
  final bool isTechnician;
  final bool isCustomer;
  final List<PersonCompressorModel> compressors;

  PersonModel({
    required this.id,
    required this.document,
    required this.name,
    required this.isTechnician,
    required this.isCustomer,
    required this.compressors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'document': document,
      'name': name,
      'istechnician': isTechnician,
      'iscustomer': isCustomer,
      'coalescents': compressors.map((x) => x.toMap()).toList(),
    };
  }

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(
        id: (map['id'] ?? 0) as int,
        document: (map['document'] ?? '') as String,
        name: (map['name'] ?? '') as String,
        isTechnician: map['istechnician'] == 0 ? false : true,
        isCustomer: map['iscustomer'] == 0 ? false : true,
        compressors: (map['compressors'] as List<dynamic>).map((compressorMap) {
          return PersonCompressorModel.fromMap(compressorMap);
        }).toList());
  }

  String toJson() => json.encode(toMap());

  factory PersonModel.fromJson(String source) => PersonModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonModel(id: $id, document: $document, name: $name, isTechnician: $isTechnician, isCustomer: $isCustomer)';
  }

  PersonModel copyWith({
    int? id,
    String? document,
    String? name,
    bool? isTechnician,
    bool? isCustomer,
    List<PersonCompressorModel>? compressors,
  }) {
    return PersonModel(
      id: id ?? this.id,
      document: document ?? this.document,
      name: name ?? this.name,
      isTechnician: isTechnician ?? this.isTechnician,
      isCustomer: isCustomer ?? this.isCustomer,
      compressors: compressors ?? this.compressors,
    );
  }
}
