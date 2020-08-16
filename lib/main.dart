import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Data/Injection.dart';
import 'package:todo_task/Screens/DetailScreen.dart';
import 'package:todo_task/Screens/EditTaskScreen.dart';
import 'package:todo_task/Screens/HomeScreen.dart';
import 'package:todo_task/Utilities/bloc.dart';
import 'Screens/NewTaskScreen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Injection.initInjection();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Linker>(
      create: (context) => Linker(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'google',
          primarySwatch: Colors.grey,
        ),
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          HomeScreen.navtag: (context) => HomeScreen(),
          NewTaskScreen.navtag: (context) => NewTaskScreen(),
          EditTaskScreen.navtag: (context) => EditTaskScreen(),
          DetailScreen.navtag: (context) => DetailScreen()
        },
      ),
    );
  }
}
