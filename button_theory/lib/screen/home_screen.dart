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
              onPressed: () {},
              child: Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Text Button'),
            ),
          ],
        ),
      ),
    );
  }
}
