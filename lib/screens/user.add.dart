import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:usuario_firebase/model/user.model.dart';
import 'package:usuario_firebase/repository/user.repo.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ctrname = TextEditingController();
    final _ctrage = TextEditingController();
    final pageViewController = PageController();

    return DefaultTabController(
      //appBar: AppBar(title: Text('Adicionar Usuário'),),
      length: 3,
        child: Scaffold(
          body: PageView(
            controller: pageViewController,
            children: const [
              Center(child: Text('Página 1'),),
              Center(child: Text('Página 2'),),
              Center(child: Text('Página 3'),),
            ],
          ),

        ),
    );
  }
}