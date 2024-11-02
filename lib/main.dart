import 'package:blue_sky_books/book.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// root
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI童話',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'AI童話'),
    );
  }
}

// 実質のトップページ
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> langs = [
    {"lang": "日本語", "value": "ja-JA", "thumbnail": "Japan.png"},
    {"lang": "English", "value": "en-EN", "thumbnail": "England.png"},
    {"lang": "Indonesia", "value": "id-ID", "thumbnail": "Indonesia.png"},
    {"lang": "中文", "value": "zh-CN", "thumbnail": "China.png"},
    // {"lang": "සිංහල", "value": "si-SI", "thumbnail": "Srilanka.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black45,
            BlendMode.darken,
          ),
          image: AssetImage('assets/common/blue_sky03.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          iconTheme: const IconThemeData(color: Colors.white70),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: GridView.extent(
            maxCrossAxisExtent: 170,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: [
              for (var lang in langs)
                LangSelect(
                    id: lang["value"],
                    title: lang["lang"],
                    thumbnail: lang["thumbnail"])
            ],
          ),
        ),
      ),
    );
  }
}

// 言語選択
class LangSelect extends StatelessWidget {
  const LangSelect({
    super.key,
    required this.id,
    required this.title,
    required this.thumbnail,
  });

  final String id;
  final String title;
  final String thumbnail;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/common/$thumbnail'),
              fit: BoxFit.cover,
            ),
          ),
          child: Text(
            title,
            style:
                const TextStyle(fontSize: 18, backgroundColor: Colors.white70),
          )),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Book(lang: id, title: title);
        }));
      },
    );
  }
}
