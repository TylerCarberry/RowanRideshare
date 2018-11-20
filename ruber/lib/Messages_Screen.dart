import 'package:flutter/material.dart';

import 'AppDrawer.dart';

Container launchChatMessageContainer(context, text, _name) {
  return new Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: new CircleAvatar(child: new Text(_name[0])),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(_name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ],
    ),
  );
}

Scaffold launchMessagesScreen(context, _messages, _buildTextComposer) {
  return new Scaffold(
    appBar: new AppBar(title: new Text("Messages")),
    drawer: launchAppDrawer(context),
    body: new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ],
    ),
  );
}
