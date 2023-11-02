// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:korkort/bloc/payment_stripe/payment_stripe_bloc.dart';
import 'package:korkort/route/route_constants.dart';
import 'package:korkort/style/app_colors.dart';
import 'package:korkort/style/app_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String? url;
  bool isFirst=false;
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  // Future<void> initDynamicLinks() async {
  //   print('_WebViewScreenState.initDynamicLinks');
  //   dynamicLinks.onLink.listen((dynamicLinkData) {
  //     final Uri uri = dynamicLinkData.link;
  //     final queryParams = uri.queryParameters;
  //
  //     print('_LanguageSelectionScreenState.initDynamicLinks $queryParams');
  //     if (queryParams.toString() == "success_stripe") {
  //       // String? productId = queryParams;
  //       print('_WebViewScreenState.initDynamicLinks $queryParams');
  //     } else {
  //       Navigator.pushNamed(
  //         context,
  //         dynamicLinkData.link.path,
  //       );
  //     }
  //   }).onError((error) {
  //     print('onLink error');
  //     print(error.message);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initDynamicLinks();
  }
@override
  void dispose() {
    controller.clearCache();
    super.dispose();
  }
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset("assets/svg/close.svg",color: AppColors.greenAccent,),
        ),
        centerTitle: true,
        title: Text("Payment", style: AppStyle.appBarStylePrivacy),
      ),
      body: BlocConsumer<PaymentStripeBloc, PaymentStripeState>(
        listener: (context, state) {
          if (state is PaymentStripeLoaded) {
            // Link(uri: "uri", builder: builder)
            controller
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    print('_WebViewScreenState  aa $progress');
                  },
                  onPageStarted: (String url) {
                    print('_WebViewScreenState  cc $url');
                  },
                  onPageFinished: (String url) {
                    if (url.contains("google")) {
                      if(!isFirst){
                        isFirst=true;
                        Navigator.pushReplacementNamed(context, RouteList.checkScreen, arguments: int.parse(url.split("order_id=")[1])).then((value) {
                          isFirst=false;
                          setState(() {

                          });
                        });
                      }
                    }
                  },
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                ),
              )
              ..loadRequest(Uri.parse(state.paymentCreateResponse?.checkoutUrl ?? ""));
          }
        },
        builder: (context, state) {
          if (state is PaymentStripeLoaded) {
            return WebViewWidget(controller: controller);
          }
          return const Center(
            // child: CircularProgressIndicator(
            //   color: AppColors.green,
            // ),
          );
        },
      ),
    );
  }
}
