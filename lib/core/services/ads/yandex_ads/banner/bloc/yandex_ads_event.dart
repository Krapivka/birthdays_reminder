part of 'yandex_ads_bloc.dart';

sealed class YandexAdsEvent extends Equatable {
  const YandexAdsEvent();

  @override
  List<Object> get props => [];
}

class LoadYandexAdsEvent extends YandexAdsEvent {
  const LoadYandexAdsEvent({required this.isSticky});

  final bool isSticky;

  @override
  List<Object> get props => [isSticky];
}
