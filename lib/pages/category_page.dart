import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/article_page.dart';

class CategoryPage extends StatefulWidget {
  final String category;


  CategoryPage({required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<ArticleModel>  articles=<ArticleModel>[];
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNewsClass newsClass=CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.category.toUpperCase(),style: TextStyle(color: Colors.black),),

          ],
        ),
        actions: [
          Opacity(opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),)
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body:_loading ? Center(
        child: Container(

          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    // controller: _controller,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: articles.length,
                    itemBuilder:(context,index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class BlogTile extends StatelessWidget {
  final String? imageUrl,title,desc,url;
  BlogTile({ this.imageUrl,this.title,this.desc,this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=> ArticlePage(blogUrl:url??"")));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imageUrl??"")),
            Text(title??"",style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold
            ),),
            Text(desc??"",style: TextStyle(
              color: Colors.grey,
            ),)
          ],
        ),
      ),
    );
  }
}