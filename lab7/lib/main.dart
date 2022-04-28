import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (BuildContext context) => const MyHomePage(title: 'Новости КубГАУ'),},
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), backgroundColor: Colors.green),
      body: FutureBuilder<List<Photo>>(future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ошибка снапшота подождите или пререзагрузите', style: TextStyle(fontSize: 40, color: Colors.redAccent), textAlign: TextAlign.center,),);
          } else if (snapshot.hasData) {return Info(photos: snapshot.data!);
          } else {return const Center(child: CircularProgressIndicator(),);}
        },
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return SizedBox(child: Card(child: Column( crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[
          Image.network(photos[index].PREVIEW_PICTURE_SRC),
          Text(photos[index].ACTIVE_FROM, style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17, color: Colors.black45),),
          Text(photos[index].TITLE, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 22),),
          Text(photos[index].PREVIEW_TEXT, style: TextStyle(fontSize: 20,  color: Colors.black45))
        ],),
          margin: EdgeInsets.all(15),
        ));
      },
    );
  }
}

class Photo {
  final String ID;
  final String ACTIVE_FROM;
  final String TITLE;
  final String PREVIEW_PICTURE_SRC;
  final String PREVIEW_TEXT;
  final String DETAIL_PAGE_URL;
  final String DETAIL_TEXT;

  const Photo({
    required this.ID,
    required this.ACTIVE_FROM,
    required this.TITLE,
    required this.PREVIEW_PICTURE_SRC,
    required this.PREVIEW_TEXT,
    required this.DETAIL_PAGE_URL,
    required this.DETAIL_TEXT,
  });
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        ID: json['ID'] as String,
        ACTIVE_FROM: json['ACTIVE_FROM'].toString(),
        TITLE: json['TITLE'] as String,
        PREVIEW_PICTURE_SRC: (json['PREVIEW_PICTURE_SRC'] as String).replaceRange(8, 8, 'old.'),
        PREVIEW_TEXT: json['PREVIEW_TEXT'] as String,
        DETAIL_PAGE_URL: json['DETAIL_PAGE_URL'] as String,
        DETAIL_TEXT: json['DETAIL_TEXT'] as String
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  HttpOverrides.global = MyHttpOverrides();
  final response = await
  client.get(Uri.parse('https://old.kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
  return compute(parsePhotos, response.body);
}

List<Photo> parsePhotos(String responseBody) {
  responseBody = Bidi.stripHtmlIfNeeded(responseBody);
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}