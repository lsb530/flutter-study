import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppbarUsingControllerScreen extends StatefulWidget {
  const AppbarUsingControllerScreen({super.key});

  @override
  State<AppbarUsingControllerScreen> createState() =>
      _AppbarUsingControllerScreenState();
}

class _AppbarUsingControllerScreenState
    extends State<AppbarUsingControllerScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: TABS.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Using Controller'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (e) => Tab(
                  icon: Icon(
                    e.icon,
                  ),
                  child: Text(e.label),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (e) => Center(
                child: Icon(
                  e.icon,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
