import 'dart:convert';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
  Future<void> onePersonToCache(PersonModel person);
  Future<int> length();
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST5';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
    return Future.value(jsonPersonsList
        .map((person) => PersonModel.fromJson(json.decode(person)))
        .toList());
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) async {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    await sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    debugPrint('Persons to write Cache: ${jsonPersonsList.length}');
  }

  @override
  Future<void> onePersonToCache(PersonModel person) async {
    final listPersonModel = await getLastPersonsFromCache();
    listPersonModel.add(person);
    await personsToCache(listPersonModel);
    debugPrint('Person to write Cache: ${listPersonModel}');
  }

  @override
  Future<int> length() async {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST) ?? [];
    return jsonPersonsList.length;
  }
}
