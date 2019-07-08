import 'package:beats/models/SongHelper.dart';
import 'package:beats/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:beats/models/SongsModel.dart';
import 'package:pref_dessert/pref_dessert_internal.dart';
import '../custom_icons.dart';
import 'package:provider/provider.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'Player.dart';

class Library extends StatelessWidget {
  TextEditingController editingController;
  SongsModel model;

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.05, right: width * 0.05, top: height * 0.06),
            child: TextField(
                onChanged: (value) {
                   model.filterResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                    hintStyle: TextStyle(),
                    hintText: "Search",
                    prefixIcon: Icon(CustomIcons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)))),
          ),
          getLoading(model)
        ],
      ),
    );
  }

  getLoading(model) {
    if (model.songs.length == 0) {
      return Expanded(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: model.songs.length,
          itemBuilder: (context, pos) {
            return ListTile(
              onTap: () {
                model.player.stop();
                model.currentSong = model.songs[pos];
                model.filterResults(""); //Reset the list. So we can change to next song.
                model.play();
                

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PlayBackPage();
                }));
              },
              leading: CircleAvatar(child: getImage(model, pos)),
              title: Text(
                model.songs[pos].title,
                style: Theme.of(context).textTheme.display2,
              ),
            );
          },
        ),
      );
    }
  }

  getImage(model, pos) {
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
