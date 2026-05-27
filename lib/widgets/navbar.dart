import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NavItem {
  const NavItem({required this.label, required this.sectionId});

  final String label;
  final String sectionId;
}

class BeanNavBar extends StatelessWidget {
  const BeanNavBar({
    super.key,
    required this.items,
    required this.onTap,
    required this.onOrderNow,
    this.onMenuTap,
  });

  final List<NavItem> items;
  final ValueChanged<String> onTap;
  final VoidCallback onOrderNow;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.sizeOf(context).width < 900;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cream.withValues(alpha: 0.92),
        border: const Border(bottom: BorderSide(color: Color(0x225C3D2E))),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: <Widget>[
              const Icon(Icons.local_cafe_rounded, color: AppTheme.coffeeBrown),
              const SizedBox(width: 10),
              Text(
                'Bean Basket',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: AppTheme.coffeeBrown),
              ),
              const Spacer(),
              if (!isMobile)
                Wrap(
                  spacing: 20,
                  children: items
                      .map(
                        (NavItem item) => TextButton(
                          onPressed: () => onTap(item.sectionId),
                          child: Text(item.label),
                        ),
                      )
                      .toList(),
                ),
              const SizedBox(width: 10),
              if (!isMobile)
                FilledButton(
                  onPressed: onOrderNow,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.gardenGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text('Order Now'),
                )
              else
                IconButton(
                  onPressed: onMenuTap,
                  icon: const Icon(Icons.menu_rounded),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
