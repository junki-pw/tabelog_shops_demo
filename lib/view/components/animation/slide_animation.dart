import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final switchTileProvider = StateProvider<bool>((ref) => false);
final openAtProvider = StateProvider<DateTime>((ref) => DateTime.now());
final closeAtProvider = StateProvider<DateTime>((ref) => DateTime.now());

class ShopsHorizontalTilesAnimation extends ConsumerStatefulWidget {
  const ShopsHorizontalTilesAnimation({
    required this.safeAreaHeight,
    required this.child,
    super.key,
  });

  /// Stack 上に widget がある場合は safeArea の top, bottom 共に
  /// height が 0 になってしまうから引数で受け取る
  final double safeAreaHeight;
  final Widget child;

  @override
  ShopsHorizontalTilesAnimationState createState() =>
      ShopsHorizontalTilesAnimationState();
}

class ShopsHorizontalTilesAnimationState
    extends ConsumerState<ShopsHorizontalTilesAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(switchTileProvider, (previous, next) {
      if (previous != next) {
        _toggleAnimation();
      }
    });

    ref.listen(openAtProvider, (previous, next) {
      if (previous != next) {
        _controller.forward();
      }
    });

    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.delta.dy > 0) {
              ref.read(switchTileProvider.notifier).state = false;
            }
          },
          child: widget.child,
        ),
      ),
    );
  }
}
