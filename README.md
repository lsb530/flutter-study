# Scrollable Widget Theory

### Tip
* 모든 List 또는 Scroll 가능한 Widget들은 Column의 children 안에 넣었을 때 Expanded를 해주지 않으면 에러가 발생한다.
  * Vertical viewport was given unbounded height.
  * If this widget is always nested in a scrollable widget there is no need to use a viewport because there will always be enough vertical space for the children. In this case, consider using a Column or Wrap instead. Otherwise, consider using a CustomScrollView to concatenate arbitrary slivers into a single scrollable.
```dart
/// Problem
@override
Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(children: rainbowColors.map((e) => renderContainer(color: e, index: 1)).toList())
        ],
      ),
    );
}

/// Solved
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: ListView(
              children: rainbowColors.map((e) => renderContainer(color: e, index: 1)).toList()
          ),
        ),
      ],
    ),
  );
}
```

### Study
#### `SingleChildScrollView` - 단일 스크롤 뷰(child). 최적화 X
1. 자식 위젯의 크기가 화면을 채우지 않았다면 Scroll이 되지 않는다.
2. 하지만, 자식 위젯의 크기(높이)가 화면을 넘어가면 그때서야 Scroll이 가능하게 된다.
3. `physics` 속성을 조작하면 1번에서 설명한 기본 방식을 변경하여 스크롤이 가능하게 만들 수 있다.
   * `NeverScrollableScrollPhysics` - 스크롤 X, 기본값
   * `AlwaysScrollableScrollPhysics` - 스크롤 O
   * `BouncingScrollPhysics` - iOS 스타일
   * `ClampingScrollPhysics` - Android 스타일
4. `clipBehavior` 속성을 조작하면 스크롤을 했을 때 크기 이상으로 잘리지 않거나 잘리도록 변경할 수 있다.
5. lazy render를 지원하지 않는다. 화면을 넘어가더라도 child의 모든 widget을 렌더링한다.

<br/>

#### `ListView` - 리스트 뷰(children). builder/separated는 최적화 O
1. `ListView()` - 모두 한번에 렌더링(화면에 보이지 않아도, SingleChildScrollView와 같은 렌더링 방식)
2. `ListView.builder(itemCount: , itemBuilder: ..)` - 보이는 것만 렌더링  
3. `ListView.separated(itemCount: , itemBuilder: .., separatorBuilder: ..)` - 2번 + 중간 중간에 위젯 추가 가능 

<br/>

#### `GridView` - 갯수 또는 크기에 따라 좌->우/상->하로 그리드 배치. builder는 최적화 O
1. `GridView.count(crossAxisCount: ..)` - 한 번에 다 렌더링! 성능 최적화 X
2. `GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(), itemBuilder: ..` - 화면에 보이는 것만 렌더링. 가로로 그릴 개수 지정, 주로 사용하는 GridView. 성능 최적화 O
3. `GridView.builder(girdDelegate: SliverGridDelegateWithMaxCrossAxisExtent(), itemBuilder: ..` - 화면에 보이는 것만 렌더링. 가로로 그릴 최대 사이즈 지정, 성능 최적화 O

<br/>

#### `ReorderableListView` - 꾹 눌러서 위젯의 순서를 바꿀 수 있음 with StatefulWidget. 위젯에는 항상 유일한 key 프로퍼티가 있어야 함
1. `ReorderableListView(onReorder: (int oldIndex, int newIndex) {..})` - 기본. onReorder를 꼭 구현해줘야 함. 최적화 X
2. `ReorderableListView.builder(itemCount: .., itemBuilder: (context, index) { .. }, onReorder: (int oldIndex, int newIndex) { .. }` - index의 참조값에 따라 위젯의 속성을 변경하거나 유지할 수 있다. 최적화 O

<br/>

#### `CustomScrollView` - 여러 Scroll가능한 Widget들을 혼합하여 사용하고 싶을 경우. 하위로 slivers 프로퍼티에 Sliver로 시작하는 위젯들을 리스트로 정의해줘야 함(ex: 그냥 ListView 추가하면 에러 발생), SliverAppBar까지 스크롤 가능하고, 스크롤되면 사라짐
1. `SliverList(delegate: (SliverChildListDelegate || SliverChildBuilderDelegate))` - delegate값으로 한 번에 다 렌더링하는 SliverChildListDelegate 또는 최적화가 필요할 때 쓰는 SliverChildBuilderDelegate을 취사선택해서 사용 가능
2. `SliverGrid(delete: ..., gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount || SliverGridDelegateWithMaxCrossAxisExtent))` - delegate에는 1번과 같은 2가지 타입을 그대로 넣을 수 있고, gridDelegate에 따라 GridView.count 혹은 GridView.builder와 유사형태로 사용 가능
3. `SliverAppBar` - 최상단 앱 바
   * pinned - 고정된 상태로 나옴(기본값: false)
   * floating - 아래로 스크롤할때는 사라지다가 위로 스크롤 할때는 생김(기본값: false)
   * snap - 자석효과. false일때는 애니메이션이 사라져서 중간 크기 렌더링 가능(floating true여야만 효과를 볼 수 있음)
   * stretch - 맨 위에서 한계 이상으로 스크롤 할 경우 남는 공간을 차지(기본값: false)
   * expandedHeight - 기본 높이(확장된)
   * collapsedHeight - 닫힐 때의 높이(작으면 더 빨리 닫힘)
   * flexibleSpace - 닫힐 때 공간을 차지할 것(위젯도 넣을 수 있음)
4. `SliverPersistentHeader` - 앱 바 하위의 헤더 위젯
   * pinned: 스크롤이 내려갔을 때 헤더를 고정시킴
   * minHeight: 최소 높이
   * maxHeight: 최대 높이
   * delegate: SliverPersistentHeaderDelegate을 상속받는 클래스 및 4개의 메서드 재정의 <br/>
     ```dart
     class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
        final Widget child;
        final double maxHeight;
        final double minHeight;
        
        _SliverFixedHeaderDelegate({
          required this.child,
          required this.maxHeight,
          required this.minHeight,
        });
        
        @override
        Widget build(
          BuildContext context,
          double shrinkOffset,
          bool overlapsContent,
        ) {
          return SizedBox.expand(
            child: child,
          );
        }
        
        @override // 최대 높이
        double get maxExtent => maxHeight;
        
        @override // 최소 높이
        double get minExtent => minHeight;
        
        @override
        // covariant -> 상속된 클래스도 사용가능
        // oldDelegate -> build가 실행이 됐을 때 이전 Delegate
        // this -> 새로운 delegate
        // shouldRebuild -> 새로 build를 해야할지 말지 결정
        // ㄴfalse: 빌드 X, true: 빌드 O
        // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
        bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
          return oldDelegate.minHeight != minHeight ||
            oldDelegate.maxHeight != maxHeight ||
            oldDelegate.child != child;
          }
        }
     ```

<br/>

#### `Scrollbar` - 어디까지 스크롤했는지 알려주는 우측 스크롤 바 
1. `thickness` - 두께 조절
2. `radius` - 둥글게 만들기
3. `child` - 자식 위젯으로 Scrollable Widget을 둬야 함(ex: SingleChildScrollView)

<br/>

#### `RefreshIndicator` - 아래로 스크롤 했을 때 새로 데이터를 받아오면서 로딩 애니메이션을 보여줄 때 사용(ex: 인스타그램, 스레드, 페이스북)
1. `onRefresh()` - 새로고침할때 요청할 메서드(보통 서버로 api 요청 후 setState)