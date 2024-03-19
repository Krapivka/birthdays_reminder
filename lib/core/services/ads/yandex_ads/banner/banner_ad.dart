import 'package:birthdays_reminder/core/services/ads/yandex_ads/banner/bloc/yandex_ads_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

// ignore: must_be_immutable
class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget({
    super.key,
    this.isSticky = true,
  });

  final bool isSticky;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          YandexAdsBloc()..add(LoadYandexAdsEvent(isSticky: isSticky)),
      child: const BannerAdView(),
    );
  }
}

class BannerAdView extends StatelessWidget {
  const BannerAdView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<YandexAdsBloc, YandexAdsState>(
      builder: (context, state) {
        if (state.status == YandexAdsStatus.loaded) {
          return AdWidget(bannerAd: state.banner!);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
