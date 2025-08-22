import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              // onPressed: null, // disabled
              style: ElevatedButton.styleFrom(
                // 배경 색상
                backgroundColor: Colors.red,
                disabledBackgroundColor: Colors.grey,
                // 배경 위의 색상
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.red,
                shadowColor: Colors.green,
                elevation: 10,
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
                padding: EdgeInsets.all(32.0),
                side: BorderSide(
                  color: Colors.black,
                  width: 12.0,
                ),
                // minimumSize: Size(300, 150),
                // maximumSize: Size(100, 150),
                // fixedSize: Size(100, 150),
              ),
              child: Text('Elevated Button'),
            ),
            OutlinedButton(
              // onPressed: () {},
              onPressed: null,
              // ElevatedButton의 모든 속성들을 가져다 쓸 수 있다.
              style: ButtonStyle(
                // !! deprecated MaterialStateProperty
                /// Material State
                /// all: 아래의 전체 상태에 적용
                ///
                /// hovered - 호버링 상태 (마우스 커서를 올려놓은 상태)
                /// focused - 포커스 됐을 때 (텍스트 필드)
                /// pressed - 눌렀을 때 [o]
                /// dragged - 드래그 됐을 때
                /// selected - 선택 됐을 때 (체크박스, 라디오 버튼)
                /// scrollUnder - 다른 컴포넌트 밑으로 스크롤링 됐을 때
                /// disabled - 비활성화 됐을 때 [o]
                /// error - 에러 상태일 때
                // backgroundColor: MaterialStateProperty.all(
                backgroundColor: WidgetStateProperty.all(
                  Colors.red,
                ),
                minimumSize: WidgetStateProperty.all(
                  Size(200, 150),
                ),
              ),
              child: Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {},
              // ElevatedButton의 모든 속성들을 가져다 쓸 수 있다.
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith(
                  // (Set<MaterialState> states) {
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.red;
                    }

                    return Colors.black;
                  },
                ),
                foregroundColor: WidgetStateProperty.resolveWith(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.black;
                    }

                    return Colors.white;
                  },
                ),
                minimumSize: WidgetStateProperty.resolveWith(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.pressed)) {
                      return Size(200, 150);
                    }

                    return Size(300, 200);
                  },
                ),
              ),
              child: Text('Text Button'),
            ),
          ],
        ),
      ),
    );
  }
}
