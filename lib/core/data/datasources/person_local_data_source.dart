import 'dart:convert';

import 'package:birthdays_reminder/core/error/exception.dart';
import 'package:birthdays_reminder/core/data/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
  Future<void> onePersonToCache(PersonModel person);
}

const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList!.isNotEmpty) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    debugPrint('Persons to write Cache: ${jsonPersonsList.length}');
    return Future.value(jsonPersonsList);
  }

  @override
  Future<void> onePersonToCache(PersonModel person) async {
    final jsonPerson = Future.value(sharedPreferences.setString(
        CACHED_PERSONS_LIST, json.encode(person.toJson())));
    debugPrint('Person to write Cache: ${jsonPerson}');
    return Future.value(jsonPerson);
  }
}
