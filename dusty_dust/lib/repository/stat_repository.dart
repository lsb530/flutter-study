import 'package:dio/dio.dart';
import 'package:dusty_dust/model/stat_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiUrl = dotenv.env['API_URL'];
final serviceKey = dotenv.env['SERVICE_KEY'];

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final itemCodeStr = itemCode == ItemCode.PM25 ? 'PM2.5' : itemCode.name;

    final response = await Dio().get(
      '$apiUrl',
      queryParameters: {
        'serviceKey': '$serviceKey',
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCodeStr,
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
      final dateTime = item['dataTime'];

      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          continue;
        }

        final regionStr = key;
        final stat = item[key];

        stats = [
          ...stats,
          StatModel(
            region: Region.values.firstWhere((e) => e.name == regionStr),
            stat: double.parse(stat),
            dateTime: DateTime.parse(dateTime),
            itemCode: itemCode,
          ),
        ];
      }
    }

    return stats;
  }
}