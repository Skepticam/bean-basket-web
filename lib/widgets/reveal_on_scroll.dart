import 'dart:async';
import 'dart:math' as math;

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
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndMaybeReveal();
    });
    _pollTimer = Timer.periodic(
      const Duration(milliseconds: 220),
      (_) => _checkAndMaybeReveal(),
    );
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    _pollTimer?.cancel();
    super.dispose();
  }

  void _reveal() {
    if (!mounted || _revealed) {
      return;
    }
    setState(() => _revealed = true);
    _pollTimer?.cancel();
  }

  void _checkAndMaybeReveal() {
    if (!mounted || _revealed) {
      return;
    }

    final BuildContext localContext = context;
    final RenderObject? renderObject = localContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final double widgetTop = renderObject.localToGlobal(Offset.zero).dy;
    final double widgetHeight = renderObject.size.height;
    if (widgetHeight <= 0) {
      return;
    }

    final double widgetBottom = widgetTop + widgetHeight;
    final double viewportTop = 0;
    final double viewportBottom = MediaQuery.sizeOf(localContext).height;
    final double visiblePixels =
        math.min(widgetBottom, viewportBottom) -
        math.max(widgetTop, viewportTop);
    final double visibleFraction = (visiblePixels / widgetHeight).clamp(0, 1);

    if (visibleFraction < widget.threshold) {
      return;
    }

    _scheduleReveal();
  }

  void _scheduleReveal() {
    if (_revealed) {
      return;
    }

    _revealTimer?.cancel();
    if (widget.delay == Duration.zero) {
      _reveal();
      return;
    }

    _revealTimer = Timer(widget.delay, _reveal);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: (VisibilityInfo info) {
        if (_revealed || info.visibleFraction < widget.threshold) {
          return;
        }
        _scheduleReveal();
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
