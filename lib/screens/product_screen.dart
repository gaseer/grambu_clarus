import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grambu_task/core/constants/screen_constants.dart';
import 'package:grambu_task/model/gold_model.dart';
import 'package:grambu_task/screens/widgets/productWeight_widget.dart';
import 'package:grambu_task/services/goldApi_service.dart';
import '../core/providers.dart';
import 'home_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

//Get api call provider !!
final productProvider = FutureProvider.autoDispose<GoldModel>((ref) async {
  return ref.watch(apiServiceProvider).getProduct(
      productCodeGlobal, ref.watch(branchNameProvider), designCodeGlobal);
});

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    designCodeGlobal = '';
    productCodeGlobal = '';
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(productProvider);
    final todayRate = ref.watch(todayRateProvider);
    TextStyle itemDataStyle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: w * .045,
      fontWeight: FontWeight.w600,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: w * .2,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today's Rate  ",
                  style: GoogleFonts.poppins(
                    fontSize: w * .035,
                    color: Colors.yellow.shade100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: w * .02,
                ),
                Text(
                  " $todayRate  ",
                  style: GoogleFonts.poppins(
                    fontSize: w * .035,
                    color: Colors.yellow.shade100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.brown,
              image: DecorationImage(
                image: const AssetImage(
                    'assets/appBar.jpg'), // Use AssetImage to load the image from assets
                fit: BoxFit.cover,
                scale: w * 1,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: data.when(
              data: (data) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: w * .035,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: w * .05, right: w * .05),
                      child: Text(
                        " ${data.itemName}  ( # ${data.prodcode})",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: w * .045,
                          letterSpacing: .01,
                          fontWeight: FontWeight.w600,
                        ),
                      ).animate().fade(duration: 1500.ms).slideY(),
                    ),
                    SizedBox(
                      height: w * .02,
                    ),
                    Container(
                            margin:
                                EdgeInsets.only(left: w * .05, right: w * .05),
                            padding: EdgeInsets.only(
                                left: w * .015, right: w * .035),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(w * .05),
                                  bottomRight: Radius.circular(w * .2)),
                              color: const Color(0xD2F6DAB2),
                            ),
                            child: const Text('BEST SELLER'))
                        .animate()
                        .shimmer(delay: 400.ms, duration: 1800.ms)
                        .shake(hz: 4, curve: Curves.easeOutCubic)
                        .scaleXY(end: 1.1, duration: 600.ms)
                        .then(delay: 600.ms)
                        .scaleXY(end: 1 / 1.1),
                    Padding(
                        padding: EdgeInsets.only(left: w * .05, right: w * .05),
                        child: Text(
                          "₹ ${data.totalAmt?.toStringAsFixed(0)}",
                          style: GoogleFonts.poppins(
                              color: Colors.brown,
                              fontSize: w * .058,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .2),
                        )
                            .animate()
                            .shimmer(delay: 500.ms, duration: 1.seconds)),
                    SizedBox(
                      height: w * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: w * .03),
                          margin: EdgeInsets.only(left: w * .05),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * .040),
                            color: Colors.black12,
                          ),
                          height: w * .35,
                          width: w * .52,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: ,
                            children: [
                              Text(
                                'Product Weight',
                                style: itemDataStyle,
                              ),
                              SizedBox(
                                height: w * .035,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: .5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Gross Weight ',
                                      ),
                                      Text('Stone Weight '),
                                      Text('Diamond Weight '),
                                      Text('Net Weight '),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(':'),
                                      Text(':'),
                                      Text(':'),
                                      Text(':'),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${data.gwt}'),
                                      Text('${data.stWt}'),
                                      Text('${data.diawt}'),
                                      Text('${data.netWt}'),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${data.gwtUnit}'),
                                      Text('${data.stWtUnit}'),
                                      Text('${data.diawtUnit}'),
                                      Text('Gm'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1,
                                  )
                                ],
                              ),
                              // ProductWeightWidget(
                              //     weight: "Gross Weight  ",
                              //     count: ':  ' '${data.gwt} ${data.gwtUnit}'),
                              // ProductWeightWidget(
                              //     weight: "Stone Weight  ",
                              //     count: ':  ' '${data.stWt} ${data.stWtUnit}'),
                              // ProductWeightWidget(
                              //     weight: "Diamond Weight ",
                              //     count:
                              //         ':  ' '${data.diawt} ${data.diawtUnit}'),
                              // ProductWeightWidget(
                              //     weight: "Net Weight ",
                              //     count: ':  ' '${data.netWt} GM'),
                            ],
                          ),
                        ).animate().fade(duration: 1000.ms).slideX(),
                        SizedBox(
                          width: w * .03,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: w * .06, right: w * .05, top: w * .03),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * .040),
                            color: Colors.black12,
                          ),
                          height: w * .35,
                          width: w * .34,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Purity',
                                style: itemDataStyle,
                              ),
                              SizedBox(
                                height: w * .045,
                              ),
                              Text(
                                '${data.purity}',
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: w * .04,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ).animate().fade(duration: 1000.ms).slideY()
                      ],
                    ),
                    SizedBox(
                      height: w * .03,
                    ),
                    Container(
                      // alignment: Alignment.center,
                      margin: EdgeInsets.only(left: w * .05, bottom: w * .05),
                      height: w * 0.5,
                      width: w * .89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.040),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: CachedNetworkImage(
                          imageUrl: productCodeGlobal != ''
                              ? 'http://viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/productInfoes/GetProductImage/$productCodeGlobal/${ref.watch(branchNameProvider)}'
                              : 'http://viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/productInfoes/GetProductImage/$designCodeGlobal/${ref.watch(branchNameProvider)}',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: LinearProgressIndicator(
                                color: Colors.brown,
                                backgroundColor: Colors.brown.shade200),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text(
                              'No Image Found !',
                              style: itemDataStyle,
                            ),
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fade(duration: 500.ms)
                        .then()
                        .shimmer(delay: 300.ms, duration: 1500.ms)
                        .moveX(duration: 1500.ms),
                    data.description == '0' || data.description!.length <= 5
                        ? SizedBox()
                        : Container(
                            height: w * .9,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                              left: w * .05,
                              right: w * .05,
                            ),
                            padding:
                                EdgeInsets.only(left: w * .025, top: w * .018),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(w * .050),
                                  topLeft: Radius.circular(w * .05)),
                              color: const Color(0xD2F6DAB2),
                            ),
                            child: ListView(
                              children: [
                                Text(
                                  "Product Description",
                                  style: itemDataStyle,
                                ),
                                SizedBox(
                                  height: w * .02,
                                ),
                                Text(
                                  data.description.toString(),
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: w * .035,
                                    letterSpacing: .75,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          )
                            .animate()
                            .fade(duration: 1500.ms)
                            .moveY(curve: Curves.easeIn, duration: 1000.ms)
                  ],
                );
              },
              error: (err, s) => Text(err.toString()),
              loading: () => Center(
                    child: LinearProgressIndicator(
                        minHeight: 15,
                        color: Colors.brown,
                        backgroundColor: Colors.brown.shade200),
                  )),
        ),
      ),
    );
  }
}
