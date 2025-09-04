import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

final apiUrl = dotenv.env['API_URL'];
final serviceKey = dotenv.env['SERVICE_KEY'];

class StatRepository {
  static Future<void> fetchDate() async {
    final isar = GetIt.I<Isar>();

    final now = DateTime.now();
    final compareDateTimeTarget = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final count = await isar.statModels
        .filter()
        .dateTimeEqualTo(compareDateTimeTarget)
        .count();

    if (count > 0) {
      print('데이터가 존재합니다: $count개');
      return;
    }

    for (var itemCode in ItemCode.values) {
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }

  static Future<List<StatModel>> fetchDataByItemCode({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      '$apiUrl',
      queryParameters: {
        'serviceKey': '$serviceKey',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    // print(response.data['response']);
    // print(response.data['response']['body']['items']);

    final List<String> skipKeys = [
      'dataGubun',
      'dataTime',
      'itemCode',
    ];

    final rawItemsList = response.data['response']['body']['items'];

    List<StatModel> stats = [];

    for (Map<String, dynamic> item in rawItemsList) {
      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final region = Region.values.firstWhere((e) => e.name == regionStr);
        final stat = double.parse(item[regionStr]);
        final dateTime = DateTime.parse(item['dataTime']);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dateTime = dateTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .dateTimeEqualTo(dateTime)
            .itemCodeEqualTo(itemCode)
            .count();

        if (count > 0) {
          continue;
        }

        await isar.writeTxn(
          () async {
            await isar.statModels.put(statModel);
          },
        );

        // stats = [
        //   ...stats,
        //   StatModel(
        //     region: Region.values.firstWhere((e) => e.name == regionStr),
        //     stat: double.parse(stat),
        //     dateTime: DateTime.parse(dateTime),
        //     itemCode: itemCode,
        //   ),
        // ];
      }
    }

    return stats;
  }
}
