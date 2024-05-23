import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tabelogshops/extensions/context.dart';
import 'package:tabelogshops/view/components/animation/slide_animation.dart';
import 'package:tabelogshops/view/shops.dart';

class ShopsMap extends StatelessWidget {
  const ShopsMap({super.key, required this.safeAreaHeight});

  final double safeAreaHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// マップ
        _Map(safeAreaHeight),

        /// リスト
        _HorizontalList(safeAreaHeight),
      ],
    );
  }
}

class _Map extends ConsumerWidget {
  const _Map(this.safeAreaHeight);

  final double safeAreaHeight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double mapHeight = context.deviceHeight -
        (context.appBarHeight + safeAreaHeight + kBottomNavigationBarHeight);

    return InkWell(
      onTap: () {
        ref.read(switchTileProvider.notifier).state = true;
      },
      child: Container(
        width: context.deviceWidth,
        height: mapHeight,
        color: Colors.green,
        child: const Center(
          child: Text('Google Map'),
        ),
      ),
    );
  }
}

const double tileHeight = 100;
const double spacing = 10;

class _HorizontalList extends StatelessWidget {
  const _HorizontalList(this.safeAreaHeight);

  final double safeAreaHeight;

  @override
  Widget build(BuildContext context) {
    final double bottom = safeAreaHeight +
        context.appBarHeight +
        kBottomNavigationBarHeight +
        panelMinHeight;

    return Positioned(
      bottom: bottom,
      child: ShopsHorizontalTilesAnimation(
        safeAreaHeight: context.bottomSafeArea + context.topSafeArea,
        child: Container(
          width: context.deviceWidth,
          height: tileHeight + spacing,
          margin: const EdgeInsets.only(bottom: spacing),
          child: PageView(
            controller: PageController(viewportFraction: 0.8),
            scrollDirection: Axis.horizontal,
            children: [
              for (var i = 0; i < 10; i++)
                Container(
                  height: tileHeight,
                  width: 100,
                  color: i.isEven ? Colors.red : Colors.blue,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
