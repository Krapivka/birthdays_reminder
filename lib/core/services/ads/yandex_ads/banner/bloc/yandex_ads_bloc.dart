import 'dart:async';

import 'package:birthdays_reminder/birthdays_reminder_app.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

part 'yandex_ads_event.dart';
part 'yandex_ads_state.dart';

class YandexAdsBloc extends Bloc<YandexAdsEvent, YandexAdsState> {
  YandexAdsBloc()
      : super(const YandexAdsState(
          adUnitId: "R-M-6626566-1",
          adRequest: AdRequest(),
          status: YandexAdsStatus.initial,
          banner: null,
        )) {
    on<LoadYandexAdsEvent>(_onLoadYandexAds);
  }

  Future<void> _onLoadYandexAds(
      LoadYandexAdsEvent event, Emitter<YandexAdsState> emit) async {
    if (state.status == YandexAdsStatus.loaded) {
      state.banner!.loadAd(adRequest: state.adRequest);
    } else {
      emit(state.copyWith(
        status: YandexAdsStatus.loading,
      ));
      final adSize = event.isSticky
          ? BannerAdSize.sticky(width: windowSize.width.toInt())
          : BannerAdSize.inline(
              width: windowSize.width.toInt(),
              maxHeight: windowSize.height ~/ 3,
            );
      var calculatedBannerSize = await adSize.getCalculatedBannerAdSize();
      debugPrint('calculatedBannerSize: ${calculatedBannerSize.toString()}');
      emit(state.copyWith(
        status: YandexAdsStatus.loaded,
        banner: _createBanner(adSize),
      ));
    }
  }

  BannerAd _createBanner(BannerAdSize adSize) {
    return BannerAd(
      adUnitId: state.adUnitId,
      adSize: adSize,
      adRequest: state.adRequest,
      onAdLoaded: () {
        debugPrint('callback: banner ad loaded');
      },
      onAdFailedToLoad: (error) {
        debugPrint('callback: banner ad failed to load, '
            'code: ${error.code}, description: ${error.description}');
      },
      onAdClicked: () => debugPrint('callback: banner ad clicked'),
      onLeftApplication: () => debugPrint('callback: left app'),
      onReturnedToApplication: () => debugPrint('callback: returned to app'),
      onImpression: (data) =>
          debugPrint('callback: impression: ${data.getRawData()}'),
    );
  }
}
