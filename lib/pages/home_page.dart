import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/pages/article_page.dart';
import 'package:news_app/pages/category_page.dart';

class HomePgae extends StatefulWidget {
  const HomePgae({Key? key}) : super(key: key);

  @override
  State<HomePgae> createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> {
  final _controller=ScrollController();
  List<CategoryModel> categories= <CategoryModel>[];
  List<ArticleModel>  articles=<ArticleModel>[];

  bool _loading=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }

   getNews() async{
    News newsClass=News();
    await newsClass.getNews();
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter ",
            style: TextStyle(
              color: Colors.black
            ),),
            Text("News",
            style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        
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

                  //categories list
                  Container(
                    height: 70,
                    child: ListView.builder(
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:(context ,index){
                          return CategoryTile(
                            imageUrl:categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),

                  //blog list display
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      controller: _controller,
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


class CategoryTile extends StatelessWidget {
  final imageUrl,categoryName;


  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>CategoryPage(
                category: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
           children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(8),
                 child: CachedNetworkImage(
                   imageUrl:imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
             Container(
               alignment: Alignment.center,
               width: 120,
               height: 60,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(8),
                 color: Colors.black26,
               ),

               child: Text(categoryName,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
             )

           ],
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

