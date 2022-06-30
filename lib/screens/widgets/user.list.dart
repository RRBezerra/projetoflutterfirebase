import 'package:flutter/material.dart';
import 'package:usuario_firebase/repository/user.repo.dart';
import 'package:usuario_firebase/screens/allusers.page.dart';
import '../../model/user.model.dart';

class ListUsers extends StatefulWidget {
  List<User> users;
  ListUsers({required this.users});

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    final allusers = widget.users;
    final _ctrupdatenome = TextEditingController();
    final _ctrupdateidade = TextEditingController();

    return ListView.builder(
        itemCount: allusers.length,
        itemBuilder: (context, index){
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
                          _ctrupdatenome.text = allusers[index].nome;
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
                                          controller: _ctrupdatenome,
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
                                                  nome: _ctrupdatenome.text,
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
        }
    );
  }
}
