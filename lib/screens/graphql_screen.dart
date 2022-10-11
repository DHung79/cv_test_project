import 'package:cv_test_project/core/base/logger/logger.dart';
import 'package:cv_test_project/core/media/media.dart';
import 'package:cv_test_project/core/media/queries/graphql_queries.dart';
import 'package:cv_test_project/screens/layout_template.dart';
import 'package:cv_test_project/themes/button_theme.dart';
import 'package:flutter/material.dart';
import '../core/base/rest/models/rest_api_response.dart';

class GraghqlScreen extends StatefulWidget {
  const GraghqlScreen({super.key});

  @override
  State<GraghqlScreen> createState() => _GraghqlScreenState();
}

class _GraghqlScreenState extends State<GraghqlScreen> {
  final mediaBloc = MediaBloc();
  int page = 1;
  int limit = 10;
  @override
  void initState() {
    _fetchDataOnPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: StreamBuilder<ApiResponse<ListMediaModel?>>(
        stream: mediaBloc.allData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final medias = snapshot.data!.model!.records;
            final meta = snapshot.data!.model!.meta;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 32, 8, 0),
                  child: Row(
                    children: [
                      JTButton.rounded(
                        height: 50,
                        width: 100,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            if (page > 1) {
                              page--;
                              _fetchDataOnPage();
                            }
                          });
                        },
                        child: Icon(
                          Icons.navigate_before_outlined,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: JTButton.rounded(
                          height: 50,
                          width: 100,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              if (page < meta.totalPage) {
                                page++;
                                _fetchDataOnPage();
                              }
                            });
                          },
                          child: Icon(
                            Icons.navigate_next_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: medias.length,
                    itemBuilder: (context, index) {
                      final media = medias[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Card(
                          elevation: 16,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    media.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        media.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Text(
                                          media.type,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _fetchDataOnPage() {
    mediaBloc.fetchAllData(
      query: GraphqlQueries.getMediaList(),
      variables: {
        'page': page,
        'perPage': limit,
      },
    );
  }
}
