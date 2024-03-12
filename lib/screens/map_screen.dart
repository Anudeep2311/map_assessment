import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_assessment/riverpod/map_riverpod.dart';

class MapScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize location fetching on widget build
    ref.read(locationProvider.notifier).determinePositionAndAddress();

    final locationData = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Current Location')),
      body: locationData.position == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(locationData.address ?? 'Loading Address...'),
                Expanded(
                  child: GoogleMap(
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
                ),
              ],
            ),
    );
  }
}
