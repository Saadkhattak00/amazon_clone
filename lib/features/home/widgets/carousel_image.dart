import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
      ),
      items: GlobalVariables.carouselImages.map((i){
        return Builder(builder: (BuildContext context) => Image.network(
          i,
          fit: BoxFit.cover,
          height: 200,
        ),);
      },).toList(),
    );
  }
}
