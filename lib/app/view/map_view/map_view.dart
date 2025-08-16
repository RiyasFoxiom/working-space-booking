import 'package:coworking_space_booking/app/controllers/map_controller.dart';
import 'package:coworking_space_booking/app/view/single_details/single_details_view.dart';
import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:coworking_space_booking/shared/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapControllerX());

    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            FlutterMap(
              mapController: controller.mapController,
              options: MapOptions(
                initialCenter: LatLng(
                  controller.latitude.value,
                  controller.longitude.value,
                ),
                initialZoom: 12,
                minZoom: 10.0,
                maxZoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.coworking_space_booking',
                ),
                MarkerLayer(markers: controller.markers),
              ],
            ),
            // Bottom info card
            if (controller.selectedPlace.value != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    child: ListTile(
                      onTap: () {
                        Screen.open(SingleDetailsView(office: controller.selectedPlace.value!));
                      },
                      leading: CachedImage(
                        imageUrl: controller.selectedPlace.value?.image,
                        fit: BoxFit.cover,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      title: Text(
                        controller.selectedPlace.value!.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Location: ${controller.selectedPlace.value!.location ?? ''}",
                          ),
                          Text(
                            "₹${controller.selectedPlace.value!.ratePerHr ?? 0}/hr",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}