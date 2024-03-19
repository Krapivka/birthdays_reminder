part of 'yandex_ads_bloc.dart';

enum YandexAdsStatus { initial, loading, loaded }

class YandexAdsState extends Equatable {
  const YandexAdsState({
    required this.banner,
    required this.adUnitId,
    required this.adRequest,
    required this.status,
  });

  final String adUnitId;
  final AdRequest adRequest;
  final YandexAdsStatus status;
  final BannerAd? banner;
  @override
  List<Object> get props {
    return [
      adUnitId,
      adRequest,
      status,
    ];
  }

  YandexAdsState copyWith({
    String? adUnitId,
    AdRequest? adRequest,
    BannerAd? banner,
    YandexAdsStatus? status,
  }) {
    return YandexAdsState(
        banner: banner ?? this.banner,
        adUnitId: adUnitId ?? this.adUnitId,
        adRequest: adRequest ?? this.adRequest,
        status: status ?? this.status);
  }
}
