import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onViewMenu,
    required this.onDirections,
    required this.scrollOffset,
  });

  final VoidCallback onViewMenu;
  final VoidCallback onDirections;
  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.sizeOf(context).width < 700;
    final double heroHeight = isMobile ? 560 : 680;
    final double backgroundShift = (scrollOffset * 0.22).clamp(
      0,
      heroHeight * 0.30,
    );

    return SizedBox(
      height: heroHeight,
      child: ClipRect(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, backgroundShift),
              child: OverflowBox(
                minHeight: heroHeight,
                maxHeight: heroHeight * 1.5,
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/hero_parallax.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: heroHeight * 1.5,
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0x332C1810), Color(0xBE2C1810)],
                ),
              ),
            ),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (BuildContext context, double value, Widget? child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 960),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x66C8954E),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: const Color(0x99FFFFFF)),
                          ),
                          child: const Text(
                            'General Santos City, South Cotabato',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Bean Basket\nGarden Cafe',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontSize: isMobile ? 46 : 78,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'Where Coffee Meets the Garden',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: const Color(0xFFF7E9D6),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 14,
                          runSpacing: 14,
                          alignment: WrapAlignment.center,
                          children: <Widget>[
                            FilledButton(
                              onPressed: onViewMenu,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.accentGold,
                                foregroundColor: AppTheme.deepBrown,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                              ),
                              child: const Text('Explore Menu'),
                            ),
                            OutlinedButton(
                              onPressed: onDirections,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.white),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 18,
                                ),
                              ),
                              child: const Text('Get Directions'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
