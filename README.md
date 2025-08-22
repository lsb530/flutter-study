# BuildContext Theory

## Tip
- BuildContext는 위젯 트리에서의 위젯의 위치 정보를 갖고 있다.
- StatelessWidget과 StatefulWidget은 모두 Widget을 상속 받는다.
- Widget 클래스 정의에는 createElement() 함수가 있다.
- 사실, Widget Tree는 Element가 각각의 Node이고 서로 연결되어 있는 형태이다.
- Element는 Widget, 부모, 자식, 크기, 위젯 트리에서 어디에 어떻게 그려져야 되는지, 뭘 그려야 되는지에 대한 정보를 갖고 있다.
- Element는 BuildContext를 구현한다.
  - ```dart
    abstract class Element extends DiagnosticableTree implements BuildContext {
      // ..
    }
    ```

## Think
- Q. 하나의 위젯은 자신이 위젯 트리의 어디에 위치하고 있는지 어떻게 알까?
  - A. 위젯 자체는 이 정보를 갖고 있지 않다.
- Q. createElement()란?
  - A. Element를 생성함. Element 내부에는 widget, parent, children, size, Render Object 등의 정보가 있다.