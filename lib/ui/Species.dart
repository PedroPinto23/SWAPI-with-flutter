import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class SpeciesPage extends StatefulWidget {
  @override
  _SpeciesPageState createState() => _SpeciesPageState();
}

class _SpeciesPageState extends State<SpeciesPage> {
  Future<Map> _getSpecies() async {
    http.Response res = await http.get('https://swapi.co/api/species/');
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Species'),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: FutureBuilder(
        future: _getSpecies(),
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
      ),
    );
  }
}
