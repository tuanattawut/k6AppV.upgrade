import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:k6_app/utility/my_constant.dart';

class SearchBar extends StatefulWidget {
  @override
  State createState() {
    return _SearchBar();
  }
}

class _SearchBar extends State {
  bool? searching, error;
  var data;
  String? query;
  String dataurl = "${MyConstant().domain}/projectk6/search_suggestion.php";
  // do not use http://localhost/ , Android emulator do not recognize localhost
  // insted use your local ip address or your live URL
  // hit "ipconfig" on Windows or "ip a" on Linux to get IP Address

  @override
  void initState() {
    searching = false;
    error = false;
    query = "";
    super.initState();
  }

  void getSuggestion() async {
    //get suggestion function
    var res = await http
        .post(Uri.parse(dataurl + "?query=" + Uri.encodeComponent(query!)));
    //in query there might be unwant character so, we encode the query to url
    if (res.statusCode == 200) {
      setState(() {
        data = json.decode(res.body);
        //update data value and UI
      });
    } else {
      //there is error
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: searching!
              ? IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      searching = false;
                      //set not searching on back button press
                    });
                  },
                )
              : Icon(Icons.play_arrow),
          //if searching is true then show arrow back else play arrow
          title: searching! ? searchField() : Text("My Frieds"),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    searching = true;
                    print('5555555');
                  });
                }), // search icon button

            //add more icons here
          ],
          backgroundColor: searching! ? Colors.orange : Colors.deepOrange,
          //if searching set background to orange, else set to deep orange
        ),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: data == null
                    ? Container(
                        padding: EdgeInsets.all(20),
                        child: searching!
                            ? Text("Please wait")
                            : Text("Search any peoples")
                        //if is searching then show "Please wait"
                        //else show search peopels text
                        )
                    : Container(
                        child: searching!
                            ? showSearchSuggestions()
                            : Text("Find any Peoples"),
                      )
                // if data is null or not retrived then
                // show message, else show suggestion
                )));
  }

  Widget showSearchSuggestions() {
    List suggestionlist = List.from(data["data"].map((i) {
      return SearchSuggestion.fromJSON(i);
    }));
    //serilizing json data inside model list.
    return Column(
      children: suggestionlist.map((suggestion) {
        return InkResponse(
            onTap: () {
              //when tapped on suggestion
              print(suggestion.id); //pint student id
            },
            child: SizedBox(
                width: double.infinity, //make 100% width
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      suggestion.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                )));
      }).toList(),
    );
  }

  Widget searchField() {
    //search input field
    return Container(
        child: TextField(
      autofocus: true,
      style: TextStyle(color: Colors.white, fontSize: 18),
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        hintText: "ค้นหา",
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), //under line border, set OutlineInputBorder() for all side border
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ), // focused border color
      ), //decoration for search input field
      onChanged: (value) {
        query = value; //update the value of query
        getSuggestion(); //start to get suggestion
        print(query);
      },
    ));
  }
}

//serarch suggestion data model to serialize JSON data
class SearchSuggestion {
  String? id, name;
  SearchSuggestion({this.id, this.name});

  factory SearchSuggestion.fromJSON(Map<String, dynamic> json) {
    return SearchSuggestion(
      id: json["id_product"],
      name: json["nameproduct"],
    );
  }
}
