import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AutoImageCarousel extends StatefulWidget {
  const AutoImageCarousel({
    super.key,
    required this.title,
    required this.images,
    this.interval = const Duration(seconds: 4),
  });

  final String title;
  final List<String> images;
  final Duration interval;

  @override
  State<AutoImageCarousel> createState() => _AutoImageCarouselState();
}

class _AutoImageCarouselState extends State<AutoImageCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || widget.images.isEmpty) {
        return;
      }
      final int next = (_current + 1) % widget.images.length;
      _goTo(next);
    });
  }

  void _goTo(int index) {
    if (!_controller.hasClients) {
      return;
    }
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
    setState(() => _current = index);
  }

  void _next() => _goTo((_current + 1) % widget.images.length);

  void _prev() =>
      _goTo((_current - 1 + widget.images.length) % widget.images.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x225C3D2E)),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 20),
                  ),
                ),
                IconButton(
                  tooltip: 'Previous',
                  onPressed: _prev,
                  icon: const Icon(Icons.chevron_left_rounded),
                ),
                IconButton(
                  tooltip: 'Next',
                  onPressed: _next,
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (int value) {
                  setState(() => _current = value);
                  _startAutoSlide();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    widget.images[index],
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
                              Icons.photo,
                              size: 44,
                              color: AppTheme.coffeeBrown,
                            ),
                          );
                        },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(widget.images.length, (
                int index,
              ) {
                final bool active = _current == index;
                return GestureDetector(
                  onTap: () => _goTo(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: active ? 22 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
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
          ),
        ],
      ),
    );
  }
}
