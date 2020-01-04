import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclesPageState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  Future<Map> _getVehicles() async {
    http.Response res = await http.get('https://swapi.co/api/vehicles/');
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Vehicles'),
        centerTitle: true,
      ),
      backgroundColor: Colors.yellow,
      body: FutureBuilder(
        future: _getVehicles(),
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
