// // // // ads_page.dart
// // // import 'package:flutter/material.dart';
// // // import 'package:google_mobile_ads/google_mobile_ads.dart';
// // //
// // // class AdsPage extends StatefulWidget {
// // //   const AdsPage({super.key});
// // //
// // //   @override
// // //   State<AdsPage> createState() => _AdsPageState();
// // // }
// // //
// // // class _AdsPageState extends State<AdsPage> {
// // //   BannerAd? _bannerAd;
// // //   bool _isAdLoaded = false;
// // //
// // //   // TODO: Replace with your real AdMob Banner Unit ID
// // //   static const String _bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111'; // test ID
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadBannerAd();
// // //   }
// // //
// // //   void _loadBannerAd() {
// // //     _bannerAd = BannerAd(
// // //       adUnitId: _bannerAdUnitId,
// // //       size: AdSize.fullBanner,               // 320×100
// // //       request: const AdRequest(),
// // //       listener: BannerAdListener(
// // //         onAdLoaded: (_) {
// // //           setState(() => _isAdLoaded = true);
// // //         },
// // //         onAdFailedToLoad: (ad, err) {
// // //           debugPrint('BannerAd failed to load: $err');
// // //           ad.dispose();
// // //         },
// // //       ),
// // //     )..load();
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _bannerAd?.dispose();
// // //     super.dispose();
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Ads'),
// // //       ),
// // //       body: Center(
// // //         child: _isAdLoaded && _bannerAd != null
// // //             ? Container(
// // //           alignment: Alignment.center,
// // //           width: _bannerAd!.size.width.toDouble(),
// // //           height: _bannerAd!.size.height.toDouble(),
// // //           child: AdWidget(ad: _bannerAd!),
// // //         )
// // //             : const CircularProgressIndicator(),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // ads_page.dart
// // import 'package:flutter/material.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';
// //
// // class AdsPage extends StatefulWidget {
// //   const AdsPage({super.key});
// //
// //   @override
// //   State<AdsPage> createState() => _AdsPageState();
// // }
// //
// // class _AdsPageState extends State<AdsPage> {
// //   BannerAd? _bannerAd;
// //   bool _isAdLoaded = false;
// //
// //   // TODO: Replace with your REAL Banner Ad Unit ID from AdMob
// //   // Test ID (safe for testing):
// //   static const String _adUnitId = 'ca-app-pub-9848688753999400/8959996807';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadAd();
// //   }
// //
// //   void _loadAd() {
// //     _bannerAd = BannerAd(
// //       adUnitId: _adUnitId,
// //       size: AdSize.fullBanner, // 320x100
// //       request: const AdRequest(),
// //       listener: BannerAdListener(
// //         onAdLoaded: (_) {
// //           setState(() => _isAdLoaded = true);
// //         },
// //         onAdFailedToLoad: (ad, error) {
// //           debugPrint('Ad failed to load: $error');
// //           ad.dispose();
// //         },
// //       ),
// //     )..load();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _bannerAd?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Earn with Ads'),
// //         backgroundColor: Colors.deepPurple,
// //       ),
// //       body: Center(
// //         child: _isAdLoaded && _bannerAd != null
// //             ? Container(
// //           alignment: Alignment.center,
// //           width: _bannerAd!.size.width.toDouble(),
// //           height: _bannerAd!.size.height.toDouble(),
// //           child: AdWidget(ad: _bannerAd!),
// //         )
// //             : const Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CircularProgressIndicator(),
// //             SizedBox(height: 16),
// //             Text('Loading ad...'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // ads_page.dart
// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdsPage extends StatefulWidget {
//   const AdsPage({super.key});
//
//   @override
//   State<AdsPage> createState() => _AdsPageState();
// }
//
// class _AdsPageState extends State<AdsPage> {
//   BannerAd? _bannerAd;
//   bool _isAdLoaded = false;
//
//   // === USE TEST AD UNIT ID FOR DEVELOPMENT ===
//  // static const String _adUnitId = 'ca-app-pub-3940256099942544/6300978111'; // TEST BANNER
//
//   // === WHEN READY FOR PRODUCTION, SWITCH TO: ===
//    static const String _adUnitId = 'ca-app-pub-9848688753999400/8959996807';
//
//   @override
//   void initState() {
//     super.initState();
//     _setupTestDevices();
//     _loadAd();
//   }
//
//   void _setupTestDevices() {
//     // Add your device as a test device
//     MobileAds.instance.updateRequestConfiguration(
//       RequestConfiguration(
//         testDeviceIds: ['114038935F3646C2A16A88A6ECB4BB15'], // Your device ID from log
//       ),
//     );
//   }
//
//   void _loadAd() {
//     _bannerAd = BannerAd(
//       adUnitId: _adUnitId,
//       size: AdSize.fullBanner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           if (mounted) {
//             setState(() => _isAdLoaded = true);
//           }
//         },
//         onAdFailedToLoad: (ad, error) {
//           debugPrint('BannerAd failed: $error');
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Adss Page')),
//       body: Center(
//         child: _isAdLoaded && _bannerAd != null
//             ? Container(
//           width: _bannerAd!.size.width.toDouble(),
//           height: _bannerAd!.size.height.toDouble(),
//           child: AdWidget(ad: _bannerAd!),
//         )
//             : const Text('Loading test ad...'),
//       ),
//     );
//   }
// }

// lib/ads_page.dart
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _isAdFailed = false;

  // === PRODUCTION AD UNIT ID ===
  static const String _adUnitId = 'ca-app-pub-9848688753999400/8959996807';

  // === FOR TESTING ONLY (Uncomment if needed) ===
  // static const String _adUnitId = 'ca-app-pub-3940256099942544/6300978111';

  @override
  void initState() {
    super.initState();
    _loadBannerAd();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.fullBanner, // 468×60 – fills width, good for tablets & phones
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!mounted) return;
          setState(() {
            _isAdLoaded = true;
            _isAdFailed = false;
          });
          debugPrint('Banner Ad Loaded Successfully');
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner Ad Failed to Load: $error');
          ad.dispose();
          if (!mounted) return;
          setState(() {
            _isAdLoaded = false;
            _isAdFailed = true;
          });
        },
        onAdOpened: (_) => debugPrint('Ad Opened'),
        onAdClicked: (_) => debugPrint('Ad Clicked'),
        onAdImpression: (_) => debugPrint('Ad Impression Recorded'),
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earn with Ads'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: _isAdLoaded && _bannerAd != null
              ? Container(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AdWidget(ad: _bannerAd!),
          )
              : _isAdFailed
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              const Text(
                'Ad failed to load.\nCheck internet or try again later.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isAdLoaded = false;
                    _isAdFailed = false;
                  });
                  _loadBannerAd();
                },
                child: const Text('Retry'),
              ),
            ],
          )
              : const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading adds...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}