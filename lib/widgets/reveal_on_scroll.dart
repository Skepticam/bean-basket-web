import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offset = const Offset(0, 0.08),
    this.threshold = 0.12,
  });

  final Widget child;
  final Duration delay;
  final Offset offset;
  final double threshold;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _revealed = false;
  final Key _detectorKey = UniqueKey();
  Timer? _revealTimer;
  Timer? _fallbackTimer;

  @override
  void initState() {
    super.initState();
    _fallbackTimer = Timer(
      widget.delay + const Duration(milliseconds: 1500),
      _reveal,
    );
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    _fallbackTimer?.cancel();
    super.dispose();
  }

  void _reveal() {
    if (!mounted || _revealed) {
      return;
    }
    setState(() => _revealed = true);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: (VisibilityInfo info) {
        if (_revealed || info.visibleFraction < widget.threshold) {
          return;
        }

        _revealTimer?.cancel();
        if (widget.delay == Duration.zero) {
          _reveal();
          return;
        }

        _revealTimer = Timer(widget.delay, _reveal);
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 640),
        curve: Curves.easeOutCubic,
        opacity: _revealed ? 1 : 0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 640),
          curve: Curves.easeOutCubic,
          offset: _revealed ? Offset.zero : widget.offset,
          child: widget.child,
        ),
      ),
    );
  }
}
