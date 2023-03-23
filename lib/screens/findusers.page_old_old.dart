import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.model.dart';
import '../repository/user.repo.dart';

class FindUsers_old_old extends StatefulWidget {
  const FindUsers_old_old({Key? key}) : super(key: key);
  //String idUsuario;

  @override
  State<FindUsers_old_old> createState() => _FindUsersState();

  //FindUsers(this.idUsuario)
}

class _FindUsersState extends State<FindUsers_old_old> {
  TextEditingController nomeTextController = new TextEditingController();

  void initState() {
    super.initState();

    // Start listening to changes
    nomeTextController.addListener(((){
      _updateNomeUsuario(); // <- Prevent this function from run multiple times
    }));
  }


  _updateNomeUsuario(){
    print("Atualiza lista usuários");
    FirebaseFirestore.instance.collection('users').doc().set( {"nome" : nomeTextController.text}, );
  }

  @override
  Widget build(BuildContext context) {
    List<User> allusers =[];
    final ctrupdatenome = TextEditingController();
    final _ctrupdateidade = TextEditingController();


    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').orderBy('nome')
        //.where('nome', isEqualTo: ctrupdatenome.text)
            .snapshots(),
        builder: (context, snp) {
          if (!snp.hasError) {
            return Center(child: Text('Error Teste'),);
          }
          if (!snp.hasData) {

            nomeTextController.text = snp.data! as String;

            allusers = snp.data!.docs
                .map((doc) =>
                User.fromJson(doc.data() as Map<String, dynamic>)).toList();
            return Scaffold(
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: TextField(
                      controller: nomeTextController,
                      onChanged: (text) {
                        print("text $text");

                        /*StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('users')
                              .where('nome', isEqualTo: nomeTextController.text)
                              .snapshots(),
                          builder: (context, snp) {

                            allusers =snp.data!.docs
                                .map((doc) =>
                                User.fromJson(doc.data() as Map<String, dynamic>)).toList();
                            return FindUsers_old();
                          },);*/

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
            //return SearchUsers(users: allusers);

          } else {

            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
