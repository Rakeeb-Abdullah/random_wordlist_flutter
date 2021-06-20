import 'package:flutter/material.dart ';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Random Word Generator')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list_rounded),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList(),
    );
  }

  final _randomWordPairs = <WordPair>[];
  final _saveWordPairs = Set<WordPair>();

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saveWordPairs.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: TextStyle(fontSize: 18.0),
          ),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(title: Text('Saved Word')),
        body: ListView(children: divided),
      );
    }));
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, item) {
          if (item.isOdd) return Divider();

          final index = item ~/ 2;

          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saveWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_outline,
        color: alreadySaved ? Colors.teal : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saveWordPairs.remove(pair);
          } else {
            _saveWordPairs.add(pair);
          }
        });
        // print(_saveWordPairs);
      },
      hoverColor: Colors.teal[200],
    );
  }
}
