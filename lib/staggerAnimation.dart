import 'package:flutter/material.dart';
// 交错动画，柱状图增长动画
// 动画需求
//1.开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
//2.高度增长到300后，开始沿X轴向右平移100像素；这个过程占用整个动画时间的40%。

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    //高度动画
    height = Tween<double>(
      begin: .0,
      end: 200.0,
    ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.6, // 间隔， 前60%的动画时间
            curve: Curves.ease)));

    // 颜色动画
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease)));

    // x轴平移变化
    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: 0),
      end: EdgeInsets.only(left: 100.0),
    ).animate(CurvedAnimation(
        parent: controller, curve: Interval(0.6, 1.0, curve: Curves.ease)));
  }


  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
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

// 启动动画路由

class StaggerDemo extends StatefulWidget {
  @override
  _StaggerDemoState createState() => _StaggerDemoState();
}

class _StaggerDemoState extends State<StaggerDemo>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  Future<Null> _playAnimation() async {
    try {
      await _controller.forward().orCancel;

      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // 动画取消
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 200.0,
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          child: StaggerAnimation(
            controller: _controller,
          ),
        ),
      ),
    );
  }
}