import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Data/RepoHelper.dart';
import 'package:todo_task/Data/TaskModel.dart';
import 'package:todo_task/Utilities/bloc.dart';
import 'package:todo_task/WidgetFactory/ForNewTask.dart';

class NewTaskScreen extends StatefulWidget {
  static String navtag = 'new';
  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPageView(
      titlesOfPages: [
        '',
        'Add title',
        'Set Category',
        'Add description',
        'Review'
      ],
    ));
  }
}

class CustomPageView extends StatefulWidget {
  final List<String> titlesOfPages;

  CustomPageView({
    @required this.titlesOfPages,
  });
  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView>
    with TickerProviderStateMixin {
  AnimationController _titleController;
  TextEditingController titleTextcontroller;
  TextEditingController descriptionTextcontroller;
  final _formkey = GlobalKey<FormState>();
  final RepositoryHelper repositoryHelper = RepositoryHelper();

  SequenceAnimation titleAnimation;
  SequenceAnimation widgetAnimation;
  int i = 0;
  int widgetIndex = 0;

  Linker categoryHelper = Linker();

  @override
  void initState() {
    _titleController = AnimationController(vsync: this);
    titleTextcontroller = TextEditingController(text: '');
    descriptionTextcontroller = TextEditingController(text: '');
    titleAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1)
                .chain(CurveTween(curve: Curves.ease)),
            from: Duration(milliseconds: 0),
            to: Duration(milliseconds: 300),
            tag: 'opacity')
        .addAnimatable(
            animatable: Tween<double>(begin: 1, end: 0)
                .chain(CurveTween(curve: Curves.ease)),
            from: Duration(milliseconds: 700),
            to: Duration(milliseconds: 1000),
            tag: 'opacity')
        .addAnimatable(
            animatable: Tween<double>(begin: 30, end: -30)
                .chain(CurveTween(curve: Curves.slowMiddle)),
            from: Duration(milliseconds: 0),
            to: Duration(milliseconds: 1000),
            tag: 'translate')
        .animate(_titleController);
    super.initState();
  }

  Widget getWidget(int index, String categotyText, Color categoryColor) {
    Widget widget = CircleAvatar(
      radius: 60,
      backgroundColor: Colors.yellow,
    );
    if (index == 0) {
      setState(() {
        widget = CircleAvatar(
          radius: 60,
          backgroundColor: Colors.yellow,
        );
      });
    } else if (index == 1) {
      setState(() {
        widget = Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Name your Task.',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900),
                ),
                TextFormField(
                  showCursor: true,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  controller: titleTextcontroller,
                  scrollPhysics: BouncingScrollPhysics(),
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      });
    } else if (index == 2) {
      setState(() {
        widget = SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Set in a Category.',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  children: [
                    CatagoryTile(title: 'Default'),
                    CatagoryTile(title: 'Learning/ Building Skill'),
                    CatagoryTile(title: 'Project'),
                    CatagoryTile(title: 'Food/Diet'),
                    CatagoryTile(title: 'Party'),
                    CatagoryTile(title: 'Teaching'),
                    CatagoryTile(title: 'Coding'),
                    CatagoryTile(title: 'Health/ Training'),
                    CatagoryTile(title: 'Travel'),
                    CatagoryTile(title: 'Cooking'),
                    CatagoryTile(title: 'Others'),
                  ],
                ),
              ),
              Text(
                'Choose a color',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  children: [
                    CatagoryColor(
                      color: Colors.blue.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.green.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.red.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.yellow.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.purple.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.indigoAccent.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.orange.shade100,
                    ),
                    CatagoryColor(
                      color: Colors.teal.shade100,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
    } else if (index == 3) {
      setState(() {
        widget = Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Add description about task.',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900),
                ),
                TextFormField(
                  showCursor: true,
                  maxLines: null,
                  controller: descriptionTextcontroller,
                  scrollPhysics: BouncingScrollPhysics(),
                  enableInteractiveSelection: true,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.black,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      });
    } else if (index == 4) {
      setState(() {
        widget = Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Review your Task',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Title: ${titleTextcontroller.text}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Category: $categotyText',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: categoryColor,
                  ),
                  child: Text(
                    'Description: ${descriptionTextcontroller.text}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      });
    }
    return widget;
  }

  Color getBgColor(int index) {
    Color color = Colors.yellow.shade50;

    if (index == 0) {
      setState(() {
        color = Colors.yellow.shade50;
      });
    } else if (index == 1) {
      setState(() {
        color = Colors.blue.shade50;
      });
    } else if (index == 2) {
      setState(() {
        color = Colors.pink.shade50;
      });
    } else if (index == 3) {
      setState(() {
        color = Colors.green.shade50;
      });
    } else if (index == 4) {
      setState(() {
        color = Colors.white;
      });
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final helper = Provider.of<Linker>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      color: getBgColor(i),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
              child: Form(
                  key: _formkey,
                  child: getWidget(
                      widgetIndex, helper.categoryValue, helper.colorValue))),
          AnimatedBuilder(
              animation: _titleController,
              builder: (context, w) {
                return Transform.translate(
                  offset: Offset(titleAnimation['translate'].value, 0),
                  child: Opacity(
                    opacity: titleAnimation['opacity'].value,
                    child: IgnorePointer(
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Text(
                          widget.titlesOfPages[i],
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomRight,
            child: i == 4
                ? GestureDetector(
                    onTap: () {
                      repositoryHelper.create(Task(
                          title: titleTextcontroller.text,
                          description: descriptionTextcontroller.text,
                          date: DateTime.now().day.toString()+ '-'+DateTime.now().month.toString()+ '-'+DateTime.now().year.toString(),
                          time: (TimeOfDay.now().format(context)).toString(),
                          category: helper.categoryValue,
                          color: helper.colorValue.value));
                          helper.update();
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade900,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Finish',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      if (i < 4) {
                        _titleController.forward(from: 0);
                        setState(() {
                          i++;
                        });
                        Future.delayed(Duration(milliseconds: 500), () {
                          setState(() {
                            widgetIndex++;
                          });
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: GestureDetector(
              onTap: () {
                if (i > 0) {
                  _titleController.reverse(from: 1);
                  setState(() {
                    i--;
                  });

                  Future.delayed(Duration(milliseconds: 500), () {
                    setState(() {
                      widgetIndex--;
                    });
                  });
                }
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  color: i == 0 ? Color(0x00ffffff) : Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Previous',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
