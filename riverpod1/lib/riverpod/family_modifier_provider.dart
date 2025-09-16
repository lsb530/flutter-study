import 'package:flutter_riverpod/flutter_riverpod.dart';

// 최초 데이터 파라미터 받음
final familyModifierProvider = FutureProvider.family<List<int>, int>((
  ref,
  data,
) async {
  await Future.delayed(Duration(seconds: 2));
  
  return List.generate(5, (index) => index * data);
});
