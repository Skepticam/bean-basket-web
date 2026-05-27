import 'package:flutter/material.dart';

import 'auto_image_carousel.dart';

class CarouselShowcaseSection extends StatelessWidget {
  const CarouselShowcaseSection({super.key});

  static const List<String> coffeeImages = <String>[
    'https://picsum.photos/seed/coffee-a/1200/800',
    'https://picsum.photos/seed/coffee-b/1200/800',
    'https://picsum.photos/seed/coffee-c/1200/800',
    'https://picsum.photos/seed/coffee-d/1200/800',
  ];

  static const List<String> foodImages = <String>[
    'https://picsum.photos/seed/food-a/1200/800',
    'https://picsum.photos/seed/food-b/1200/800',
    'https://picsum.photos/seed/food-c/1200/800',
    'https://picsum.photos/seed/food-d/1200/800',
  ];

  static const List<String> spaceImages = <String>[
    'https://picsum.photos/seed/space-a/1200/800',
    'https://picsum.photos/seed/space-b/1200/800',
    'https://picsum.photos/seed/space-c/1200/800',
    'https://picsum.photos/seed/space-d/1200/800',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Live Carousels',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Text(
              'Three independent sliders with autoplay and manual controls.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 22),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool isWide = constraints.maxWidth >= 1040;
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: AutoImageCarousel(
                          title: 'Coffee Flights',
                          images: coffeeImages,
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: AutoImageCarousel(
                          title: 'Food Pairings',
                          images: foodImages,
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: AutoImageCarousel(
                          title: 'Cafe Spaces',
                          images: spaceImages,
                        ),
                      ),
                    ],
                  );
                }

                return const Column(
                  children: <Widget>[
                    AutoImageCarousel(
                      title: 'Coffee Flights',
                      images: coffeeImages,
                    ),
                    SizedBox(height: 14),
                    AutoImageCarousel(
                      title: 'Food Pairings',
                      images: foodImages,
                    ),
                    SizedBox(height: 14),
                    AutoImageCarousel(
                      title: 'Cafe Spaces',
                      images: spaceImages,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
