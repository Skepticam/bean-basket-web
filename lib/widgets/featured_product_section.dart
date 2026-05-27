import 'dart:math' as math;
import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FeaturedProductSection extends StatefulWidget {
  const FeaturedProductSection({super.key});

  @override
  State<FeaturedProductSection> createState() => _FeaturedProductSectionState();
}

class _FeaturedProductSectionState extends State<FeaturedProductSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final PageController _pageController;
  Timer? _autoTimer;
  int _currentIndex = 0;

  static const List<_FeaturedProduct> _products = <_FeaturedProduct>[
    _FeaturedProduct(
      name: 'Garden Signature Iced Latte',
      description:
          'Velvety espresso with chilled milk, caramel cloud foam, and a touch of sea salt.',
      price: 'PHP 165',
      badge: 'Seasonal favorite',
      imageUrl:
          'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=1600',
    ),
    _FeaturedProduct(
      name: 'Honey Cinnamon Cappuccino',
      description:
          'Creamy microfoam cappuccino sweetened with local honey and a dusting of cinnamon.',
      price: 'PHP 155',
      badge: 'Bestseller',
      imageUrl:
          'https://images.pexels.com/photos/1092730/pexels-photo-1092730.jpeg?auto=compress&cs=tinysrgb&w=1600',
    ),
    _FeaturedProduct(
      name: 'Strawberry Matcha Latte',
      description:
          'Layered ceremonial matcha and strawberry cream with smooth milk for a bright finish.',
      price: 'PHP 170',
      badge: 'New release',
      imageUrl:
          'https://images.pexels.com/photos/5946665/pexels-photo-5946665.jpeg?auto=compress&cs=tinysrgb&w=1600',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted || !_pageController.hasClients) {
        return;
      }
      final int next = (_currentIndex + 1) % _products.length;
      _goTo(next);
    });
  }

  void _goTo(int index) {
    if (!_pageController.hasClients) {
      return;
    }
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
    setState(() => _currentIndex = index);
  }

  void _next() => _goTo((_currentIndex + 1) % _products.length);

  void _prev() =>
      _goTo((_currentIndex - 1 + _products.length) % _products.length);

  @override
  Widget build(BuildContext context) {
    final bool narrow = MediaQuery.sizeOf(context).width < 900;
    final _FeaturedProduct product = _products[_currentIndex];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFFF6EFE6),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0x225C3D2E)),
          ),
          child: narrow
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildText(context, product),
                    const SizedBox(height: 20),
                    _buildAnimatedImage(product.imageUrl),
                  ],
                )
              : Row(
                  children: <Widget>[
                    Expanded(flex: 5, child: _buildText(context, product)),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 4,
                      child: _buildAnimatedImage(product.imageUrl),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, _FeaturedProduct product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Featured Products',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 40),
              ),
            ),
            IconButton(
              onPressed: _prev,
              tooltip: 'Previous featured product',
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            IconButton(
              onPressed: _next,
              tooltip: 'Next featured product',
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          product.name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 8),
        Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            Text(
              product.price,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.gardenGreen,
                fontSize: 26,
              ),
            ),
            const SizedBox(width: 16),
            const Icon(
              Icons.local_fire_department_rounded,
              color: AppTheme.accentGold,
            ),
            const SizedBox(width: 6),
            Text(product.badge),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: List<Widget>.generate(_products.length, (int index) {
            final bool active = index == _currentIndex;
            return GestureDetector(
              onTap: () => _goTo(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: active ? 24 : 8,
                height: 8,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(
                  color: active
                      ? AppTheme.coffeeBrown
                      : const Color(0x555C3D2E),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_bag_rounded),
          label: const Text('Order Featured Drink'),
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.coffeeBrown,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedImage(String activeImageUrl) {
    return AnimatedBuilder(
      animation: _floatController,
      builder: (BuildContext context, Widget? child) {
        final double wave = math.sin(_floatController.value * 2 * math.pi) * 10;
        return Transform.translate(offset: Offset(0, wave), child: child);
      },
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const RadialGradient(
                  colors: <Color>[Color(0x33C8954E), Color(0x00C8954E)],
                  radius: 0.8,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: AspectRatio(
              aspectRatio: 0.9,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _products.length,
                onPageChanged: (int value) {
                  setState(() => _currentIndex = value);
                  _startAutoSlide();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _products[index].imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                          BuildContext context,
                          Object error,
                          StackTrace? stackTrace,
                        ) {
                          return Container(
                            color: const Color(0xFFE7D8C5),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.local_cafe_rounded,
                              size: 64,
                              color: AppTheme.coffeeBrown,
                            ),
                          );
                        },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProduct {
  const _FeaturedProduct({
    required this.name,
    required this.description,
    required this.price,
    required this.badge,
    required this.imageUrl,
  });

  final String name;
  final String description;
  final String price;
  final String badge;
  final String imageUrl;
}
