import 'package:cv_test_project/screens/layout_template.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraghqlScreen extends StatefulWidget {
  const GraghqlScreen({super.key});

  @override
  State<GraghqlScreen> createState() => _GraghqlScreenState();
}

class _GraghqlScreenState extends State<GraghqlScreen> {
  List<dynamic> data = [];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: Container(
        width: 500,
        height: 500,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final media = MediaModel.fromJson(data[index]);
            return Container(
              width: 100,
              height: 100,
              color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      media.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      media.type,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void fetchData() async {
    HttpLink link = HttpLink("https://graphql.anilist.co/");
    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(
          """query () {
  Page () {
    pageInfo {
      total
      currentPage
      lastPage
      hasNextPage
      perPage
    }
    media () {
      id
      type
      title {
        english
      }
    }
  }
}""",
        ),
      ),
    );

// queryResult.data  // contains data
// queryResult.exception // will give what exception you got /errors
// queryResult.hasException // you can check if you have any exception

// queryResult.context.entry<HttpLinkResponseContext>()?.statusCode  // to get status code of response

    setState(() {
      data = queryResult.data!['Page']['media'];
    });
  }
}

class MediaModel {
  late int id;
  late String name;
  late String type;
  MediaModel({
    required this.id,
    required this.name,
    required this.type,
  });

  MediaModel.fromJson(Map<String, dynamic> data) {
    id = data["id"] ?? 0;
    name = data["title"]["english"] ?? '';
    type = data["type"] ?? '';
  }
}
