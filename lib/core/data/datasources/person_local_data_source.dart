import 'dart:convert';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
  Future<void> onePersonToCache(PersonModel person);
  Future<void> deletePersonById(int id);
  Future<void> updatePerson(PersonModel person);
  Future<int> lastIndex();
}

// ignore: constant_identifier_names
const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST7';
// ignore: constant_identifier_names
const LAST_INDEX = 'LAST_INDEX';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getPersonsFromCache() {
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
    final int countUsers = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    await sharedPreferences.setInt(LAST_INDEX, countUsers + 1);
    debugPrint('Persons to write Cache: ${jsonPersonsList.length}');
  }

  @override
  Future<void> onePersonToCache(PersonModel person) async {
    final listPersonModel = await getPersonsFromCache();
    listPersonModel.add(person);
    await personsToCache(listPersonModel);
    debugPrint('Person to write Cache: $listPersonModel');
  }

  @override
  Future<int> lastIndex() async {
    final ind = sharedPreferences.getInt(LAST_INDEX) ?? 0;
    return ind;
  }

  @override
  Future<void> deletePersonById(int id) async {
    final listPersonModel = await getPersonsFromCache();
    final index = listPersonModel.indexWhere((element) => element.id == id);
    listPersonModel.removeAt(index);
    await personsToCache(listPersonModel);
  }

  @override
  Future<void> updatePerson(PersonModel person) async {
    final listPersonModel = await getPersonsFromCache();
    final index =
        listPersonModel.indexWhere((element) => element.id == person.id);
    listPersonModel.removeAt(index);
    await personsToCache(listPersonModel);
    await onePersonToCache(person);
  }
}
