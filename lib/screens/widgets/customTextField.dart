// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:grambu_task/core/constants/screen_constants.dart';
//
// import '../home_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../qrScanner_screen.dart';
//
// class CustomTextField extends ConsumerWidget {
//   final String hintText;
//   final TextInputType? keyboardType;
//   final TextEditingController controller;
//   const CustomTextField({
//     Key? key,
//     required this.hintText,
//     required this.controller,
//     this.keyboardType,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       height: w * .13,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//       ),
//       child: TextFormField(
//         controller: controller,
//         onChanged: (s) {
//           print(s);
//           print("saaa");
//           ref.watch(productCodeProvider.notifier).update((state) => s);
//         },
//         keyboardType: keyboardType,
//         style: GoogleFonts.poppins(
//             fontSize: w * .03, fontWeight: FontWeight.w400, letterSpacing: .05),
//         cursorColor: Colors.brown,
//         decoration: InputDecoration(
//           fillColor: Colors.white,
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.black54,
//             fontSize: w * .04,
//           ),
//           suffixIcon: InkWell(
//               onTap: () {
//                 if (ref.watch(branchNameProvider).isNotEmpty) {
//                   navigateScreen(context, Scanner());
//                 } else {
//                   showSnackBar(
//                       context, 'Select a branch then SCAN', Colors.red);
//                 }
//               },
//               child: Image.asset('assets/qrIcon.png')),
//           contentPadding: const EdgeInsets.only(left: 10.0),
//           border: const OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//           ),
//         ),
//       ),
//     );
//   }
// }
