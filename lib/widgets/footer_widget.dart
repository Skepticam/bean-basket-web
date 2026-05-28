import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.onAbout,
    required this.onMenu,
    required this.onGallery,
    required this.onLocation,
  });

  final VoidCallback onAbout;
  final VoidCallback onMenu;
  final VoidCallback onGallery;
  final VoidCallback onLocation;

  static final Uri instagramUri = Uri.parse('https://www.instagram.com/');
  static final Uri facebookUri = Uri.parse(
    'https://www.facebook.com/BeanBasket22',
  );
  static final Uri tiktokUri = Uri.parse('https://www.tiktok.com/');

  Future<void> _openExternal(Uri uri) async {
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.deepBrown,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 34),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1180),
          child: Column(
            children: <Widget>[
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 18,
                runSpacing: 12,
                children: <Widget>[
                  TextButton(onPressed: onAbout, child: const Text('About')),
                  TextButton(onPressed: onMenu, child: const Text('Menu')),
                  TextButton(
                    onPressed: onGallery,
                    child: const Text('Gallery'),
                  ),
                  TextButton(
                    onPressed: onLocation,
                    child: const Text('Location'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Bean Basket Garden Cafe\nGeneral Santos City, Philippines',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFEEDFC8), height: 1.5),
              ),
              const SizedBox(height: 12),
              const Text(
                'Open hours: Please update with current schedule\nPhone: Please add store contact number',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFDBC3A6), height: 1.6),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 16,
                children: <Widget>[
                  IconButton(
                    onPressed: () => _openExternal(instagramUri),
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Color(0xFFEEDFC8),
                    ),
                    tooltip: 'Instagram',
                  ),
                  IconButton(
                    onPressed: () => _openExternal(facebookUri),
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Color(0xFFEEDFC8),
                    ),
                    tooltip: 'Facebook',
                  ),
                  IconButton(
                    onPressed: () => _openExternal(tiktokUri),
                    icon: const FaIcon(
                      FontAwesomeIcons.tiktok,
                      color: Color(0xFFEEDFC8),
                    ),
                    tooltip: 'TikTok',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                '2026 Bean Basket Garden Cafe. Crafted for web visitors.',
                style: TextStyle(color: Color(0xFFCCB49A)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
