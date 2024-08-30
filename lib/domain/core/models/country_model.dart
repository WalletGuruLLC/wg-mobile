import 'dart:convert';

import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';

class Country {
  final String name;
  final String iso2;

  Country({
    required this.name,
    required this.iso2,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      iso2: json['iso2'] ?? '',
    );
  }
}

class StateCountry {
  final String name;
  final String iso2;
  final String iso3;
  final List<LocationState> states;

  StateCountry({
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.states,
  });

  factory StateCountry.fromJson(Map<String, dynamic> json) {
    return StateCountry(
      name: json['name'] as String,
      iso2: json['iso2'] as String,
      iso3: json['iso3'] as String,
      states: (json['data']['states'] as List)
          .map((state) => LocationState.fromJson(state))
          .toList(),
    );
  }
}

class LocationState {
  final String name;
  final String stateCode;

  LocationState({
    required this.name,
    required this.stateCode,
  });

  factory LocationState.fromJson(Map<String, dynamic> json) {
    return LocationState(
      name: json['name'] as String,
      stateCode: json['state_code'] as String,
    );
  }
}

class CountriesDataSource {
  Future<List<Country>> getCountriesList() async {
    final response = await HttpDataSource.get(GetCountriesNetwork.getCountries);
    final result = jsonDecode(response.body);

    if (response.statusCode == 200 && result['error'] == false) {
      List<dynamic> data = result['data'];
      List<Country> countries =
          data.map((json) => Country.fromJson(json)).toList();
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}

class StateDataSource {
  Future<List<LocationState>> getStates({required String countryName}) async {
    final response = await HttpDataSource.get(
      'https://countriesnow.space/api/v0.1/countries/states/q?country=$countryName',
    );
    final result = jsonDecode(response.body);

    if (response.statusCode == 200 && result['error'] == false) {
      List<dynamic> states = result['data']['states'];
      return states.map((json) => LocationState.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load states');
    }
  }
}

class CitiesDataSource {
  Future<List<String>> getCities({
    required String stateName,
    required String countryName,
  }) async {
    final response = await HttpDataSource.get(
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country=$countryName&state=$stateName',
    );
    final result = jsonDecode(response.body);

    if (response.statusCode == 200 && result['error'] == false) {
      List<dynamic> cities = result['data'];
      return cities.cast<String>();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}

class GetCountriesNetwork {
  static const String getCountries =
      'https://countriesnow.space/api/v0.1/countries/positions';
}
