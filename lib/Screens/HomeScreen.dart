import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Screens/NewTaskScreen.dart';
import 'package:todo_task/Utilities/bloc.dart';

class HomeScreen extends StatefulWidget {
  static String navtag = 'home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final linker = Provider.of<Linker>(context);
    setState(() {
      linker.updateView();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Todo App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Your Tasks',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, childAspectRatio: 0.7),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    
                    return GestureDetector(
                      onLongPress: () {},
                      onTap: () {},
                      child: ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Color(linker.taskList[index].color),
                                  width: 1),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                                child: Container(
                                  height: 120,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Color(linker.taskList[index].color),
                                  ),
                                  child: Image.asset('assets/images/food.png'),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                linker.taskList[index].time,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                linker.taskList[index].date,
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                linker.taskList[index].title,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  linker.taskList[index].description,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: linker.count,
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 30,
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, NewTaskScreen.navtag);
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
