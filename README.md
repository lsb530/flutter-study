# Constraint Theory

## Goals
- Single Pass
- Constraints Go Down
- Sizes Go Up
- Parent Sets Position

### Property
1. Max Height
2. Min Height
3. Max Width
4. Min Width

### Constraints
- 자식 위젯은 부모 위젯이 제한하고 있는 constraint 내부에서만 크기를 가져갈 수 있다.
- 위젯의 위치는 부모 위젯이 지정하기 때문에 위젯은 자신이 정확히 어디에 위치될지 알 수 없다.(플러터에서 x,y 좌표로 위젯을 배치하지 않는 이유)
- 중요)자식 위젯이 어디에 정렬되어야 하는지 정확히 알 수 없는 경우에는, 자식 위젯의 크기가 무시될 수 있다.