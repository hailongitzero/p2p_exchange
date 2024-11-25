import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/product.dart';

class SlideItem extends StatelessWidget {
  final RxList<Product> productSlides;
  const SlideItem({required this.productSlides, super.key});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: productSlides
          .map((item) => Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      item.image!,
                      fit: BoxFit.cover,
                      height: 150,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset('lib/assets/images/400.png');
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              item.name,
                              style: textTheme
                                  .copyWith(
                                      titleLarge: textTheme.titleLarge!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))
                                  .titleLarge,
                            )),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Implement navigation or action
                          },
                          child: Text('trade'.tr),
                        ),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
