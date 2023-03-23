import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  final String indicador;

  const User({
    required this.indicador,
  });

  static User fromJson(Map<String, dynamic> json) => User(
    indicador: json['indicador'],
  );
}

class UserApi {
  static Future<List<User>> getUserSuggestions(String query) async {
    List<User> allusers =[];
    final url = Uri.parse('https://servicodados.ibge.gov.br/api/v1/paises/BR%7CAR/indicadores');
    final response = await http.get(url);

    /*return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users')
            .orderBy('nome')
            .snapshots(),
        builder: (context, snp) {
          if (snp.hasError) {
            return Center(child: Text('Error'),);
          }
          if (snp.hasData) {
            allusers = snp.data!.docs
                .map((doc) =>
                User.fromJson(doc.data() as Map<String, dynamic>)).toList();

            //return ListUsers(users: allusers);

          } else {
            return Center(child: CircularProgressIndicator());
          }
          throw Exception('XXX');
        },
      ),
    );*/

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.indicador.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}