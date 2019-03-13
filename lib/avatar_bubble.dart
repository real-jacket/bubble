import 'package:flutter/material.dart';
// import 'dart:math';

class Avatar extends StatelessWidget {
  Avatar({Key key, this.url}) : super(key: key);

  final url;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: Colors.yellow),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.asset(
          url,
          width: 50.0,
        ),
      ),
    );
  }
}

class BubbleAnimation extends StatelessWidget {
  BubbleAnimation(
      {Key key,
      this.controller,
      this.height,
      this.width,
      this.url,
      this.active})
      : super(key: key) {
    // 大小变化
    scale = Tween<double>(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(.0, 0.1, curve: Curves.linear)));

    // final double randomX = Random().nextDouble() * width;
    // final double randomY = Random().nextDouble() * height;
    // print('height$height');
    // print('width$width');
    // print(randomX);
    // print(randomY);

    // 水平位移
    positionX = Tween<double>(
      begin: 100,
      end: 150,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 1, curve: Curves.bounceInOut)));

    //垂直位移
    positionY = Tween<double>(
      begin: 400,
      end: 600,
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
  String url;
  bool active;

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
                child: Avatar(
                  url: url,
                ),
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
  BubbleDemo({Key key, this.url, this.active, this.index}) : super(key: key);

  final String url;
  final bool active;
  var index;
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
    if (widget.active) {
      _controller.forward();
    }
    // if (_controller.isCompleted) {
    //   widget.index['n'] += 1;
    // }
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.index['n'] += 1;
      }
    });
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
    return BubbleAnimation(
      url: widget.url,
      controller: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

List<BubbleDemo> generateBubble() {
  var num = {'n': 0};
  final List<String> imgList = [
    "assets/images/cat.jpg",
    "assets/images/avatar.png",
    "assets/images/dog.jpg",
    "assets/images/girl.jpg",
    "assets/images/panda.jpg",
  ];
  List<BubbleDemo> bubbleList = [];

  for (var i = 0; i < imgList.length; i++) {
    bubbleList
        .add(BubbleDemo(url: imgList[i], active: i == num['n'], index: num));
  }
  return bubbleList;
}
