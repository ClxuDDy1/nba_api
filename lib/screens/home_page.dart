import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbaapp/models/team.dart';

class HomePage extends StatelessWidget {
  List<Team> teams = [];
  Future getTeams() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsondata = jsonDecode(response.body);
    for (var eachTime in jsondata['data']) {
      final team =
          Team(abbreviation: eachTime['abbreviation'], city: eachTime['city']);
      teams.add(team);
    }
    //   print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    // getTeams();
    return Scaffold(
        body: FutureBuilder(
      future: getTeams(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text(teams[index].abbreviation),
                      subtitle: Text(teams[index].city),
                    ),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
