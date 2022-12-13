import '../models/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News{
  List<ArticleModel> news=[];
  Future<void> getNews()async{
    String url="https://newsapi.org/v2/top-headlines?country=us&apiKey=f69437fc6d714b7c8c11dab0e21092c0";
    var response=await http.get(Uri.parse(url));

    var jsondata=jsonDecode(response.body);

    if(jsondata['status'] == "ok"){

      jsondata['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
                ArticleModel articleModel=ArticleModel(

                    author:element["author"],
                    title:element["title"],
                    description:element["description"],
                    url:element["url"],
                    urlToImage:element["urlToImage"],
                    content:element["content"]

                );
                news.add(articleModel);
        }
      });
    }
  }
}


class CategoryNewsClass{
  List<ArticleModel> news=[];
  Future<void> getNews(String category)async{
    String url="https://newsapi.org/v2/top-headlines?category=$category&country=us&category=business&apiKey=f69437fc6d714b7c8c11dab0e21092c0";
    var response=await http.get(Uri.parse(url));

    var jsondata=jsonDecode(response.body);

    if(jsondata['status'] == "ok"){

      jsondata['articles'].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel=ArticleModel(

              author:element["author"],
              title:element["title"],
              description:element["description"],
              url:element["url"],
              urlToImage:element["urlToImage"],
              content:element["content"]

          );
          news.add(articleModel);
        }
      });
    }
  }
}