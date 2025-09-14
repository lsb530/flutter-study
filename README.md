# Riverpod Study - v1

## Dependency

```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.8
  flutter_riverpod: ^1.0.4 # add
```

## Provider의 종류

- Provider
- StateProvider
- StateNotifierProvider
- FutureProvider
- StreamProvider
- ChangeNotifierProvider(x - to migrate Provider)

## Table

|      Provider 종류      |           반환값           |        사용예제        |
|:---------------------:|:-----------------------:|:------------------:|
|       Provider        |          모든 타입          |       데이터 캐싱       |
|     StateProvider     |          모든 타입          |     간단한 상태값 관리     |
| StateNotifierProvider | StateNotifier를 상속한 값 반환 |     복잡한 상태값 관리     |
|    FutureProvider     |        Future 타입        | API 요청의 Future 결과값 |
|    StreamProvider     |        Stream 타입        | API 요청의 Stream 결과값 |

## ref.read vs ref.watch
`ref.read`
- 실행되는 순간 단 한번만 provider 값을 가져온다.
- onPressed 콜백처럼 특정 액션 뒤에 실행되는 함수 내부에서 사용된다.
  
`ref.watch`
- 반환값의 업데이트가 있을 때 지속적으로 build 함수를 다시 실행해준다.
- 필수적으로 UI 관련 코드에만 사용한다.

## Usage

### Wrap Main

```dart
void main() {
  runApp(

    /// ProviderScope
    ProviderScope(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
```

### Create Provider

### Use Provider
