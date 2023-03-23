import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:usuario_firebase/screens/findusers.page_old.dart';
import '../../model/user.model.dart';
import 'package:usuario_firebase/repository/user.repo.dart';

class SearchUsers extends StatefulWidget {
  List<User> users;
  SearchUsers({required this.users});

  @override
  _SearchUsersState createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {

  @override
  Widget build(BuildContext context) {
    var allusers = widget.users;
    final ctrupdatenome = TextEditingController();
    final _ctrupdateidade = TextEditingController();

    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
                child: TextField(
                  controller: ctrupdatenome,
                  onChanged: (text) {
                    //print("text $text");

                    allusers = BuscarUsuario(ctrupdatenome.text);

                  },
                  decoration: InputDecoration(
                  labelText: "Procurar usuários",
                  hintText: "Informe o nome do usuário",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius:
                      BorderRadius.all(Radius.circular(25.0)))),
                ),
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: allusers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(allusers[index].nome.substring(0,2).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        title: Text(allusers[index].nome, style: TextStyle(fontSize: 22),),
                        subtitle: Text(allusers[index].idade.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: (){
                              ctrupdatenome.text = allusers[index].nome;
                              _ctrupdateidade.text = allusers[index].idade.toString();
                              showDialog(context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text('Atualizar: ${allusers[index].nome}'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 250,
                                        child: Column(
                                          children: [
                                            TextField(
                                              style: TextStyle(fontSize: 22, color: Colors.blue),
                                              decoration: InputDecoration(labelText: 'Nome',
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)))),
                                              controller: ctrupdatenome,
                                            ),
                                            SizedBox(height: 20,),
                                            TextField(
                                              style: TextStyle(fontSize: 22, color: Colors.blue),
                                              decoration: InputDecoration(labelText: 'Idade',
                                                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(40)))),
                                              controller: _ctrupdateidade,
                                            ),
                                            SizedBox(height: 20,),
                                            ElevatedButton(
                                                onPressed: (){
                                                  final user = User(id: allusers[index].id,
                                                      nome: ctrupdatenome.text,
                                                      idade: int.parse(_ctrupdateidade.text));
                                                  updateUser(user);
                                                },
                                                child: Container(width: double.infinity, child: Center(child: Text('Atualizar')),))
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context, 'Cancelar');
                                          }, child: Text('Cancelar'))
                                    ],
                                  )
                              );
                            },
                            child: Icon(Icons.edit, size: 32, color: Colors.green,),
                          ),
                          TextButton(
                            onPressed: (){
                              showDialog(context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text('Confirma a exclusão do registro ${allusers[index].nome}?'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: (){
                                          deleteUser(allusers[index].id);
                                          Navigator.pop(context, 'Sim');
                                        },
                                        child: Text('Sim'),
                                      ),
                                      ElevatedButton(
                                        onPressed: (){
                                          Navigator.pop(context, 'Cancelar');
                                        },
                                        child: Text('Não'),
                                      ),
                                    ],
                                  ));
                            },
                            child: Icon(Icons.delete, size: 32, color: Colors.red,),
                          ),
                        ],
                      )
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
  BuscarUsuario(String nome) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
            .where('nome', isEqualTo: nome)
            .snapshots(),

        builder: (context, snp) {
          if (snp.hasError) {
            return Center(child: Text('Error'),);
          }
          if (snp.hasData) {
            var allusers = snp.data!.docs
                .map((doc) =>
                User.fromJson(
                    doc.data() as Map<String, dynamic>))
                .toList();

            //return ListUsers(users: allusers);
          } else {
            return Center(child: CircularProgressIndicator());
          }
          throw Exception('Some arbitrary error');
        },
      ),
    );
  }
}