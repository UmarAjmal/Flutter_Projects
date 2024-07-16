import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String data ='';

  void getData()async{
    DocumentSnapshot usnap= await FirebaseFirestore.instance.collection('Users').doc('01').get();
    setState(() {
      data= usnap.get('Name');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data?.docs.isNotEmpty == true) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${snapshot.data.docs[index]['Name']}'),
                  );
                },
              );
            } else {
              return Center(
                child: Text('There is no Data!',
                    style: Theme.of(context).textTheme.labelMedium),
              );
            }
          }
          return Center(
            child: Text('Something went wrong',
                style: Theme.of(context).textTheme.labelMedium),
          );
        },
      )
    );
  }
}
