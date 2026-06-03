import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';

//instruction page of app
class InstructionScreen extends StatelessWidget {
  final List<String> images = const[
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
    'assets/5.png',
    'assets/6.png',
    'assets/7.png',

    // 'assets/NIN-logo.png',
    // 'assets/NIN-logo.png',
    // 'assets/NIN-logo.png',
    // 'assets/image2.jpg',
    // 'assets/image3.jpg',
    // Add more image paths as needed
  ];

  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          aspectRatio: 16 / 9,
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,

          // prevPageIcon: Icon(Icons.arrow_back_ios),
          // nextPageIcon: Icon(Icons.arrow_forward_ios),
        ),
        items: images.map((String imagePath) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: TColor.primaryColor1,
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              );
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/root');
        },
        child: const Icon(
          Icons.arrow_forward,
        ),
      ),
    );
  }
}
