import 'package:flutter/material.dart';
import 'package:portal_berita/model/berita_item.dart';

class DetailBeritaPage extends StatefulWidget {
  final Article article;

  const DetailBeritaPage({Key key, this.article}) : super(key: key);

  @override
  _DetailBeritaPageState createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail News'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          (widget.article.urlToImage == null)
                              ? 'https://img.beritasatu.com/cache/beritasatu/910x580-2/72mkT1XmT1w.jpg'
                              : widget.article.urlToImage,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.article.content),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(widget.article.publishedAt),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
