import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:tabelogshops/extensions/context.dart';
import 'package:tabelogshops/view/components/animation/slide_animation.dart';
import 'package:tabelogshops/view/components/map.dart';

class ShopsScreen extends ConsumerStatefulWidget {
  const ShopsScreen({Key? key}) : super(key: key);

  @override
  ShopsScreenState createState() => ShopsScreenState();
}

class ShopsScreenState extends ConsumerState<ShopsScreen> {
  late PanelController panelController;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('店舗一覧'),
      ),
      bottomNavigationBar: const _BottomNavigationBar(),
      body: SlidingUpPanel(
        panelBuilder: _ListView.new,
        controller: panelController,
        maxHeight: context.deviceHeight -
            AppBar().preferredSize.height -
            context.topSafeArea,
        minHeight: panelMinHeight,
        color: Colors.transparent,
        backdropColor: Colors.transparent,
        body: ShopsMap(
          safeAreaHeight: context.topSafeArea + context.bottomSafeArea,
        ),
        parallaxEnabled: true,
        parallaxOffset: .5,
        snapPoint: 0.4,
        onPanelClosed: () {
          ref.read(openAtProvider.notifier).state = DateTime.now();
        },
      ),
    );
  }
}

const double panelMinHeight = 100;

class _ListView extends StatelessWidget {
  const _ListView(this.controller);

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        for (var i = 0; i < 100; i++)
          Card(
            color: i.isEven
                ? Colors.red.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
            child: ListTile(
              title: Text('店舗名（${i + 1}）'),
            ),
          ),
      ],
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        for (final _ in [1, 1, 1])
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'test',
          ),
      ],
    );
  }
}
