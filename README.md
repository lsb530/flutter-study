# Flutter Study Repository

## branch별로 작업
- Total commit counts: 357
- CLI: `git rev-list --all --count`

## create flutter project for only mobile without linux, macos, windows, web
```shell
flutter create --platforms ios,android [프로젝트 이름]
```

## formatter
- analysis_options.yaml
append this under include..
```yaml
formatter:
  trailing_commas: preserve
  page_width: 80
```

## boiler plate
- main.dart
```dart
import 'package:[프로젝트명]/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```
- screen/home_screen.dart
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
```