import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';

import '../constant/dark_color.dart';
import '../constant/light_color.dart';
import 'animatedcord_painter.dart';
import 'bulb_painter.dart';
import 'bulbbottom_curve.dart';
import 'bulboval_painter.dart';
import 'cord_painter.dart';
import 'line_painter.dart';

// ignore: must_be_immutable
class Development extends StatefulWidget {
  double mediaWidth;
  double mediaHeight;
  bool flag = false;
  Development({super.key, required this.mediaWidth, required this.mediaHeight});

  @override
  State<Development> createState() => _CordStretchState();
}

class _CordStretchState extends State<Development>
    with SingleTickerProviderStateMixin {
  late Offset startPosition;
  late Offset endPosition;

  bool flag = false;
  final player = AudioPlayer();
  //to control the animation
  late AnimationController animationController;

  //store different type of animations
  late Animation cordAnimation;
  late Animation upperCurveAnimation;
  late Animation lowerCurveAnimation;
  late Animation lowerCurveCompressAnimation;

  //when true start showing the animation
  bool showAnimation = false;

  bool showCord = true;

  bool isOff = true;

 

  late var upperCurveTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: 45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 45.0, end: -45.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -45.0, end: 25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: -25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 0), weight: 20),
  ]);

  var lowerCurveTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -50.0, end: 50.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 50.0, end: -25.0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -25.0, end: 25), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 25.0, end: 0), weight: 20),
  ]);

  var lowerCurveCompressTween = TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -20), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -20, end: 0), weight: 20),
    TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 20),
    TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 20),
  ]);

  initializeTween() {}

  playMusic() async {
    await player.play(AssetSource('audio/click.mp3'));
  }

  @override
  void initState() {
    //get the start and end position for the cord
    startPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2);
    endPosition = Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    //create animaiton for the upper curve
    upperCurveAnimation = upperCurveTween.animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //create animation for the lower curve
    lowerCurveAnimation = lowerCurveTween.animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //create animation for compress cord effect
    lowerCurveCompressAnimation = lowerCurveCompressTween.animate(
        CurvedAnimation(
            parent: animationController, curve: const Interval(0.18, 1.0)))
      ..addListener(() {
        setState(() {});
      });

    //listen to any changes
    animationController.addListener(() {
      double currentDuration =
          double.parse(animationController.value.toStringAsFixed(2));

      if (currentDuration == 0.2) {
        setState(() {
          //isOff = !isOff;
          showAnimation = true;
          showCord = false;
        });
      }
    });

    //listen to the status of the animation i.e completed, stopped etc
    animationController.addStatusListener((status) {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reset();
        setState(() {
          //isOff = !isOff;
          //isOff = !isOff;
          showCord = true;
          showAnimation = false;
          endPosition =
              Offset(widget.mediaWidth / 2, widget.mediaHeight / 2 + 100);
        });
      } else if (animationController.status == AnimationStatus.dismissed) {}
    });
    animationController.forward();
    super.initState();
  }
 var controller = TorchController();
 @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: widget.mediaHeight,
          width: widget.mediaWidth,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: isOff == true ? ColorOff.greyColor : ColorOn.yellowColor,
                child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 20), // Adjust the bottom padding as needed
        child: Text(
          "Developed By PicoDev",
          style: TextStyle(color: isOff == true ? Colors.white : Colors.black),
        ),
      ),
    ],
  ),
              ),
              
              showAnimation == true
                  ? CustomPaint(
                      painter: AnimatedCordPainter(
                          startPosition,
                          upperCurveAnimation.value,
                          lowerCurveAnimation.value,
                          lowerCurveCompressAnimation.value,
                          isOff),
                      child: const SizedBox(),
                    )
                  : const IgnorePointer(),
              //bulb root
              CustomPaint(
                  painter: BulbPainter(startPosition, endPosition, isOff),
                  child: Container()),

              //bulb bottom cord
              CustomPaint(
                  painter:
                      BulbBottomCurvePainter(startPosition, endPosition, isOff),
                  child: Container()),

              //bulb bottom cord
              CustomPaint(
                  painter: BulbOvalPainter(startPosition, endPosition, isOff),
                  child: Container()),

              //oval painter
              CustomPaint(
                  painter: LinePainter(startPosition, endPosition, isOff),
                  child: Container()),

              //Conditional Rendering: if true show the original cord
              showCord == true
                  ? GestureDetector(
                      onPanDown: (details) {},
                      onPanUpdate: (details) {
                        //when ever you drag your finger change the
                        //endposition with new coordinates and update
                        //the state. you will be able to achieve the
                        //drag effect
                        setState(() {
                          endPosition = Offset(details.globalPosition.dx,
                              details.globalPosition.dy);
                        });
                      },
                      //when you lift you finger up show the animation
                      onPanEnd: (details) async {
                        ////Uncomment: the below lines to turn the flash light on and off too

                         if (flag == false) { 
                           controller.toggle();
                         } else {
                           controller.toggle();
                         }
                        flag = !flag;
                        //function to play the music
                        playMusic();
                        //flag = !flag;
                        setState(() {
                          isOff = !isOff;
                        });
                        //animate the cord back to the original position
                        cordAnimation = Tween<Offset>(
                                begin: endPosition,
                                end: Offset(widget.mediaWidth / 2,
                                    widget.mediaHeight / 2 + 100))
                            .animate(
                          CurvedAnimation(
                            parent: animationController,
                            curve: const Interval(0, 0.2, curve: Curves.linear),
                          ),
                        )..addListener(() {
                            setState(() {
                              endPosition = cordAnimation.value;
                            });
                          });

                        animationController.forward();
                      },
                      child: CustomPaint(
                        painter: CordPainter(startPosition ,endPosition, isOff),
                        child: Container(),
                      ),
                    )
                  : const IgnorePointer(),
            ],
          ),
        ));
  }
}
