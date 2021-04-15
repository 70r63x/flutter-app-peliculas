import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperTarjetas extends StatelessWidget {

  final List<dynamic> peliculas;

  SwiperTarjetas({@required this.peliculas});


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.width * 0.5,
        itemBuilder: (BuildContext context,int index){
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network("https://upload.wikimedia.org/wikipedia/commons/9/91/Oahu_Landscape.jpg",fit: BoxFit.cover,)
          );
        },
        itemCount: peliculas.length,
        pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}