import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  static final Uri mapsUri = Uri.parse(
    'https://www.google.com/maps/place/Bean+Basket+Garden+Cafe/@6.1382549,125.2005946,17z',
  );

  Future<void> _openMap() async {
    if (!await launchUrl(mapsUri, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not open map URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Container(
          height: 380,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF6B8F71), Color(0xFF476652)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                  size: 36,
                ),
                const SizedBox(height: 12),
                Text(
                  'Find Bean Basket',
                  style: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Rivera Farm, V.G Nursery Road\nGeneral Santos City (Dadiangas),\nSouth Cotabato, Philippines\n\nPlus Code: 46Q2+86',
                  style: TextStyle(
                    color: Color(0xFFF2F8F3),
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const Spacer(),
                FilledButton.icon(
                  onPressed: _openMap,
                  icon: const Icon(Icons.map_rounded),
                  label: const Text('Open in Google Maps'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.accentGold,
                    foregroundColor: AppTheme.deepBrown,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
