import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      // length: TABS.length * 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 4.0,
                  // indicatorSize: TabBarIndicatorSize.tab,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  // isScrollable: false, // 갯수가 많아지면 뭉개짐
                  tabAlignment: TabAlignment.center,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                  tabs: TABS
                  // [
                  //       ...TABS,
                  //       ...TABS,
                  //       ...TABS,
                  //     ]
                      .map(
                        (e) => Tab(
                      icon: Icon(e.icon),
                      child: Text(
                        e.label,
                      ),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          // physics: NeverScrollableScrollPhysics(),
          children: TABS
              // [
              //       ...TABS,
              //       ...TABS,
              //       ...TABS,
              //     ]
              .map(
                (e) => Center(
                  child: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
