import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _namecon=TextEditingController();

  void _submitFormOnLogin() async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseFirestore.instance.collection('Users').doc(id).set({
        'Name' : _namecon.text
      });

    } catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _namecon,
          ),
          ElevatedButton(onPressed: _submitFormOnLogin, child: Text('Submit'))
        ],
      ),
    );
  }
}
