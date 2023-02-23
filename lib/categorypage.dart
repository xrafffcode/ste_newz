import 'package:flutter/material.dart';
import 'package:ste_newz/articlepage.dart';
import 'package:ste_newz/core.dart';
import 'package:ste_newz/helper/newsdata.dart';

class CategoryFragment extends StatefulWidget {
  String category;
  CategoryFragment({required this.category});
  @override
  _CategoryFragmentState createState() => _CategoryFragmentState();
}

class _CategoryFragmentState extends State<CategoryFragment> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.datatobesavedin;
    setState(() {
      // important method otherwise you would have to perform hot relod always
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .center, // this is to bring the row text in center
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                widget.category.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      // category widgets
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true, // add this otherwise an error
                  itemBuilder: (context, index) {
                    return NewsTemplate(
                      urlToImage: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                      url: '',
                    );
                  },
                ),
              ),
            ),
    );
  }
}

class NewsTemplate extends StatelessWidget {
  String title, description, url, urlToImage;
  NewsTemplate(
      {required this.title,
      required this.description,
      required this.urlToImage,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlePage(
                article: ArticleModel(
                    title: title,
                    description: description,
                    urlToImage: urlToImage,
                    url: url),
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(urlToImage),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
