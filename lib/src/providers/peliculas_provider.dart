import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_app_peliculas/src/models/pelicula_model.dart';

class PeliculasProviders {
  String _apikey = '58234a351e6b48bcc2a195b2174715af';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-CO';

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }
}