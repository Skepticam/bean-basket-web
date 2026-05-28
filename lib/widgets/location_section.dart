import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  static const String _localMapAsset =
      'assets/images/bean_basket_location_map.png';

  static final Uri mapsUri = Uri.parse(
    'https://maps.app.goo.gl/xVo6Zr9rdLpmXRJt8',
  );

  Future<void> _openMap() async {
    if (!await launchUrl(mapsUri, mode: LaunchMode.platformDefault)) {
      throw Exception('Could not open map URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Container(
          constraints: BoxConstraints(minHeight: mobile ? 620 : 420),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[Color(0xFF6B8F71), Color(0xFF476652)],
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool stacked = constraints.maxWidth < 900;

                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _LocationDetails(openMap: _openMap),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 260,
                        child: _MapImage(openMap: _openMap),
                      ),
                    ],
                  );
                }

                return SizedBox(
                  height: 330,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: _LocationDetails(openMap: _openMap)),
                      const SizedBox(width: 24),
                      Expanded(child: _MapImage(openMap: _openMap)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationDetails extends StatelessWidget {
  const _LocationDetails({required this.openMap});

  final Future<void> Function() openMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.location_on_rounded, color: Colors.white, size: 36),
        const SizedBox(height: 12),
        Text(
          'Find Bean Basket',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 12),
        const Text(
          'Rivera Farm, V.G Nursery Road\nGeneral Santos City (Dadiangas),\nSouth Cotabato, Philippines',
          style: TextStyle(color: Color(0xFFF2F8F3), fontSize: 16, height: 1.6),
        ),
        const SizedBox(height: 22),
        FilledButton.icon(
          onPressed: openMap,
          icon: const Icon(Icons.map_rounded),
          label: const Text('Open in Google Maps'),
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.accentGold,
            foregroundColor: AppTheme.deepBrown,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
        ),
      ],
    );
  }
}

class _MapImage extends StatelessWidget {
  const _MapImage({required this.openMap});

  final Future<void> Function() openMap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: openMap,
      borderRadius: BorderRadius.circular(18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              LocationSection._localMapAsset,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Container(
                      color: const Color(0xFF2F4638),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.map_outlined,
                        color: Color(0xFFD6E6DA),
                        size: 56,
                      ),
                    );
                  },
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0x22000000), Color(0x88000000)],
                ),
              ),
            ),
            const Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Text(
                'Bean Basket Garden Cafe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
