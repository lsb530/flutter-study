import 'package:flutter/material.dart';

/*
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
 */
class StatusModel {
  // 단계
  final int level;

  // 단계명
  final String label;

  // 주색상
  final Color primaryColor;

  // 어두운 색상
  final Color darkColor;

  // 밝은 색상
  final Color lightColor;

  // 폰트 색상
  final Color fontColor;

  // 이모티콘 이미지
  final String imagePath;

  // 코멘트
  final String comment;

  // 미세먼지 최소치
  final double minFM10;

  // 초미세먼지 최소치
  final double minFM25;

  // 오존 최소치
  final double minO3;

  // 이산화질소 최소치
  final double minNO2;

  // 일산화탄소 최소치
  final double minCO;

  // 이황산가스 최소치
  final double minSO2;

  StatusModel({
    required this.level,
    required this.label,
    required this.primaryColor,
    required this.darkColor,
    required this.lightColor,
    required this.fontColor,
    required this.imagePath,
    required this.comment,
    required this.minFM10,
    required this.minFM25,
    required this.minO3,
    required this.minNO2,
    required this.minCO,
    required this.minSO2,
  })
}
