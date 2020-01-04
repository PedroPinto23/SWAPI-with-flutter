import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class PeoplePage extends StatefulWidget {
  @override
  _PeoplePageState createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  Future<Map> _getPeople() async {
    http.Response res = await http.get('https://swapi.co/api/people');
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('characters'),
          centerTitle: true,
        ),
        backgroundColor: Colors.yellow,
        body: FutureBuilder(
          future: _getPeople(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: SpinKitCircle(
                    color: Colors.black,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar os dados..."),
                  );
                } else {
                  return ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data['results'][index]['name'],
                          style: TextStyle(fontSize: 27),
                        ),
                      );
                    },
                  );
                }
            }
          },
        ));
  }
}
