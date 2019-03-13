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
        child: Image.network(
          url,
          width: 50.0,
        ),
        // Image.asset(
        //   url,
        //   width: 50.0,
        // ),
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
  BubbleDemo({Key key, this.url, this.active}) : super(key: key);

  final String url;
  final active;
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

    // if (_controller.isCompleted) {
    //   widget.index['n'] += 1;
    // }
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('动画结束$status');
        widget.active();
        _controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
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

class BubbleList extends StatefulWidget {
  @override
  _BubbleListState createState() => _BubbleListState();
}

class _BubbleListState extends State<BubbleList> {
  int _index = 0;
  // final List<String> imgList = [
  //   "assets/images/cat.jpg",
  //   "assets/images/avatar.png",
  //   "assets/images/dog.jpg",
  //   "assets/images/girl.jpg",
  //   "assets/images/panda.jpg",
  // ];
  final List<String> imgList = [
    "http://img5.duitang.com/uploads/item/201410/02/20141002212239_zWR55.jpeg",
    "http://b-ssl.duitang.com/uploads/item/201812/05/20181205211932_xvslr.jpeg",
    "http://img4.duitang.com/uploads/item/201412/20/20141220202258_a82Jw.thumb.700_0.jpeg",
    "http://b-ssl.duitang.com/uploads/item/201812/05/20181205110157_KXzP5.jpeg",
    "http://img.qqzhi.com/uploads/2018-12-23/085251409.jpg",
  ];

  void _callBack() {
    print('执行了一次');
    setState(() {
      if (_index >= imgList.length - 1) {
        _index = 0;
      } else {
        _index += 1;
      }
    });
    print('index$_index');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      BubbleDemo(url: imgList[_index], active: _callBack)
    ]);
  }
}

// List<BubbleDemo> generateBubble() {
//   var num = {'n': 0};
//   final List<String> imgList = [
//     "assets/images/cat.jpg",
//     "assets/images/avatar.png",
//     "assets/images/dog.jpg",
//     "assets/images/girl.jpg",
//     "assets/images/panda.jpg",
//   ];

//   void callback() {
//     num['n'] += 1;
//   }

//   print(num['n']);
//   List<BubbleDemo> bubbleList = [];

//   for (var i = 0; i < imgList.length; i++) {
//     bubbleList
//         .add(BubbleDemo(url: imgList[i], active: callback, index: num, i: i));
//   }
//   return bubbleList;
// }
