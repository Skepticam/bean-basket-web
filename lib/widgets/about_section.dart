import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool narrow = constraints.maxWidth < 900;
          Widget buildTextBlock() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'A hidden garden for coffee lovers',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: narrow ? 32 : 42,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Bean Basket Garden Cafe is a calm corner in General Santos where handcrafted drinks, light comfort food, and fresh greenery come together. The atmosphere is designed for slow mornings, quiet afternoons, and easy catchups.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 18),
                Text(
                  'Google Maps rating: 4.7 stars',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: AppTheme.gardenGreen),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x1F5C3D2E)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Icon(Icons.eco_rounded, color: AppTheme.gardenGreen),
                      SizedBox(width: 10),
                      Text('Garden-inspired space and menu'),
                    ],
                  ),
                ),
              ],
            );
          }

          Widget buildImageBlock() {
            return ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Image.network(
                    'https://picsum.photos/id/1035/1200/900',
                    fit: BoxFit.cover,
                    height: narrow ? 300 : 420,
                    width: double.infinity,
                    errorBuilder:
                        (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return Container(
                            height: narrow ? 300 : 420,
                            width: double.infinity,
                            color: const Color(0xFF6B8F71),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.eco_rounded,
                              color: Colors.white,
                              size: 64,
                            ),
                          );
                        },
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xCC2C1810),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '46Q2+86, Rivera Farm, V.G Nursery Road',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Center(
              child: narrow
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildTextBlock(),
                        const SizedBox(height: 28),
                        buildImageBlock(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(child: buildTextBlock()),
                        const SizedBox(width: 28),
                        Expanded(child: buildImageBlock()),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
