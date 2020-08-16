import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/Utilities/bloc.dart';

class CatagoryTile extends StatefulWidget {
  final String title;
  CatagoryTile({@required this.title});
  @override
  _CatagoryTileState createState() => _CatagoryTileState();
}

class _CatagoryTileState extends State<CatagoryTile> {
  @override
  Widget build(BuildContext context) {
    final linker = Provider.of<Linker>(context);
    return GestureDetector(
      onTap: () {
        linker.categoryValue = widget.title;
        linker.update();
        print(linker.categoryValue);
      },
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              linker.categoryValue == widget.title ? Colors.pink : Colors.white,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: linker.categoryValue == widget.title
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }
}

class CatagoryColor extends StatefulWidget {
  final Color color;
  CatagoryColor({@required this.color});
  @override
  _CatagoryColorState createState() => _CatagoryColorState();
}

class _CatagoryColorState extends State<CatagoryColor> {
  @override
  Widget build(BuildContext context) {
    final linker = Provider.of<Linker>(context);
    return GestureDetector(
      onTap: () {
        linker.colorValue = widget.color;
        linker.update();
      },
      child: AnimatedContainer(
        padding: EdgeInsets.all(5),
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              linker.colorValue == widget.color ? Colors.black : Colors.white,
        ),
        child: Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}


