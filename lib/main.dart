import 'package:flutter/material.dart';
import 'package:news/pages/article.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'news app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: NewsListPage.routeName,
      routes: {
        NewsListPage.routeName: (context) => const NewsListPage(),

      }
    );
  }
}

class NewsListPage extends StatelessWidget {

  static const routeName = '/article_list';

  const NewsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('news app'),
      ),

      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/articles.json'), 
        builder: ((context, snapshot) {
          final List<Article> articles = parseArticles(snapshot.data);

          return ListView.builder(
            itemBuilder: (context, index){
              return _buildArticleItem(context, articles[index]);
            },
            itemCount: articles.length,);
        }
        )),
    );
  }
}

Widget _buildArticleItem(BuildContext context, Article article){
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical:  8 ),
    leading: Image.network(article.urlToImage,
    
    width: 100,
  
    // errorBuilder: (ctx, error, _) => const Center(child: Icon(Icons.error)),
    ),
    title: Text(article.title),
    subtitle: Text(article.author),
  );
}
