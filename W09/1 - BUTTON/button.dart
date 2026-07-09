import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:w09/1%20-%20START%20CODE/1%20-%20BUTTON/repo.dart';

enum AsyncData { notstarted, loading, error, success }

class Buton extends StatefulWidget {
  const Buton({super.key});

  @override
  State<Buton> createState() => _ButonState();
}

class _ButonState extends State<Buton> {
  AsyncData data = AsyncData.notstarted;
  //String? error;
  ButtonStatus? button;
  bool select = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() async {
    try {
      data = AsyncData.loading;
      setState(() {});

      button = await getButtonStatus();
      select = button!.selected;
      data = AsyncData.success;
      setState(() {});
    } catch (e) {
      data = AsyncData.error;
      setState(() {});
    }
  }

  void isSelected() {
    setState(() {
      select = !select;
    });
  }

  Widget get content {


    if (data == AsyncData.loading) {
      return CircularProgressIndicator();
    } else if (data == AsyncData.notstarted) {
      return Text("Press to fetch");
    } else if (data == AsyncData.success) {
          Color c = Colors.blue;
    String name = button!.name;

    if (select == false) {
      name = "Before";
      c = Colors.grey;
    }
      return ElevatedButton(
        onPressed: isSelected,
        child: Text(name),
        style: ElevatedButton.styleFrom(backgroundColor: c),
      );
    } else if (data == AsyncData.error) {
      return SizedBox(
        height: 100,
        child: Text("Error", style: TextStyle(color: Colors.red)),
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: 100,
    //   child: ElevatedButton(
    //     onPressed: () {},
    //     child: Text("click me", style: TextStyle(fontSize: 22)),
    //   ),
    // );
    return content;
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Firebase Button"),
          backgroundColor: Colors.grey[600],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Buton()],
          ),
        ),
      ),
    ),
  );
}
