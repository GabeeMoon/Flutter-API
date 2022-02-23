import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste"),
      ),
      body: FutureBuilder<dynamic>(
        future: pegarlink(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  var Link = snapshot.data![index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(Link.data![index]['id'].toString()),
                    ),
                    title: Text(snapshot.data!["name"]),
                    subtitle: Text(Link["website"]),
                  );
                });
          }else if(snapshot.hasError){
            return Center( child: Text('${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator.adaptive(),);
        },
      ),
    );
  }

  pegarlink() async {
    var url = Uri.parse('https://newsapi.org/v2/everything?q=keyword&apiKey=58939f37855e49138ab31a27a8fb775f');
    var resposta = await http.get(url);
    if(resposta.statusCode == 200) {
      return jsonDecode(resposta.body);
    }else{
      throw Exception('Não foi possivel carregar');
    }
  }

}
