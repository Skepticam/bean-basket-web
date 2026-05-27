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

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: (VisibilityInfo info) {
        if (_revealed || info.visibleFraction < widget.threshold) {
          return;
        }

        if (mounted) {
          setState(() => _revealed = true);
        }
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
