import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  Future<Map> _getMovies() async {
    http.Response res = await http.get('https://swapi.co/api/films/');
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Movies'),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: FutureBuilder(
        future: _getMovies(),
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
                          snapshot.data['results'][index]['title'],
                          style: TextStyle(fontSize: 27),
                        ),
                      );
                    });
              }
          }
        },
      ),
    );
  }
}
