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

  double _scrollOffset = 0;
  bool _headerVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() => _headerVisible = true);
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  static final Uri orderUri = Uri.parse(
    'https://www.google.com/maps/place/Bean+Basket+Garden+Cafe/',
  );

  Future<void> _openOrderLink() async {
    await launchUrl(orderUri, mode: LaunchMode.platformDefault);
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

  @override
  Widget build(BuildContext context) {
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
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: <Widget>[
                  RevealOnScroll(
                    threshold: 0.01,
                    offset: const Offset(0, 0.03),
                    child: HeroSection(
                      scrollOffset: _scrollOffset,
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
                  const RevealOnScroll(
                    delay: Duration(milliseconds: 120),
                    offset: Offset(0, 0.06),
                    child: FeaturedProductSection(),
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
        ],
      ),
    );
  }
}
