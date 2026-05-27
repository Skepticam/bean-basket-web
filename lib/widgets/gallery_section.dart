import 'package:flutter/material.dart';

class GallerySection extends StatefulWidget {
  const GallerySection({super.key});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final PageController _mobileController = PageController();
  int _mobileIndex = 0;

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  static const List<String> imageUrls = <String>[
    'https://picsum.photos/id/1060/1200/900',
    'https://picsum.photos/id/292/1200/900',
    'https://picsum.photos/id/433/1200/900',
    'https://picsum.photos/id/425/1200/900',
    'https://picsum.photos/id/431/1200/900',
    'https://picsum.photos/id/766/1200/900',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Cafe Gallery',
              style: Theme.of(
                context,
              ).textTheme.displayMedium?.copyWith(fontSize: 40),
            ),
            const SizedBox(height: 10),
            Text(
              'A look at the garden mood, signature drinks, and cozy corners.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth < 700) {
                  return Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AspectRatio(
                          aspectRatio: 1.1,
                          child: PageView.builder(
                            controller: _mobileController,
                            itemCount: imageUrls.length,
                            onPageChanged: (int index) {
                              setState(() => _mobileIndex = index);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                imageUrls[index],
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (
                                      BuildContext context,
                                      Object error,
                                      StackTrace? stackTrace,
                                    ) {
                                      return Container(
                                        color: const Color(0xFFEEDFC8),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.photo_camera_back_rounded,
                                          color: Color(0xFF5C3D2E),
                                          size: 48,
                                        ),
                                      );
                                    },
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              final int next =
                                  (_mobileIndex - 1 + imageUrls.length) %
                                  imageUrls.length;
                              _mobileController.animateToPage(
                                next,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                              );
                            },
                            icon: const Icon(Icons.chevron_left_rounded),
                          ),
                          ...List<Widget>.generate(imageUrls.length, (
                            int index,
                          ) {
                            final bool active = _mobileIndex == index;
                            return GestureDetector(
                              onTap: () {
                                _mobileController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeOutCubic,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                width: active ? 20 : 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: active
                                      ? const Color(0xFF5C3D2E)
                                      : const Color(0x555C3D2E),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            onPressed: () {
                              final int next =
                                  (_mobileIndex + 1) % imageUrls.length;
                              _mobileController.animateToPage(
                                next,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeOutCubic,
                              );
                            },
                            icon: const Icon(Icons.chevron_right_rounded),
                          ),
                        ],
                      ),
                    ],
                  );
                }

                int count = 2;
                if (constraints.maxWidth >= 1050) {
                  count = 3;
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: imageUrls.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 1.1,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 450 + (index * 70)),
                        builder:
                            (
                              BuildContext context,
                              double value,
                              Widget? child,
                            ) {
                              return Opacity(
                                opacity: value,
                                child: Transform.scale(
                                  scale: 0.95 + (0.05 * value),
                                  child: child,
                                ),
                              );
                            },
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                          errorBuilder:
                              (
                                BuildContext context,
                                Object error,
                                StackTrace? stackTrace,
                              ) {
                                return Container(
                                  color: const Color(0xFFEEDFC8),
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.photo_camera_back_rounded,
                                    color: Color(0xFF5C3D2E),
                                    size: 48,
                                  ),
                                );
                              },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
