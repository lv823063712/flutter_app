import 'package:english_words/english_words.dart';
import 'package:english_words/english_words.dart' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomWordsState extends State<RandomWords> {
  //变量前面  加下划线  _  代表私有化  类似java 中的private
  final _suggestions = <WordPair>[]; //用来存储的列表
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>(); //用来存储收藏的键值对

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true, //这个属性用来让Title居中显示
        title: new Text("呦呵,有点意思"), //这里用来设置我们的title
        actions: <Widget>[
          //添加在顶部右侧的导航栏
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(), //这里是我们title下方的展示内容
    );
  }

  //这个方法是添加一个ListView控件
  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(0.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider(); //在一个item之前添加一个一像素的线
          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          print("zzzzzzzzzzzzz   ${index}"); //这里用来打印log 日志,应该在info一级
          if (index >= _suggestions.length) {
            //生成
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  //这个方法用来给listView中的每一个item添加数据
  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return new ListTile(
      title: new Text(
        //这里用来给每一个lIstView的item添加一个头部内容
        suggestion.asPascalCase, //此处进行数据的添加 Demo中使用的是一个添加第三方插件用来进行数据的添加
        style: _biggerFont, //设置文字大小
      ),
      trailing: new Icon(
        //添加红心
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        //这里的图标是Flutter本身自带的
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
//        在Flutter的响应式风格的框架中，调用setState() 会为State对象触发build()方法，从而导致对UI的更新
        setState(() {
          if (alreadySaved) {
            _saved.remove(suggestion); //删除
          } else {
            _saved.add(suggestion); //添加
          }
        });
      },
    );
  }

//  RandomWordsState类添加一个 _pushSaved() 方法.
  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(
      // ignore: missing_return
      builder: (context) {
        final tiles = _saved.map((suggestion) {
          return new ListTile(
            title: new Text(
              suggestion.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = ListTile.divideTiles(
          tiles: tiles,
          context: context,
        ).toList();

        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Saved Suggestions"),
          ),
          body: new ListView(children: divided),
        );
      },
    ));
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomWordsState();
  }
}
