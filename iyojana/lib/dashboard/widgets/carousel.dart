import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iyojana/dashboard/widgets/carousel_item.dart';

class Carousel extends StatelessWidget {
  final List<String> contents = [
    'assets/carousel_image.png',
    'assets/carousel_image.png',
    'assets/carousel_image.png',
    'assets/carousel_image.png',
  ];

  Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: contents.length,
        itemBuilder: (BuildContext context, i, pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CarouselItem(),
          );
        },
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.19,
            autoPlayAnimationDuration: const Duration(seconds: 3),
            autoPlay: true,
            aspectRatio: 1,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 3)));
  }
}
