import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:star_wars_app/ui/People.dart';
import 'package:star_wars_app/ui/Films.dart';
import 'package:star_wars_app/ui/Planets.dart';
import 'package:star_wars_app/ui/Starship.dart';
import 'package:star_wars_app/ui/Species.dart';
import 'package:star_wars_app/ui/Vehicles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Image.network(
              'https://media1.tenor.com/images/1ebdeb99d0ba5d0439dc828bc1490189/tenor.gif?itemid=14405312'),
          centerTitle: true,
        ),
        backgroundColor: Colors.yellow,
        body: GridView.count(
          primary: false,
          padding: EdgeInsets.all(5),
          mainAxisSpacing: 5,
          crossAxisCount: 2,
          children: <Widget>[
            _createTable('images/people.jpg', 'Characters', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PeoplePage()));
            }),
            _createTable('images/films.jpg', 'Movies', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MoviesPage()));
            }),
            _createTable('images/species.jpg', 'Species', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SpeciesPage()));
            }),
            _createTable('images/starship.jpg', 'Starships', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StarshipPage()));
            }),
            _createTable('images/vehicles.jpg', 'Vehicles', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VehiclesPage()));
            }),
            _createTable('images/planets.jpg', 'Planets', () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PlanetsPage()));
            }),
          ],
        ));
  }
}

Widget _createTable(String imagem, String tipo, Function _tela) {
  return GestureDetector(
    child: Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagem,
                height: 200,
                width: 200,
                fit: BoxFit.fitHeight,
              ),
            )),
        Center(
          child: Text(
            tipo,
            style: GoogleFonts.righteous(
              textStyle: TextStyle(color: Colors.deepOrange),
              fontSize: 25,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
    onTap: _tela,
  );
}
