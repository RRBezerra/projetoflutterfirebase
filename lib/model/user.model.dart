class User{
  String id;
  String nome;
  int idade;

  User({this.id='', required this.nome, required this.idade});
  //----------------------------------------------------------------------------
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'nome': nome,
      'idade': idade,
    };
  }
  //----------------------------------------------------------------------------

factory User.fromJson(Map<String, dynamic> json){
    return User(id: json['id'], nome: json['nome'], idade: json['idade']);
}

}