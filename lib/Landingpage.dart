
import 'package:flutter/material.dart';
import 'package:newapp/Properties.dart';

import 'customerprofile.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _Landingpage();
}

class _Landingpage extends State<Landingpage> {

  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    CustomerProfilePage(),
    PropertiesPage(),
    ComplaintsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text(
          "CUSTOMER SERVICE",
          style: TextStyle(color: Colors.black87),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.grey, // Set the primary color to gray
                Colors.white, // Set the secondary color to white
              ],
              begin: Alignment.center,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.black26,
                  ],
                ),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/images/build1.png"),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "CUSTOMER SERVICE",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Customer Profile'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Property Details'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Complaints and Escalations'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}





class ComplaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Complaints and Escalations',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

