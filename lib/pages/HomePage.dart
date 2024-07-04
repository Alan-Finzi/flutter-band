import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/band.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List<Band> bands =[
  Band(id: '1', name: 'metalica', vote: 5),
  Band(id: '2', name: 'duki', vote: 4),
  Band(id: '3', name: 'emilia', vote: 3),
  Band(id: '4', name: 'maria', vote: 2),
];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body:  ListView.builder(
        itemCount: bands.length,
          itemBuilder:(BuildContext context, int index) =>_bandsTile(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:addnewBand,
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Dismissible _bandsTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){

      },
      background: Container(
        padding: const EdgeInsets.only(left: 8),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
            child: Text('delete Band',style: TextStyle(color: Colors.white),)),
      ),
      child: ListTile(
              leading: CircleAvatar(
                child: Text(band.name.substring(0,2)),
                backgroundColor: Colors.blue[100],
              ),
        title: Text(band.name),
        trailing: Text("${band.vote}"),
            ),
    );
  }

  addnewBand(){
    final textController = new TextEditingController();
    if(Platform.isAndroid){
     return showDialog(
          context: context,
          builder:(context){
            return AlertDialog(
              title: const Text('new band name'),
              content:  TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                    elevation: 1,
                    child: const Text('add'),
                    onPressed: ()=> addBandToList(textController.text)
                )
              ],
            );
          }
      );
    }else{
      showCupertinoDialog(
          context: context,
          builder: (_){
            return CupertinoAlertDialog(
              title: Text('new band'),
              content: CupertinoTextField(controller: textController,),
              actions: [
                CupertinoDialogAction(
                    child: Text('add'),
                    onPressed: ()=> addBandToList(textController.text)
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                    child: Text('Dismiss'),
                    onPressed: ()=> Navigator.pop(context)
                )
              ],
            );
          }
      );
    }

  }

  void addBandToList(String name){
    if(name.length > 1){
      this.bands.add( Band(id: DateTime.now().toString(), name: name, vote: 15));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
