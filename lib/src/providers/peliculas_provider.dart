import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_app_peliculas/src/models/pelicula_model.dart';

class PeliculasProviders {
  String _apikey = '58234a351e6b48bcc2a195b2174715af';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-CO';
  int _popularesPaqe = 0;
  bool _cargando = false;

  List<Pelicula> _populares = List.empty(growable: true);
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get polularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _languaje,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;
    _popularesPaqe++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _languaje,
      'page': _popularesPaqe.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    polularesSink(_populares);

    _cargando = false;
    return resp;
  }
}
