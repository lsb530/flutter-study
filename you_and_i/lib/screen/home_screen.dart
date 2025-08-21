import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          // width: double.infinity,
          width: MediaQuery.of(context).size.width, // /2 /3 등을 할 수 있다.
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.red,
                  child: Column(
                    children: [
                      Text('U&I'),
                      Text('우리 처음 만난날'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                      ),
                      Text('D+1')
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.blue,
                  child: Image.asset(
                    'asset/img/middle_image.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
