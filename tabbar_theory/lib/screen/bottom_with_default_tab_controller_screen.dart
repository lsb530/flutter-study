import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BottomWithDefaultTabControllerScreen extends StatelessWidget {
  const BottomWithDefaultTabControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.grey,
        //   showSelectedLabels: true,
        //   showUnselectedLabels: true,
        //   // currentIndex: controller.index,
        //   type: BottomNavigationBarType.fixed,
        //   items: TABS
        //       .map(
        //         (e) => BottomNavigationBarItem(
        //           icon: Icon(
        //             e.icon,
        //           ),
        //           label: e.label,
        //         ),
        //       )
        //       .toList(),
        // ),
        bottomNavigationBar: TabBar(
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
        appBar: AppBar(
          title: Text('Bottom TabBar'),
        ),
        body: TabBarView(
          children: TABS
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
