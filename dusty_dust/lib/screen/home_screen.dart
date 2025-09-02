import 'package:dusty_dust/component/category_stat.dart';
import 'package:dusty_dust/component/hourly_stat.dart';
import 'package:dusty_dust/component/main_stat.dart';
import 'package:dusty_dust/const/color.dart';
import 'package:dusty_dust/repository/stat_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: StatRepository.fetchData(),
          builder: (context, snapshot) {
            // print(snapshot.error);
            // print(snapshot.data);

            if (snapshot.hasData) {
              print(snapshot.data!['response']['body']['totalCount']);
            }
            return Column(
              children: [
                MainStat(),
                CategoryStat(),
                HourlyStat(),
              ],
            );
          }
        ),
      ),
    );
  }
}
