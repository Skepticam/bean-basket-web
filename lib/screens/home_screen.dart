import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';
import '../widgets/about_section.dart';
import '../widgets/featured_product_section.dart';
import '../widgets/footer_widget.dart';
import '../widgets/gallery_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/location_section.dart';
import '../widgets/menu_section.dart';
import '../widgets/navbar.dart';
import '../widgets/reveal_on_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  bool _headerVisible = false;
  bool _useSmoothWheel = false;
  double? _wheelTargetOffset;
  DateTime? _lastWheelEventAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() => _headerVisible = true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  static final Uri _foodpandaWebUri = Uri.parse(
    'https://www.foodpanda.ph/restaurant/fvpk/bean-basket-cafe-nursery-road',
  );
  static final Uri _foodpandaAppUri = Uri.parse(
    'foodpanda://restaurant/fvpk/bean-basket-cafe-nursery-road',
  );

  Future<void> _openOrderLink() async {
    final List<Uri> candidates = kIsWeb
        ? <Uri>[_foodpandaWebUri]
        : <Uri>[_foodpandaAppUri, _foodpandaWebUri];

    for (final Uri candidate in candidates) {
      if (await canLaunchUrl(candidate) &&
          await launchUrl(candidate, mode: LaunchMode.platformDefault)) {
        return;
      }
    }

    await launchUrl(_foodpandaWebUri, mode: LaunchMode.platformDefault);
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final BuildContext? context = key.currentContext;
    if (context == null) {
      return;
    }

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _handleSectionTap(String sectionId) async {
    switch (sectionId) {
      case 'about':
        await _scrollTo(_aboutKey);
      case 'menu':
        await _scrollTo(_menuKey);
      case 'gallery':
        await _scrollTo(_galleryKey);
      case 'location':
        await _scrollTo(_locationKey);
    }
  }

  bool _shouldUseSmoothWheel(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.windows:
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  void _handlePointerSignal(PointerSignalEvent signal) {
    if (!_useSmoothWheel ||
        signal is! PointerScrollEvent ||
        !_scrollController.hasClients) {
      return;
    }

    final ScrollPosition position = _scrollController.position;
    final double delta = signal.scrollDelta.dy;
    if (delta == 0) {
      return;
    }

    final DateTime now = DateTime.now();
    if (_lastWheelEventAt == null ||
        now.difference(_lastWheelEventAt!) >
            const Duration(milliseconds: 140)) {
      _wheelTargetOffset = position.pixels;
    }
    _lastWheelEventAt = now;

    final double step = (delta * 0.68).clamp(-220, 220).toDouble();
    final double base = _wheelTargetOffset ?? position.pixels;
    final double next = (base + step).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    _wheelTargetOffset = next;

    _scrollController.animateTo(
      next,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    _useSmoothWheel = _shouldUseSmoothWheel(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.cream,
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: <Widget>[
              const Text(
                'Navigate',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  _handleSectionTap('about');
                },
              ),
              ListTile(
                title: const Text('Menu'),
                onTap: () {
                  Navigator.pop(context);
                  _handleSectionTap('menu');
                },
              ),
              ListTile(
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _handleSectionTap('gallery');
                },
              ),
              ListTile(
                title: const Text('Location'),
                onTap: () {
                  Navigator.pop(context);
                  _handleSectionTap('location');
                },
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  _openOrderLink();
                },
                child: const Text('Order Now'),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          AnimatedOpacity(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            opacity: _headerVisible ? 1 : 0,
            child: BeanNavBar(
              items: const <NavItem>[
                NavItem(label: 'About', sectionId: 'about'),
                NavItem(label: 'Menu', sectionId: 'menu'),
                NavItem(label: 'Gallery', sectionId: 'gallery'),
                NavItem(label: 'Location', sectionId: 'location'),
              ],
              onTap: _handleSectionTap,
              onOrderNow: _openOrderLink,
              onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
          Expanded(
            child: Listener(
              onPointerSignal: _handlePointerSignal,
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: _useSmoothWheel
                    ? const NeverScrollableScrollPhysics()
                    : null,
                child: Column(
                  children: <Widget>[
                    RevealOnScroll(
                      threshold: 0.01,
                      offset: const Offset(0, 0.03),
                      child: HeroSection(
                        scrollController: _scrollController,
                        onViewMenu: () => _handleSectionTap('menu'),
                        onDirections: () => _handleSectionTap('location'),
                      ),
                    ),
                    Container(
                      key: _aboutKey,
                      child: const RevealOnScroll(
                        offset: Offset(0.08, 0),
                        child: AboutSection(),
                      ),
                    ),
                    const RevealOnScroll(
                      delay: Duration(milliseconds: 120),
                      offset: Offset(0, 0.06),
                      child: FeaturedProductSection(),
                    ),
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFF6EFE6),
                      child: Container(
                        key: _menuKey,
                        child: const RevealOnScroll(
                          offset: Offset(-0.08, 0),
                          child: MenuSection(),
                        ),
                      ),
                    ),
                    Container(
                      key: _galleryKey,
                      child: const RevealOnScroll(
                        delay: Duration(milliseconds: 100),
                        child: GallerySection(),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFF6EFE6),
                      child: Container(
                        key: _locationKey,
                        child: const RevealOnScroll(
                          delay: Duration(milliseconds: 100),
                          offset: Offset(0, 0.08),
                          child: LocationSection(),
                        ),
                      ),
                    ),
                    FooterWidget(
                      onAbout: () => _handleSectionTap('about'),
                      onMenu: () => _handleSectionTap('menu'),
                      onGallery: () => _handleSectionTap('gallery'),
                      onLocation: () => _handleSectionTap('location'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
