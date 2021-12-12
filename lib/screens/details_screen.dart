import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_list_of_places/screens/list_screen.dart';

class DetailsScreen extends StatelessWidget {
  final GetPlace place;

  DetailsScreen({
    @required this.place,
  });

  @override
  Widget build(BuildContext context) {
    print(place.slugTitle);
    print(place.userAddress);
    print(place.ownName);
    return Scaffold(
        appBar: AppBar(),
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
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white),
                    child: Image.network(
                      place.imageUrl,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(height: 100.0)
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 220.0,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.blue[50],
                              Colors.blue[100],
                              Colors.blue[200],
                              Colors.blue[300]
                            ]),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: 260,
                      height: 220,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              place.userHouseName,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              place.ownName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              place.userCity,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              place.userAddress,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text(
                            'Feature Not Avaible',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Go Back',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ))
                          ],
                        ),
                      );
                    },
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
