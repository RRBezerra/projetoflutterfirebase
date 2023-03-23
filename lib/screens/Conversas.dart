import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:usuario_firebase/screens/widgets/user.list.dart';
import 'package:usuario_firebase/model/user.model.dart';

class Conversas extends StatefulWidget {
  const Conversas({Key? key}) : super(key: key);

  @override
  _ConversasState createState() => _ConversasState();
}

class _ConversasState extends State<Conversas> {

  @override
  Widget build(BuildContext context) {
    List<User> conversas =[];

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
            .orderBy('nome')
            .snapshots(),
        builder: (context, snp) {
          if (snp.hasError) {
            return Center(child: Text('Error'),);
          }
          if (snp.hasData) {
            conversas = snp.data!.docs
                .map((doc) =>
                User.fromJson(doc.data() as Map<String, dynamic>)).toList();

            return Container(


              child: Scaffold(
                  appBar: AppBar(
                    title: const Text(style: TextStyle(
                        color: Colors.black,
                        fontSize: 28.0) ,
                        'Conversas'),
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        tooltip: 'Show Snackbar',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('This is a snackbar')));
                        },
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        tooltip: 'Show Snackbar',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('This is a snackbar')));
                        },
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings),
                        tooltip: 'Show Snackbar',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('This is a snackbar')));
                        },
                        color: Colors.black,
                      ),
                      IconButton(
                        icon: const Icon(Icons.dehaze),
                        tooltip: 'Go to the next page',
                        color: Colors.black,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: const Text('Next page'),
                                ),
                                body: const Center(
                                  child: Text(
                                    'This is the next page',
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                              );
                            },
                          ));
                        },
                      ),
                    ],
                  ),
                  body: ListUsers(users: conversas),
              )
            );

          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

