import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_assessment/riverpod/map_riverpod.dart';
import 'package:map_assessment/screens/second_screen.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(locationProvider.notifier).determinePositionAndAddress();

    final locationData = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        elevation: 0.0,
        leading: Center(
            child: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Exit App"),
                          content: const Text(
                              "Are you sure you want to exit the app?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                                child: const Text("Yes"))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ))),
        title: const Text('LocateMe'),
        centerTitle: true,
      ),
      body: locationData.position == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // ^_^ TOP ADDRESS ^_^
                Container(
                    height: MediaQuery.of(context).size.height * 0.050,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                        color: Colors.teal),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              locationData.address ?? 'Loading Address...',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 1,
                ),
                // ^_^ GOOGLE MAP ^_^
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: locationData.position!,
                          zoom: 16,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('current-location'),
                            position: locationData.position!,
                          ),
                        },
                      ),
                      // ^_^ NEXT SCREEN BUTTON ^_^
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).size.height * 0.77,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              BeveledRectangleBorder(),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.teal),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondScreen(
                                        address: locationData.address!)));
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
