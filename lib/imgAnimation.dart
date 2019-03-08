import 'package:flutter/material.dart';

class AnimateImage extends AnimatedWidget {
  AnimateImage({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.asset(
        'assets/images/avatar.png',
        width: animation.value,
        height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1), vsync: this,
    );
    // 宽度从0变到300
    curve = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(begin: 0.0, end: 300.0).animate(curve);
    // ..addListener((){
    //   setState(()=>{});
    // });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 动画执行结束时反向执行动画

        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        // 动画恢复到初始状态时执行动画（正向）
        controller.forward();
      }
    });

    //启动会动画（正向执行）
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.asset('assets/images/avatar.png',
    //     width: animation.value,
    //     height: animation.value,
    //   ),
    // );
    // return AnimateImage(animation: animation,);
    // return AnimatedBuilder(
    //   animation: animation,
    //   child: Image.asset('assets/images/avatar.png'),
    //   builder: (BuildContext context,Widget child){
    //     return Center(
    //       child: Container(
    //         height: animation.value,
    //         width: animation.value,
    //         child: child,
    //       ),
    //     );
    //   },
    // );
    return GrownTansition(
      child: Image.asset('assets/images/avatar.png'),
      animation: animation,
    );
  }

  @override
  void dispose() {
    //路由销毁时需要释放资源
    controller.dispose();
    super.dispose();
  }
}

//封装动画
class GrownTansition extends StatelessWidget {
  GrownTansition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
