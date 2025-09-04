# Dusty dust - 미세먼지 확인 앱

## Goals
- HTTP Request
- CustomScrollView
- Caching
- Open API - [공공데이터포털(https://www.data.go.kr/)](https://www.data.go.kr/)
  - 에어코리아 미세먼지 -> 한국환경공단_에어코리아_대기오염통계 현황 -> 시도별 실시간 평균정보 조회
- DotENV
- Isar
- Drawer

![app.gif](dusty_dust/img/app.gif)


## Isar - NoSQL
```dart
part 'stat_model.g.dart';

@collection
class StatModel {
  Id id = Isar.autoIncrement;

  // 지역
  @enumerated
  @Index(unique: true, composite: [
    CompositeIndex('dateTime'),
    CompositeIndex('itemCode'),
  ])
  final Region region;

  // 통계 값
  final double stat;

  // 날짜
  final DateTime dateTime;

  // 미세먼지 & 초미세먼지
  @enumerated
  final ItemCode itemCode;
}
```

#### code generate
```shell
  dart run build_runner build
```

## Tips
#### Align center
1. wrap with `SizedBox`
2. width: `double.infinity`

#### Use Parent or Ancestor Widgets's width/height
1. wrap with `LayoutBuilder`
2. use `constraints.maxXXX/minXXX` / 3 <br/> 
   instead of `width: MediaQuery.of(context).size.width / 3`

#### Default AppBar's height
- `kToolbarHeight`

## Debug
#### ListView - Failed assertion: line 2251 pos 12: 'hasSize' 
`scrollDirection: Axis.horizontal`

## initialize Main
Error Message:
```text
[ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: Binding has not yet been initialized.
The "instance" getter on the ServicesBinding binding mixin is only available once that binding has been initialized.
Typically, this is done by calling "WidgetsFlutterBinding.ensureInitialized()" or "runApp()" (the latter calls the former).
```
fix:
```dart
void main() async {
  /// 추가
  WidgetsFlutterBinding.ensureInitialized();
  
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [StatModelSchema],
    directory: dir.path,
  );

  await dotenv.load(fileName: '.env');
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'sunflower'),
      home: HomeScreen(),
    ),
  );
}

```

## Domain Information
#### 수치 데이터
```text
1) 최고
  - 미세먼지(PM10):   0~15
  - 초미세먼지(PM25):  0~8
  - 오존(O3):       0~0.02
  - 이산화질소(NO2): 0~0.02
  - 일산화탄소(CO): 0~0.02
  - 아황산가스(SO2): 0~0.01

  2) 좋음
  - 미세먼지(PM10):   16~30
  - 초미세먼지(PM25):  9~15
  - 오존(O3):       0.02~0.03
  - 이산화질소(NO2): 0.02~0.03
  - 일산화탄소(CO): 1~2
  - 아황산가스(SO2): 0.01~0.02

  3) 양호
  - 미세먼지(PM10):   31~40
  - 초미세먼지(PM25):  16~20
  - 오존(O3):       0.03~0.06
  - 이산화질소(NO2): 0.03~0.05
  - 일산화탄소(CO): 2~5.5
  - 아황산가스(SO2): 0.02~0.04

  4) 보통
  - 미세먼지(PM10):   41~50
  - 초미세먼지(PM25):  21~25
  - 오존(O3):       0.06~0.09
  - 이산화질소(NO2): 0.05~0.06
  - 일산화탄소(CO): 5.5~9
  - 아황산가스(SO2): 0.04~0.05

  5) 나쁨
  - 미세먼지(PM10):   51~75
  - 초미세먼지(PM25):  26~37
  - 오존(O3):       0.09~0.12
  - 이산화질소(NO2): 0.06~0.13
  - 일산화탄소(CO): 9~12
  - 아황산가스(SO2): 0.05~0.1

  6) 상당히 나쁨
  - 미세먼지(PM10):   76~100
  - 초미세먼지(PM25):  38~50
  - 오존(O3):       0.12~0.15
  - 이산화질소(NO2): 0.13~0.2
  - 일산화탄소(CO): 12~15
  - 아황산가스(SO2): 0.1~0.15

  7) 매우 나쁨
  - 미세먼지(PM10):   101~150
  - 초미세먼지(PM25):  51~75
  - 오존(O3):       0.15~0.38
  - 이산화질소(NO2): 0.2~1.1
  - 일산화탄소(CO): 15~32
  - 아황산가스(SO2): 0.15~0.16

 8) 최악
  - 미세먼지(PM10):   151~
  - 초미세먼지(PM25):  76~
  - 오존(O3):       0.38~
  - 이산화질소(NO2): 1.1~
  - 일산화탄소(CO): 32~
  - 아황산가스(SO2): 0.16~
```