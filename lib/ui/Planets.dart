import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class PlanetsPage extends StatefulWidget {
  @override
  _PlanetsPageState createState() => _PlanetsPageState();
}

class _PlanetsPageState extends State<PlanetsPage> {
  Future<Map> _getPlanets() async {
    http.Response res = await http.get('https://swapi.co/api/planets/');
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planets'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.yellow,
      body: FutureBuilder(
        future: _getPlanets(),
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
                  child: Text('Erro ao carregar os dados...'),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data['results'].length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            snapshot.data['results'][index]['name'],
                            style: TextStyle(fontSize: 27),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
