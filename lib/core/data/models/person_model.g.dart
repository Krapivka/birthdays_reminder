// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      birthdate: DateTime.parse(json['birthdate'] as String),
      listOfGifts: (json['listOfGifts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthdate': instance.birthdate.toIso8601String(),
      'listOfGifts': instance.listOfGifts,
    };
