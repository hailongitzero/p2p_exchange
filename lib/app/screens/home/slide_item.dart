import 'package:flutter/material.dart';
import 'package:p2p_exchange/app/models/slide.dart';

class SlideItem extends StatelessWidget {
  final Slide slide;
  const SlideItem({required this.slide, super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          slide.image,
          fit: BoxFit.cover,
          width: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                slide.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement navigation or action
              },
              child: const Text('View'),
            ),
          ],
        ),
      ],
    );
  }
}
