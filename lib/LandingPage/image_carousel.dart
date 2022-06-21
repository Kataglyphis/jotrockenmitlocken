import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

final List<String> carouselImgList = [
  'assets/images/ScreenshotVulkanPathTracing.png',
  'assets/images/ScreenshotModernOpenGL.png',
  'assets/images/ScreenshotClouds.png',
  'assets/images/ScreenshotWorleyNoise.png',
];

final List<String> carouselImgListNames = [
  'VulkanPathTracing',
  'ModernOpenGL',
  'Clouds',
  'WorleyNoise',
];

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    double imageScale = 0.7;
    double imageHeight = media.size.height * imageScale;
    double imageBottomPosition = media.size.height * (1.0 - imageScale);

    double imageWidth = media.size.width * imageScale;

    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: carouselImgList
          .map((item) => Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Container(
                    //height: imageHeight,
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        //borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                      children: <Widget>[
                        Image.asset(
                          item,
                          fit: BoxFit.cover,
                          width: imageWidth,
                          //height: imageHeight,
                        ),
                        Positioned(
                          top: 0.0, //imageBottomPosition,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              carouselImgListNames[
                                  carouselImgList.indexOf(item)],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              ))
          .toList(),
    );
  }
}
