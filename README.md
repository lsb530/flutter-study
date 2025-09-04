# TabBar Theory

## Study
대표적으로 2가지 방식 존재
1. `DefaultTabController를` 최상위 위젯으로 감싸고, `TabBar`와 `TabBarView`를 사용
   * TabBar는 `AppBar`의 `bottom` 속성 또는 `Scaffold`의 `bottomNavigationBar` 둘 다 사용 가능
2. `StatefulWidget`으로 변환 후 `with TickerProviderStateMixin`를 클래스에 추가하고,
   `late final TabController`을 선언 후 `initState()`에서 인스턴스 주입 및 `setState(){}`를 해주기 위한`addListener`추가

## Debug
1)Error Message:
```text
======== Exception caught by scheduler library =====================================================
The following assertion was thrown during a scheduler callback:
Controller's length property (5) does not match the number of tabs (0) present in TabBar's tabs property.
```

Code:
```dart
import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: TabBar(tabs: []),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
```

<br/>
Cause: TabBar의 개수(0)와 length(5)가 일치하지 않아서 발생
<br/>

Solve:
```dart
import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('BasicAppBarScreen'),
          bottom: TabBar(
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
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
```

<br/>

2)Error Message:
```text
======== Exception caught by widgets library =======================================================
The following assertion was thrown building KeyedSubtree-[GlobalKey#676bb]:
No TabController for TabBarView.
```

Code:
```dart
import 'package:flutter/material.dart';
import 'package:tabbar_theory/const/tabs.dart';

class AppbarUsingControllerScreen extends StatelessWidget {
  const AppbarUsingControllerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Using Controller'),
      ),
      body: TabBarView(
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
```

<br/>
Cause: TabBarView에 대한 Controller가 존재하지 않아서 발생
<br/>

Solve:
```dart
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
```