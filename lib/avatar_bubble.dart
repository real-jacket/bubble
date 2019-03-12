import 'package:flutter/material.dart';
import 'dart:math';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.yellow),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          "assets/images/avatar.png",
          width: 50.0,
        ),
      ),
    );
  }
}

class BubbleAnimation extends StatelessWidget {
  BubbleAnimation({Key key, this.controller,this.height,this.width}) : super(key: key) {
    // 大小变化
    scale = Tween<double>(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(.0, 0.1, curve: Curves.linear)));

    final double randomX = Random().nextDouble() * height;
    final double randomY = Random().nextDouble() * width;
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;

    // 水平位移
    positionX = Tween<double>(
      begin: randomX,
      end: randomX + 100.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 1, curve: Curves.bounceInOut)));

    //垂直位移
    positionY = Tween<double>(
      begin: randomY,
      end: randomY + 200.0,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.1, 1, curve: Curves.linear)));
    // fade消失
    opacity = Tween<double>(begin: 1.0, end: .0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.6, 1.0, curve: Curves.linear)));
  }
  final Animation<double> controller;
  Animation<double> positionX;
  Animation<double> positionY;
  Animation<double> scale;
  Animation<double> opacity;
  double height;
  double width;
  double direction;
  double speed;
  

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Stack(
      children: <Widget>[
        Positioned(
            left: positionX.value,
            bottom: positionY.value,
            child: FadeTransition(
              opacity: opacity,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: scale,
                child: Avatar(),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}



class BubbleDemo extends StatefulWidget {
  @override
  _BubbleDemoState createState() => _BubbleDemoState();
}

class _BubbleDemoState extends State<BubbleDemo> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
  }

  // Future<Null> _playAnimation() async {
  //   try {
  //     await _controller.forward().orCancel;

  //     await _controller.reverse().orCancel;
  //   } on TickerCanceled {
  //     // 动画取消
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _controller.forward();
        },
        child: Stack(
          children: <Widget>[
            BubbleAnimation(
              controller: _controller,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            BubbleAnimation(
              controller: _controller,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            BubbleAnimation(
              controller: _controller,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            BubbleAnimation(
              controller: _controller,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ));
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}