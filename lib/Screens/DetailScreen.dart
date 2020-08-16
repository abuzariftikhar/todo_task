import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class DetailScreen extends StatefulWidget {
  static String navtag = 'detail';
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: Text(
                    'Task Details',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  elevation: 1,
                  centerTitle: true,
                ),
                SliverToBoxAdapter(
                  child: AnimatedContainer(
                    height: 250,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xffffe3dc),
                    ),
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.all(30),
                    child: Image.asset('assets/images/food.png'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          'Eat healthy food',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      )),
                ),
                SliverToBoxAdapter(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('20th August, 2020'),
                        Text('11:30 PM'),
                      ],
                    ),
                  )),
                ),
                SliverToBoxAdapter(
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(20),
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.shade100),
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'This is the task description area which user can add and it can conatain only text for the moment but later on things like bullet points and check lists will be added so the user may have more choice.',
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 70,
                  ),
                )
              ],
            ),
            Menu()
          ],
        ),
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  double optWidth = 120;
  double optRadius = 15;
  bool isOpened = false;
  AnimationController _controller;
  SequenceAnimation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1)
                .chain(CurveTween(curve: Curves.ease)),
            from: Duration(milliseconds: 0),
            to: Duration(milliseconds: 400),
            tag: 'opacity')
        .animate(_controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        getMenuChildren(isOpened),
        Align(
          alignment: Alignment.bottomRight,
          child: GestureDetector(
            onTap: () {
              if (!_controller.isAnimating) {
                if (optWidth == 50) {
                  _controller.reverse(from: 1);
                  Future.delayed(Duration(milliseconds: 500), () {
                    setState(() {
                      optWidth = 120;
                      optRadius = 15;
                      isOpened = false;
                    });
                  });
                } else if (optWidth == 120) {
                  setState(() {
                    _controller.forward(from: 0);
                    optWidth = 50;
                    optRadius = 25;
                    isOpened = true;
                  });
                } else {
                  return;
                }
              }
            },
            child: AnimatedContainer(
              height: 50,
              width: optWidth,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(optRadius),
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(blurRadius: 20, color: Color(0xffffe3dc))
                  ]),
              margin: EdgeInsets.all(30),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOutCirc,
              child: Center(child: getMenuChild(isOpened)),
            ),
          ),
        ),
      ],
    );
  }

  Widget getMenuChildren(bool isOpened) {
    Widget widget;
    if (isOpened) {
      widget = Stack(
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Container(
                    color:
                        Colors.white.withOpacity(_animation['opacity'].value));
              }),
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuItem(
                    title: 'Acheive',
                    icon: Icons.add_to_home_screen,
                    color: Colors.purple.shade100,
                    controller: _controller,
                    startDelay: 0,
                    endDelay: 200,
                    ontap: () {}),
                SizedBox(
                  width: 40,
                ),
                MenuItem(
                    title: 'Delete Task',
                    icon: Icons.delete_outline,
                    color: Colors.pink.shade100,
                    controller: _controller,
                    startDelay: 150,
                    endDelay: 100,
                    ontap: () {}),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuItem(
                    title: 'Mark as done',
                    icon: Icons.done,
                    color: Colors.lightGreen.shade100,
                    controller: _controller,
                    startDelay: 150,
                    endDelay: 100,
                    ontap: () {}),
                SizedBox(
                  width: 40,
                ),
                MenuItem(
                    title: 'Edit Task',
                    icon: Icons.mode_edit,
                    color: Colors.blue.shade100,
                    controller: _controller,
                    startDelay: 150,
                    endDelay: 100,
                    ontap: () {}),
              ],
            ),
            SizedBox(
              height: 100,
            ),
          ]),
        ],
      );
    } else {
      widget = Container();
    }
    return widget;
  }

  Widget getMenuChild(bool isOpened) {
    Widget widget;
    if (!isOpened) {
      widget = Text(
        'Options',
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      );
    } else {
      widget = Icon(
        Icons.close,
        color: Colors.white,
      );
    }
    return widget;
  }
}

class MenuItem extends StatefulWidget {
  final String title;
  final AnimationController controller;
  final int startDelay;
  final int endDelay;
  final Function ontap;
  final IconData icon;
  final Color color;

  MenuItem(
      {@required this.title,
      @required this.icon,
      @required this.color,
      @required this.controller,
      @required this.startDelay,
      @required this.endDelay,
      @required this.ontap});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  SequenceAnimation _animation;
  @override
  void initState() {
    _animation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1)
                .chain(CurveTween(curve: Curves.ease)),
            from: Duration(milliseconds: 0),
            to: Duration(milliseconds: 400),
            tag: 'opacity')
        .addAnimatable(
            animatable: Tween<double>(begin: 1.1, end: 1)
                .chain(CurveTween(curve: Curves.easeInOutCirc)),
            from: Duration(milliseconds: widget.startDelay),
            to: Duration(milliseconds: 300 + widget.endDelay),
            tag: 'scale')
        .animate(widget.controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, w) {
          return Opacity(
              opacity: _animation['opacity'].value,
              child: Transform.scale(
                scale: _animation['scale'].value,
                child: Container(
                  height: 100,
                  width: 120,
                  decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(blurRadius: 40, color: widget.color)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(widget.icon), Text(widget.title)],
                  ),
                ),
              ));
        });
  }
}
