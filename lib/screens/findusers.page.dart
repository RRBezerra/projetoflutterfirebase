import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:usuario_firebase/screens/allusers.page.dart';
import 'package:usuario_firebase/screens/widgets/user.find.dart';

class FindUsers extends StatelessWidget {
  const FindUsers({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: TypeAheadField<User?>(
          hideSuggestionsOnKeyboardHide: false,
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Procurar Usuário',
            ),
          ),
          suggestionsCallback: UserApi.getUserSuggestions,
          itemBuilder: (context, User? suggestion) {
            final user = suggestion!;

            return ListTile(
              title: Text(user.indicador),
            );
          },
          noItemsFoundBuilder: (context) => Container(
            height: 100,
            child: Center(
              child: Text(
                'No Users Found.',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          onSuggestionSelected: (User? suggestion) {
            final user = suggestion!;

            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Selected user: ${user.indicador}'),
              ));
          },
        ),
      ),
    ),
  );
}