// import 'package:flutter/material.dart';

// import 'package:jotrockenmitlocken/Decoration/decoration_helper.dart';
// import 'package:jotrockenmitlocken/constants.dart';

// import 'package:jotrockenmitlocken/Navbar/Navbar.dart';
// import '../Navbar/mobile/navigation_drawer_widget.dart';

// class BlogLandingPage extends StatelessWidget {
//   const BlogLandingPage({Key? key}) : super(key: key);

//   List<Widget> buildBlog(BuildContext context) {
//     final double currentWidth = MediaQuery.of(context).size.width;
//     // init all as it would be rendered on phone
//     double picWidth = currentWidth * 0.9;
//     double marginPic = 0;
//     double paddingPic = 0;
//     const double borderRadiusPic = 10;

//     if (currentWidth >= narrowScreenWidthThreshold &&
//         currentWidth <= largeWidthBreakpoint) {
//       picWidth = currentWidth * 0.6;
//       marginPic = 0;
//       paddingPic = 0;
//     } else if (currentWidth >= largeWidthBreakpoint) {
//       picWidth = currentWidth * 0.4;
//       marginPic = 0;
//       paddingPic = 0;
//     }
//     return [
//       SizedBox(
//         height: getpagesSpacingToTop(context),
//       ),
//       Text(
//         "Blog is upcoming :))",
//         style: getTextStyleHeadings(context),
//         textAlign: TextAlign.center,
//       ),
//       SizedBox(
//         height: getpagesSpacingToTop(context),
//       ),
//       SizedBox(
//         width: picWidth,
//         child: applyBoxDecoration(
//             ClipRRect(
//               borderRadius: BorderRadius.circular(0),
//               child: Image.asset("assets/images/funny_programmer.gif"),
//             ),
//             EdgeInsets.all(paddingPic),
//             marginPic,
//             borderRadiusPic,
//             10),
//       ),
//       SizedBox(
//         height: getpagesSpacingToTop(context),
//       ),
//       SizedBox(
//         width: picWidth,
//         child: applyBoxDecoration(
//             ClipRRect(
//               borderRadius: BorderRadius.circular(0),
//               child: Image.asset("assets/images/cat-computer.gif"),
//             ),
//             EdgeInsets.all(paddingPic),
//             marginPic,
//             borderRadiusPic,
//             10),
//       ),
//       const SizedBox(height: 30),
//     ];
//     // LimitedBox(
//     //   maxHeight: 400,
//     //   maxWidth: 100,
//     //   child: Container(
//     //     height: 400,
//     //     child: Center(
//     //         child: Text('''
//     //             Rendering using hardware-assisted ray tracing and associated techniques are currently gaining in
//     //             importance in real-time computer graphics. Despite this new hardware support, only a little computing time
//     //             is given to calculate one single image. Along with this short computing time, there are fewer ray paths with accordingly fewer Length.
//     //             Previous work already has shown how to counteract the resulting image noise, included the blue noise error distributions and emphasized
//     //             and clarified their importance in increasing the perceptible image quality. This work explains a temporally stable algorithm based on this technique.
//     //             In contrast to the previous approaches, we want to apply an error redistribution directly in the image space, and so one accordingly to get
//     //             correlated pixel sequence. The algorithm achieves all of this without significant additional computing effort.''',
//     //             style: GoogleFonts.lato(fontStyle: FontStyle.italic))),
//     //   ),
//     // ),
//     // LimitedBox(
//     //   maxHeight: 800,
//     //   maxWidth: 200,
//     //   child: Container(
//     //     height: 2000,
//     //     child: const Center(child: Text('''
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros
//     //             et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet,
//     //             consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
//     //             Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
//     //             Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis
//     //             at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.
//     //             Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum.
//     //             Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
//     //             Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
//     //             Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, At accusam aliquyam diam diam dolore dolores duo eirmod eos erat,
//     //             et nonumy sed tempor et et invidunt justo labore Stet clita ea et gubergren, kasd magna no rebum. sanctus sea sed takimata ut vero voluptua.
//     //             est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et
//     //             dolore magna aliquyam erat.
//     //             Consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor
//     //             sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
//     //             At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
//     //             Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis
//     //             at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.
//     //             Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
//     //             Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.
//     //             Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros
//     //             et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.
//     //             Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit amet,
//     //             consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
//     //             Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo''')),
//     //   ),
//     // ),
//     // LimitedBox(
//     //   maxHeight: 200,
//     //   maxWidth: 200,
//     //   child: Container(
//     //     height: 500,
//     //     child: const Center(child: Text('''
//     //             Due to the increasing demand in gradient-based optimization, machine learning and probabilistic
//     //             inference techniques for various rendering applications derivation methods for
//     //             radiometric measurements with respect to scene parameters(e.g. material, object geometries)
//     //             experiences a high popularity among researchers. Unlike previous approaches which
//     //             are lacking at unbiased and efficient handling of discontinuities (e.g. visibility boundaries)
//     //             via edge integrals the new introduced integral formulation allows a new unbiased
//     //             monte carlo method for sampling these boundaries with a high quality. This high quality
//     //             standards are still reached under complex arbitrary scenes and difficult light transport
//     //             scenarios like caustics that previous approaches failed to meet.''')),
//     //   ),
//     // ),
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> blog = buildBlog(context);
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth > narrowScreenWidthThreshold) {
//           return Scaffold(
//             body: ListView(
//               children: <Widget>[const NavBar()] + blog,
//             ),
//           );
//         } else {
//           return Scaffold(
//             drawer: const NavigationDrawerWidget(),
//             appBar: AppBar(
//               title: const Text(appName),
//               backgroundColor: kPrimaryColor,
//               centerTitle: true,
//             ),
//             body: ListView(children: buildBlog(context)),
//           );
//         }
//       },
//     );
//   }
// }
