import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main(){
  runApp(MyApp());
}


// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       title: "Assignment: Data Fetching and Displaying",
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: PostList(),
//
//     );
//   }
// }


class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  ThemeMode _themeMode= ThemeMode.light;

  void toggleTheme(){
    setState(() {
      _themeMode= _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Post Fetching and Display",
      theme:ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:_themeMode,
      home: PostList(toggleTheme: toggleTheme),
    );
  }
}


class PostList extends StatefulWidget{
  final VoidCallback toggleTheme;
  PostList({required this.toggleTheme});

  @override
  _PostListState createState() => _PostListState();

}

class _PostListState extends State<PostList>{
  List<Map<String, dynamic>> posts=[];
  List<Map<String, dynamic>> filteredPosts=[];
  bool isLoading= true;
  String? errorMessage;
  TextEditingController searchController= TextEditingController();

  @override
  void initState(){
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async{
    setState(() {
      isLoading= true;
      errorMessage= null;
    });
    try{
      final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if(response.statusCode==200){
        List<dynamic> data= json.decode(response.body);
        setState(() {
          posts=List<Map<String, dynamic>>.from(data);
          filteredPosts=posts;
          isLoading=false;
        });
      }else{
        throw Exception("Failed to load posts. Status Code: ${response.statusCode}");
      }
    }catch(e){
      setState(() {
        errorMessage= e.toString();
        isLoading=false;
      });
    }

  }

  void filterPosts(String query){
    setState(() {
      filteredPosts=posts
        .where((post)=> post['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: const Text("Posts List"),
        actions: [
          IconButton(onPressed: widget.toggleTheme, icon: Icon(Icons.brightness_6))
        ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Posts using Title...',
                  prefixIcon: Icon(Icons.search),
                  border:OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))
                ),
                onChanged: filterPosts,
              ),
            ),
            Expanded(
                child: isLoading
                    ? Center(child: CircularProgressIndicator())
                    : errorMessage !=null
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error:$errorMessage', textAlign:TextAlign.center),
                      SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: fetchPosts,
                          child: Text('Retry')
                      ),
                    ],
                  ),
                )
                    :RefreshIndicator(
                    onRefresh: fetchPosts,
                    child: ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=>PostDetail(post: filteredPosts[index])
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index+1}.${filteredPosts[index]['title']}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(filteredPosts[index]['body'],
                                    style: TextStyle(fontSize: 16, color:Colors.grey[700]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                )
            ),
          ],
        ),

    );
  }



}


class PostDetail extends StatelessWidget{
  final Map<String, dynamic> post;
  PostDetail({required this.post});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(post['title'])),
      body: Padding(
        padding:EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              post['body'],
              style: TextStyle(fontSize:18),
            )
          ],
        ),
      ),
    );
  }
}




