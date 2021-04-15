import 'package:flutter/material.dart';
import 'package:flutter_app_peliculas/src/models/pelicula_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperTarjetas extends StatelessWidget {

  final List<Pelicula> peliculas;

  SwiperTarjetas({@required this.peliculas});


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(peliculas[index].getPosterImg()),
              fit: BoxFit.cover,
            )
          );
        },
        itemCount: peliculas.length,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}