// import 'package:flutter/material.dart';
// import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
// import 'package:jotrockenmitlocken/constants.dart';

// const double buttonPaddingHorizontal = 40;
// const double buttonPaddingVertical = 20;

// class NavBar extends StatelessWidget {
//   const NavBar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return const DesktopNavbar();
//   }
// }

// class DesktopNavbar extends StatelessWidget {
//   const DesktopNavbar({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//         builder: (BuildContext context, BoxConstraints constraints) {
//       if (constraints.maxWidth > largeWidthBreakpoint) {
//         return Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: getpagesSpacingToTop(context),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: createLogoAndName(),
//               ),
//               SizedBox(height: getpagesSpacingToTop(context)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: createButtonArray(context),
//               ),
//             ],
//           ),
//         );
//       } else {
//         var buttons = createButtonArray(context);
//         final numberButtonsFirstRow = (buttons.length / 2).round();
//         return Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: createLogoAndName(),
//               ),
//               SizedBox(height: getpagesSpacingToTop(context)),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: buttons.sublist(0, numberButtonsFirstRow - 1),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children:
//                     buttons.sublist(numberButtonsFirstRow, buttons.length),
//               ),
//             ],
//           ),
//         );
//       }
//     });
//   }

//   List<Widget> createLogoAndName() {
//     return [
//       const Text(
//         appName,
//         style: TextStyle(
//             fontWeight: FontWeight.bold, color: Colors.black, fontSize: 60),
//       ),
//       const SizedBox(width: 16),
//       Image.asset("assets/images/barbell.png", width: 64),
//     ];
//   }

//   List<Widget> createButtonArray(BuildContext context) {
//     const buttonTextStyle = TextStyle(
//         fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20);
//     const buttonSpacing = SizedBox(width: 30);
//     var buttonStyle = ElevatedButton.styleFrom(
//       backgroundColor: kPrimaryColor,
//       padding: const EdgeInsets.symmetric(
//           horizontal: buttonPaddingHorizontal, vertical: buttonPaddingVertical),
//     );
//     return <Widget>[
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text(
//           "About me",
//           style: buttonTextStyle,
//         ),
//         onPressed: () {
//           Navigator.pushNamed(context, '/aboutMe');
//         },
//       ),
//       buttonSpacing,
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text(
//           "Quotes",
//           style: buttonTextStyle,
//         ),
//         onPressed: () {
//           Navigator.pushNamed(context, '/quotes');
//         },
//       ),
//       buttonSpacing,
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text("Books", style: buttonTextStyle),
//         onPressed: () {
//           Navigator.pushNamed(context, '/books');
//         },
//       ),
//       buttonSpacing,
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text(
//           "Films",
//           style: buttonTextStyle,
//         ),
//         onPressed: () {
//           Navigator.pushNamed(context, '/films');
//         },
//       ),
//       buttonSpacing,
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text(
//           "Documents",
//           style: buttonTextStyle,
//         ),
//         onPressed: () {
//           Navigator.pushNamed(context, '/docs');
//         },
//       ),
//       buttonSpacing,
//       ElevatedButton(
//         style: buttonStyle,
//         child: const Text("Blog", style: buttonTextStyle),
//         onPressed: () {
//           Navigator.pushNamed(context, '/blog');
//         },
//       ),
//     ];
//   }
// }
