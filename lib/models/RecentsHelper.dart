import 'package:flute_music_player/flute_music_player.dart';
import 'package:pref_dessert/pref_dessert.dart';
class RecentsHelper extends DesSer<Song>{
  
  @override
  Song deserialize(String s) {
    // Its a simple spell( two commas ) but quite unbreakable
    var split = s.split(",,");
    var art = split[7] == "" ? null : split[7];
    return Song(int.parse(split[0]), split[1], split[2], split[3], int.parse(split[4]), int.parse(split[5]), split[6], art);}

  @override
  String get key => "recents";

  @override
  String serialize(Song t) {
    var art = t.albumArt ?? "";
    // All Songs are in two comma club
    return "${t.id},,${t.artist},,${t.title},,${t.album},,${t.albumId},,${t.duration},,${t.uri},,$art";
  }

}