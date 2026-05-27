import 'package:flutter/material.dart';

import '../data/menu_data.dart';
import '../models/menu_item.dart';
import '../theme/app_theme.dart';

class MenuSection extends StatefulWidget {
  const MenuSection({super.key});

  @override
  State<MenuSection> createState() => _MenuSectionState();
}

class _MenuSectionState extends State<MenuSection> {
  String selectedCategory = menuCategories.first;
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> filtered = cafeMenuItems
        .where((MenuItem item) => item.category == selectedCategory)
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Menu Highlights',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Text(
              'Representative menu for Bean Basket Garden Cafe. Prices and items can be updated anytime.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: menuCategories
                  .map(
                    (String category) => ChoiceChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() => selectedCategory = category);
                        }
                      },
                      selectedColor: AppTheme.gardenGreen.withValues(
                        alpha: 0.2,
                      ),
                      side: const BorderSide(color: Color(0x335C3D2E)),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                int count = 1;
                if (constraints.maxWidth >= 1050) {
                  count = 3;
                } else if (constraints.maxWidth >= 680) {
                  count = 2;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    childAspectRatio: 1.35,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    final MenuItem item = filtered[index];
                    final bool isHovered = hoveredIndex == index;
                    final String imageUrl =
                        'https://picsum.photos/seed/${item.name.replaceAll(' ', '-').toLowerCase()}/900/600';

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoveredIndex = index),
                      onExit: (_) => setState(() => hoveredIndex = null),
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 220),
                        scale: isHovered ? 1.02 : 1,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          transform: Matrix4.translationValues(
                            0,
                            isHovered ? -4 : 0,
                            0,
                          ),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AspectRatio(
                                  aspectRatio: 2.2,
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (
                                          BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace,
                                        ) {
                                          return Container(
                                            color: const Color(0xFFE9DDCF),
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.local_cafe_rounded,
                                              color: AppTheme.coffeeBrown,
                                              size: 38,
                                            ),
                                          );
                                        },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.local_cafe_rounded,
                                            color: AppTheme.coffeeBrown,
                                          ),
                                          const Spacer(),
                                          Text(
                                            item.price,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  color: AppTheme.gardenGreen,
                                                  fontSize: 18,
                                                ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleLarge,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        item.description,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
