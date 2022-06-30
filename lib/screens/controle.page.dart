import 'package:flutter/material.dart';
import 'package:usuario_firebase/screens/allusers.page.dart';
import 'package:usuario_firebase/screens/user.find.dart';
import 'user.add.dart';
import 'package:usuario_firebase/screens/user.add.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Gestão de Usuários'),
            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.supervised_user_circle_sharp, size: 28,), text: 'Add',),
                Tab(icon: Icon(Icons.edit_attributes, size: 28,), text: 'Editar',),
                Tab(icon: Icon(Icons.search, size: 28,), text: 'Procurar',),
                Tab(icon: Icon(Icons.history, size: 28,), text: 'Histórico',),
              ],
            ),
          ),
          body: TabBarView(
            children: const [
              AddUserPage(),
              AllUsers(),
              FindUser(),
              Center(child: Text('Página 4'),),
            ],
          ),
        ));
  }
}
