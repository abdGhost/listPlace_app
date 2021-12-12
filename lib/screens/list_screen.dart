import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_list_of_places/screens/details_screen.dart';

class ListPlaces extends StatefulWidget {
  const ListPlaces({Key key}) : super(key: key);

  @override
  _ListPlacesState createState() => _ListPlacesState();
}

class _ListPlacesState extends State<ListPlaces> {
  List<GetPlace> places = [];

  @override
  void initState() {
    super.initState();
  }

  Future getApiService() async {
    String url =
        "https://adultfamilyhomes.org/api/myafh/filtered_list?city=kirkland";
    final response = await http.get(Uri.parse(url));

    Future.delayed(const Duration(seconds: 3));
    var jsonData1 = jsonDecode(response.body);
    var jsonData = jsonData1["listFilterPojo"];

    for (var u in jsonData) {
      GetPlace place = GetPlace(
        stayId: u['stayId'],
        userHouseName: u['userHouseName'],
        imageUrl: u['imagePath'],
        userCity: u['userCity'],
        ownName: u['ownerName'],
        userAddress: u['userAddress'],
        slugTitle: u['slugTitle'],
        subStatus: u['subscriptionStatus'],
      );
      places.add(place);
    }
    return places;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.blue[50],
              Colors.blue[100],
              Colors.blue[200],
              Colors.blue[300]
            ])),
        child: SafeArea(
          child: Container(
            child: FutureBuilder(
                future: getApiService(),
                builder: (context, snaphsot) {
                  if (snaphsot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return GridView.builder(
                      itemCount: snaphsot.data.length,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                    place: places[index],
                                  ),
                                ));
                          },
                          child: Stack(fit: StackFit.expand, children: <Widget>[
                            Image.network(
                              snaphsot.data[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  color: Colors.black38,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${snaphsot.data[index].userHouseName}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              '${snaphsot.data[index].userCity}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ]),
                        );
                      },
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

class GetPlace {
  final String stayId;
  final String userHouseName;
  final String imageUrl;
  final String userCity;
  final String userAddress;
  final String slugTitle;
  final String ownName;
  final String subStatus;

  GetPlace({
    @required this.stayId,
    @required this.userHouseName,
    @required this.imageUrl,
    @required this.userCity,
    @required this.slugTitle,
    @required this.ownName,
    @required this.userAddress,
    @required this.subStatus,
  });
}
