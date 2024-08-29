import 'dart:convert';

import 'package:wallet_guru/domain/core/models/response_model.dart';
import 'package:wallet_guru/infrastructure/core/remote_data_sources/http.dart';

import 'invalid_data.dart';

class Country {
  String name;
  String iso2;
  double long;
  double lat;

  Country({
    required this.name,
    required this.iso2,
    required this.long,
    required this.lat,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json["name"] ?? '',
      iso2: json["iso2"] ?? '',
      long: double.tryParse(json["long"].toString()) ?? 0.0,
      lat: double.tryParse(json["lat"].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso2": iso2,
        "long": long,
        "lat": lat,
      };
}

class LocationState {
  String name;
  String stateCode;

  LocationState({
    required this.name,
    required this.stateCode,
  });

  factory LocationState.fromJson(Map<String, dynamic> json) {
    return LocationState(
      name: json["name"] ?? '',
      stateCode: json["stateCode"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "stateCode": stateCode,
      };
}

class GetCountriesNetwork {
  static const String getCountries =
      'https://countriesnow.space/api/v0.1/countries/positions';
}

class CountriesDataSource {
  Future<List<Country>> getCountriesList() async {
    var response = await HttpDataSource.get(GetCountriesNetwork.getCountries);

    final result = response;

    if (result['data'] != null && result['data'] is List) {
      List<dynamic> data = result['data'];
      List<Country> countries =
          data.map((json) => Country.fromJson(json)).toList();

      return countries;
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}

class GetStatesNetwork {
  static const String statesRoute =
      'https://countriesnow.space/api/v0.1/countries/states';
}

class StateDataSource {
  Future<List<LocationState>> getStates({required String countryName}) async {
    var response = await HttpDataSource.post(
      GetStatesNetwork.statesRoute,
      {
        "country": countryName.toLowerCase(),
      },
    );

    print('Response from API: $response');
    final result = jsonDecode(response.body);
    print(result);

    return [];
  }
}

class GetCitiesNetwork {
  static const String citiesRoute =
      'https://countriesnow.space/api/v0.1/countries/state/cities';
}

class CitiesDataSource {
  Future<List<String>> getCitites(
      {required String stateName, required String countryName}) async {
    var response = await HttpDataSource.post(
      GetCitiesNetwork.citiesRoute,
      {
        "country": countryName,
        "state": stateName,
      },
    );

    print(response);
    final result = response;

    if (result['data'] != null && result['data'] is List) {
      List<dynamic> data = result['data'];
      // List<Country> cities =

      return [];
    } else {
      final errorModel = ResponseModel.fromJson(result);
      throw InvalidData(errorModel.customCode, errorModel.customMessage,
          errorModel.customMessageEs);
    }
  }
}
