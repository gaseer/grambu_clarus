import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grambu_task/screens/product_screen.dart';
import 'package:grambu_task/screens/qrScanner_screen.dart';
import '../core/constants/screen_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'designCode_scanner.dart';

var w;
final dropValue = StateProvider.autoDispose<String?>((ref) {
  return '101';
});

final branchNameProvider = StateProvider.autoDispose<String>((ref) {
  return '';
});

// final productCodeProvider = StateProvider.autoDispose<String>((ref) {
//   return '';
// });

final todayRateProvider = StateProvider.autoDispose<String>((ref) {
  return 'loading...';
});

String productCodeGlobal = '';
String designCodeGlobal = '';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController codeController = TextEditingController();
  TextEditingController designCodeController = TextEditingController();

  String? selectedItem;
  String currentDate = '';

  String? branchText = '';

  @override
  void initState() {
    super.initState();
    currentDate =
        "${DateTime.now().day}-${_getMonth(DateTime.now().month)}-${DateTime.now().year}";
  }

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    designCodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final branchName = ref.watch(branchNameProvider);
    final todayRate = ref.watch(todayRateProvider);
    w = MediaQuery.of(context).size.width;
    return Scaffold(
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
              image: const AssetImage('assets/appBar.jpg'),
              fit: BoxFit.cover,
              scale: w * 1,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(w * .05),
        children: <Widget>[
          SizedBox(
            height: w * .065,
          ),
          Text(
            'ENTER OR SCAN',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: w * .085,
              color: Colors.brown,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            height: 10,
            indent: w * .4,
            endIndent: w * .4,
            thickness: 2,
            color: Colors.brown,
          ),
          SizedBox(
            height: w * .05,
          ),
          Text(
            'TYPE CODE OR CLICK ICON TO SCAN \n FOR LISTING PRODUCT',
            textAlign: TextAlign.center,
            style: simpleTextStyle,
          ),
          SizedBox(height: w * .10),
          Container(
            padding:
                EdgeInsets.only(left: w * .06, right: w * .06, top: w * .082),
            height: w * .8,
            width: w * .9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w * .030),
              color: const Color(0xD2F6DAB2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'FILL THE BELOW',
                  style: simpleTextStyle,
                ),
                SizedBox(
                  height: w * .09,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 16,
                          color: Colors.yellow,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Branch',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: branchMap.keys
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedItem,
                    onChanged: (value) {
                      setState(() {
                        selectedItem = value;
                      });
                      ref
                          .watch(branchNameProvider.notifier)
                          .update((state) => branchMap[value]!);
                      fetchData();
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: w * .85,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                        color: Colors.brown,
                      ),
                      elevation: 2,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.yellow,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: w * .65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.brown,
                      ),
                      offset: const Offset(30, 10),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
                SizedBox(
                  height: w * .05,
                ),
                Container(
                  height: w * .13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: codeController,
                    onChanged: (s) {
                      productCodeGlobal = codeController.text.trim();
                    },
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(
                        fontSize: w * .03,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .05),
                    cursorColor: Colors.brown,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'EG: 4584651',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: w * .04,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (ref.watch(branchNameProvider).isNotEmpty) {
                              navigateScreen(context, const Scanner());
                            } else {
                              showSnackBar(context, 'Select a branch then SCAN',
                                  Colors.red);
                            }
                          },
                          child: Image.asset('assets/qrIcon.png')),
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
                // CustomTextField(
                //     keyboardType: TextInputType.number,
                //     hintText: 'EG: 4584651',
                //     controller: codeController),
                SizedBox(
                  height: w * .05,
                ),
                Container(
                  height: w * .13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: designCodeController,
                    onChanged: (s) {
                      setState(() {
                        designCodeGlobal = designCodeController.text.trim();
                      });
                    },
                    keyboardType: TextInputType.text,
                    style: GoogleFonts.poppins(
                        fontSize: w * .03,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .05),
                    cursorColor: Colors.brown,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'EG: DESIGN CSH856',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: w * .04,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            if (ref.watch(branchNameProvider).isNotEmpty) {
                              navigateScreen(context, DesignCodeScanner());
                            } else {
                              showSnackBar(context, 'Select a branch then SCAN',
                                  Colors.red);
                            }
                          },
                          child: Image.asset('assets/qrIcon.png')),
                      contentPadding: const EdgeInsets.only(left: 10.0),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: w * .15,
          ),
          Padding(
            padding: EdgeInsets.only(right: w * .25, left: w * .25),
            child: ElevatedButton(
              onPressed: () {
                if (codeController.text.isNotEmpty && branchName != '') {
                  navigateScreen(context, ProductScreen());
                  codeController.clear();
                } else if (designCodeController.text.isNotEmpty &&
                    branchName != '') {
                  navigateScreen(context, ProductScreen());
                  designCodeController.clear();
                } else {
                  if (branchName == '') {
                    showSnackBar(
                        context, 'Please Select The Branch', Colors.red);
                  } else {
                    showSnackBar(
                        context, 'Please give at least one code', Colors.red);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xEF643924), // Background color
              ),
              child: Text(
                'CHECK',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .05),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> branch = ['101', '105', '106', '107', '111'];

  Map<String, String> branchMap = {
    'PERINTHALMANNA': '101',
    'KARUVARAKUNDU': '105',
    'WANDOOR': '106',
    'VALIYANGADI': '107',
    'MELATTUR': '109',
    'KARINKALATHANI': '110',
    'PATTIKAD': '111',
    'MALAPPURAM': '112',
    'PANDIKKAD': '113',
    'ALANELLUR': '114',
    'OFFICE PERINTHALMANNA': '115',
    'ARECODE': '117',
    'GUDALUR': '118',
    'KANNUR': '119',
    'THIRUVANATHAPURAM': '120'
  };

  Future<void> fetchData() async {
    final dio = Dio();
    final response = await dio.get(
        'http://viewproduct-env.eba-smbpywd9.ap-south-1.elasticbeanstalk.com/api/metalrates/$currentDate/${ref.watch(branchNameProvider)}');
    print('asc');
    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      if (jsonResponse.isNotEmpty && jsonResponse[0].containsKey('boardRate')) {
        ref
            .read(todayRateProvider.notifier)
            .update((state) => jsonResponse[0]['boardRate'].toString());
      } else {
        ref.read(todayRateProvider.notifier).update((state) => 'Not Found');
      }
    } else {
      ref.read(todayRateProvider.notifier).update((state) => 'Not ');
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
