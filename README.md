# FutureBuilder, StreamBuilder Study

## Study
### FutureBuilder
- FutureBuilder와 AsyncSnapshot를 그냥 사용하는 것 보다, 반환값을 제네릭으로 래핑하자.
```dart
// as-is
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getNumber(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: Text(''),
          );
        },
      ),
    );
  }

  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));

    final random = Random();

    return random.nextInt(100);
  }
}

// to-be
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: getNumber(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            child: Text(''),
          );
        },
      ),
    );
  }
  
  // 동일
}
```

- FutureBuilder는 data 캐싱 기능을 갖고 있다.
### FutureBuilder
- connectionState(ConnectionState)의 종류 및 상태 설명
  1. none    : Future가 입력되지 않은 상태
  2. active  : Stream에서만 존재
  3. done    : Future가 종료되었을 때
  4. waiting : 실행 중

### StreamBuilder
- connectionState(ConnectionState)의 종류 및 상태 설명
  1. none    : Stream이 입력되지 않은 상태
  2. active  : Stream이 연결되고, 이벤트를 수신 중인 상태(실행 중)
  3. done    : Stream이 종료되었을 때
  4. waiting : Stream에 연결되었지만 아직 이벤트를 받지 못한 상태