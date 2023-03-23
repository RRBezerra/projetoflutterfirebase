import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usuario_firebase/model/user.model.dart';
import 'package:usuario_firebase/screens/allusers.page.dart';
import 'package:usuario_firebase/screens/findusers.page.dart';
import 'package:usuario_firebase/screens/widgets/user.find_old.dart';
import 'findusers.page_old_old.dart';
import 'user.add.dart';
import 'package:usuario_firebase/screens/user.add.dart';
import 'package:usuario_firebase/screens/Conversas.dart';

class ControlePage extends StatelessWidget {
  const ControlePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    final statuses = [
      Permission.storage,
    ].request();
    //SystemChrome.setEnabledSystemUIMode([]);
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Conversas(),
    //FindUsers(),
    Text(
      'Index 1: Vídeos',
      style: optionStyle,
    ),
    Text(
      'Index 2: Fotos',
      style: optionStyle,
    ),
    Text(
      'Index 3: Shorts',
      style: optionStyle,
    ),
    Text(
      'Index 4: Blog',
      style: optionStyle,
    ),
    Text(
      'Index 5: Formação',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 1:
        showModal(context);
        break;
    }
    setState(
          () {
        _selectedIndex = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          /*appBar: AppBar(
            backgroundColor: Color((0xFF000040)),
            title: Text('AIOPY'),
            bottom: TabBar(
              tabs: const [
                Tab(icon: Icon(Icons.supervised_user_circle_sharp, size: 28,), child: Text('Feed', style: TextStyle(fontSize: 10.5) ,),),
                Tab(icon: Icon(Icons.edit_attributes, size: 28,), child: Text('Conversas', style: TextStyle(fontSize: 10.5) ,),),
                Tab(icon: Icon(Icons.search, size: 28,), child: Text('Vídeos', style: TextStyle(fontSize: 10.5) ,),),
                Tab(icon: Icon(Icons.history, size: 28,), child: Text('Fotos', style: TextStyle(fontSize: 10.5) ,),),
                Tab(icon: Icon(Icons.history, size: 28,), child: Text('Shorts', style: TextStyle(fontSize: 10.5) ,),),
              ],
            ),
          ),
          body: TabBarView(
            children: const [
              AddUserPage(),
              AllUsers(),
              FindUsers(),
              Center(child: Text('XXX'),),
              Center(child: Text('Página 4'),),
            ],
          ),*/

         body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.mark_unread_chat_alt_outlined),
                label: 'Conversas',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Vídeos',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo),
                label: 'Fotos',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_movies),
                label: 'Shorts',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_comment),
                label: 'Blog',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Educação',
                backgroundColor: Colors.black,
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
            iconSize: 24.0,
            showUnselectedLabels: true,
          ),

        ));
  }
  void showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
