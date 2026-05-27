import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ParallaxSection extends StatelessWidget {
  const ParallaxSection({super.key, required this.scrollOffset});

  final double scrollOffset;

  @override
  Widget build(BuildContext context) {
    final double farShift = (scrollOffset * 0.12).clamp(0, 140);
    final double nearShift = (scrollOffset * 0.24).clamp(0, 240);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, -farShift),
                child: OverflowBox(
                  maxHeight: 640,
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/parallax_bg.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -nearShift),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 560,
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[Color(0x3346A06D), Color(0x0046A06D)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0x1A2C1810), Color(0xAA2C1810)],
                  ),
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 980),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Sip Slow. Breathe Deep.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(color: Colors.white, fontSize: 46),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'A garden-inspired coffee break with ambient greenery, sunlight, and handcrafted drinks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF7E9D6),
                            fontSize: 17,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: const Text(
                            'Parallax Experience',
                            style: TextStyle(
                              color: AppTheme.deepBrown,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
