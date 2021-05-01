import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    required this.animation1,
    this.delayHeader,
    required this.isRemoving,
  }) : super(key: key);

  final Animation<double> animation1;
  final bool? delayHeader;
  final bool isRemoving;

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool visible = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    // animation = Tween<double>(begin: 0, end: 1).animate(controller)
    //   ..addListener(() {
    //     setState(() {
    //       // The state that has changed here is the animation object’s value.
    //     });
    //   });

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutQuad,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (false) {
      return SizeTransition(
        axisAlignment: -1,
        sizeFactor: animation,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 16),
          // margin: const EdgeInsets.only(
          //   bottom: 32,
          //   top: 16,
          // ),
          // width: animation.value,
          child: const Text('Today'),
        ),
      );
      // return FutureBuilder<void>(
      //     future: Future.delayed(const Duration(milliseconds: 50)),
      //     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return Container(
      //           // margin: const EdgeInsets.only(
      //           //   bottom: 32,
      //           //   top: 16,
      //           // ),
      //           // width: animation.value,
      //           child: const Text('Today'),
      //         );
      //       } else {
      //         return Container();
      //       }
      //     });
    } else {
      // return Container();
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 16),
        // margin: const EdgeInsets.only(
        //   bottom: 32,
        //   top: 16,
        // ),
        // width: animation.value,
        child: const Text('Today'),
      );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

//     import 'package:flutter/animation.dart';
//                          import 'package:flutter/material.dart';
//                          void main() => runApp(LogoApp());
// @@ -6,16 7,39 @@
//                            _LogoAppState createState() => _LogoAppState();
//                          }
//             -            class _LogoAppState extends State<LogoApp> {
//             +            class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
//             +              late Animation<double> animation;
//             +              late AnimationController controller;
//             +
//             +              @override
//             +              void initState() {
//             +                super.initState();
//             +                controller =
//             +                    AnimationController(duration: const Duration(seconds: 2), vsync: this);
//             +                animation = Tween<double>(begin: 0, end: 300).animate(controller)
//             +                  ..addListener(() {
//             +                    setState(() {
//             +                      // The state that has changed here is the animation object’s value.
//             +                    });
//             +                  });
//             +                controller.forward();
//             +              }
//             +
//                            @override
//                            Widget build(BuildContext context) {
//                              return Center(
//                                child: Container(
//                                  margin: EdgeInsets.symmetric(vertical: 10),
//             -                    height: 300,
//             -                    width: 300,
//             +                    height: animation.value,
//             +                    width: animation.value,
//                                  child: FlutterLogo(),
//                                ),
//                              );
//                            }
//             +
//             +              @override
//             +              void dispose() {
//             +                controller.dispose();
//             +                super.dispose();
//             +              }
//                          }
