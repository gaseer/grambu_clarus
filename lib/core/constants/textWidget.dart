// import 'package:flutter/material.dart';
//
// class CustomTextFrom extends StatelessWidget {
//   final TextEditingController controller;
//   final bool showPass;
//   const CustomTextFrom({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       controller: passControler,
//       obscureText: showPass,
//       decoration: InputDecoration(
//           suffixIcon: InkWell(
//             onTap: () {
//               setState(() {
//                 showPass = !showPass;
//               });
//             },
//             child: showPass ? Icon(Icons.remove_red_eye) : Icon(Icons.close),
//           ),
//           hintText: 'Password here',
//           labelText: 'Enter Your Password',
//           border: OutlineInputBorder()),
//       validator: (v) {
//         if (v!.isEmpty) {
//           return 'Please Enter Your Name';
//         }
//         return null;
//       },
//     );
//   }
// }
