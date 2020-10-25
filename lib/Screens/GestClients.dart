import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stocknsell/Services/database.dart';

class Clients extends StatefulWidget {
  @override
  _ClientsState createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {

  final _formKey = GlobalKey<FormState>();
  String nom;
  int phone;
  String email;
  String Secteur;
  String URL;

  @override
  Widget build(BuildContext context) {

    void showDialog() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 500),
        context: context,
        pageBuilder: (_, __, ___) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Ajouter un nouveau client"),
            ),
                body : Container(
                    margin: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 10),
                    alignment: Alignment.center,
                    child : Card(
                      child : Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            new ListTile(
                              leading: const Icon(Icons.person,color: Colors.blue),
                              title: new TextFormField(
                                onChanged: (value){
                                  nom = value;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                            decoration: new InputDecoration(
                              labelText: "Name",
                            ),
                          ),
                        ),
                          new ListTile(
                           leading: const Icon(Icons.phone,color: Colors.blue),
                            title: new TextFormField(
                              onChanged: (value){
                                phone = int.parse(value);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            decoration: new InputDecoration(
                              labelText: "Phone",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.location_on,color: Colors.blue),
                          title: DropdownButtonFormField<String>(
                            value: Secteur,
                            style: TextStyle(color: Colors.blue),
                            onChanged: (String newValue) {
                              setState(() {
                                Secteur = newValue;
                              });
                            },
                            items: <String>['Alger Centre', 'Bab el oued', 'Bab ezzouar', 'Ain naadja','Dar El Beida','El Herrach']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.map,color: Colors.blue),
                          title: new TextFormField(
                            onChanged: (value){
                              URL = value;
                            },
                            decoration: new InputDecoration(
                              labelText: 'Url "Google maps"',
                            ),
                          ),
                        ),
                            new ListTile(
                              leading: const Icon(Icons.email,color: Colors.blue),
                              title: new TextFormField(
                                onChanged: (value){
                                  email = value;
                                },
                                decoration: new InputDecoration(
                                  labelText: 'E-Mail',
                                ),
                              ),
                            ),
                        const SizedBox(height: 20),
                        RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DatabaseService().createRecord(nom, email, phone, URL, Secteur);
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Creer Client'),
                        ),
                    ],
                  ),
                      ),
                  elevation: 5.0,
                  color: Colors.white70,
                ),
                ),
          );

        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Drawer Demo')),
        body : _myListView(context),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog();
            },
            elevation: 4,
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,

          ),
        );
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 10),

        child :Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                title: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.blueGrey,
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search,color: Colors.white,),
                          tooltip: 'Rechercher',
                        ),
                        hintText: 'Rechercher',
                    ),
                  style: TextStyle(color: Colors.white,fontSize: 20),

                  ),
              ),
            ],
          ),
        ),
      Container(
        margin: EdgeInsets.only(left: 10),

        child :Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilterChip(
              avatar: CircleAvatar(
                child: Icon(Icons.person),
              ),
              label: Text('Nom'),
              backgroundColor: Colors.green,
            ),
            const SizedBox(width: 14,),
            FilterChip(
              avatar: CircleAvatar(
                child: Icon(Icons.phone),
              ),
              backgroundColor: Colors.green,
              label: Text('Phone')

            ),
          ],
        ),
      ),

      Container(
        margin: EdgeInsets.only(left: 10),

        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                title: Text('Adman Mohamed Amine'),
                subtitle: Text('Ain naadja'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/baraka.jpg'),
                ),
                title: Text('Boutouili Djillali'),
                subtitle: Text('Rouiba'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                title: Text('Benyoucef Bourse'),
                subtitle: Text('Reghaia'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/baraka.jpg'),
                ),
                title: Text('Matex'),
                subtitle: Text('Ain naadja'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/facebook.png'),
                ),
                title: Text('Matex'),
                subtitle: Text('Ain naadja'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/facebook.png'),
                ),
                title: Text('Matex'),
                subtitle: Text('Ain naadja'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
              leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/facebook.png'),
              ),
                title: Text('Mouzaoui Mohammed'),
                subtitle: Text('Benaknoun'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
      Container(
        margin: EdgeInsets.only(left: 10),
        child : Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/facebook.png'),
                ),
                title: Text('Matex'),
                subtitle: Text('Ain naadja'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.orange,
                    onPressed: () {
                      _launchUrl("https://www.google.com");
                    },
                    child: const Text('Map'),
                  ),
                  const SizedBox(width: 8),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Details'),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

            ],
          ),
          elevation: 3,
          color: Colors.white70,
        ),
      ),
    ],
  );
}

void _launchUrl(String Url ) async{
  if(await canLaunch(Url)){
    await launch(Url);
  }
  else{
    throw 'Could not open Url';
  }
}
