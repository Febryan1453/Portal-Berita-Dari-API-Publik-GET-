import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portal_berita/detail_berita.dart';
import 'package:http/http.dart' as http;
import 'package:portal_berita/model/berita_item.dart';

class PortalBeritaApp extends StatefulWidget {
  @override
  _PortalBeritaAppState createState() => _PortalBeritaAppState();
}

class _PortalBeritaAppState extends State<PortalBeritaApp> {
  Future<List<Article>> getData() async {
    List<Article> list;
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2021-05-24&sortBy=publishedAt&apiKey=4e74bb32689b4f12b2e26cee1ca02dc0';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var result = data['articles'] as List;
      print(result);
      list = result.map<Article>((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
    print("List Size ${list.length}");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News App'),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return snapshot.data != null
                ? listViewWidget(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ));
  }

  ListView listViewWidget(List<Article> article) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DetailBeritaPage(
                    article: article[index],
                  );
                }));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          (article[index].urlToImage == null)
                              ? 'https://img.beritasatu.com/cache/beritasatu/910x580-2/72mkT1XmT1w.jpg'
                              : article[index].urlToImage,
                          fit: BoxFit.fill,
                          width: 300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          article[index].title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              article[index].author,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, right: 10),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              article[index].publishedAt,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[400]),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
