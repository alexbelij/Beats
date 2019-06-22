
import 'package:beats/screens/HomeScreen.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'Player.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {

  SongsModel model;
  TextEditingController editingController;
  

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    model.fetchSongs();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width*0.05 , right: width*0.05 , top: height*0.06),
            child: TextField(
              controller: editingController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(LineIcons.search),
                border: OutlineInputBorder()
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, pos) {
                return ListTile(
                  onTap: () {
                    model.currentSong = pos;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PlayBackPage();
                    }));
                  },
                  leading: CircleAvatar(child: getImage(pos)),
                  title: Text(model.songs[pos].title),
                );
              },
              itemCount: model.songs.length,
            ),
          ),
        ],
      ),
    );
  }

  

  getImage(pos) {
    if (model.songs[pos].albumArt != null) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child:
              Image.file(File.fromUri(Uri.parse(model.songs[pos].albumArt))));
    } else {
      return Icon(Icons.music_note);
    }
  }
}
