import 'package:carousel_slider/carousel_slider.dart';
import 'package:coworking_space_booking/app/controllers/home_controller.dart';
import 'package:coworking_space_booking/app/view/home/widgets/office_card.dart';
import 'package:coworking_space_booking/app/view/notification/notification_view.dart';
import 'package:coworking_space_booking/app/view/search_view/search_view.dart';
import 'package:coworking_space_booking/app/view/single_details/single_details_view.dart';
import 'package:coworking_space_booking/core/extensions/space_ext.dart';
import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:coworking_space_booking/shared/widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final controller = Get.put(HomeController());
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Find Workspaces",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Discover coworking spaces near you",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          // Modern search button
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                Screen.open(SearchView());
              },
              icon: Icon(Icons.search, color: Colors.grey[700]),
              splashRadius: 24,
            ),
          ),
          // Modern notification button
          Container(
            margin: EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                Screen.open(NotificationView());
              },
              icon: Icon(Icons.notifications_outlined, color: Colors.grey[700]),
              splashRadius: 24,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Modern image slider with enhanced styling
          Container(
            height: height / 5.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CarouselSlider.builder(
                carouselController: controller.carouselController,
                options: CarouselOptions(
                  height: height / 5.5,
                  pageSnapping: true,
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.easeInOut,
                  autoPlayInterval: Duration(seconds: 4),
                  onPageChanged: (index, reason) {
                    controller.currentIndex.value = index;
                  },
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedImage(
                        imageUrl: controller.images[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Gradient overlay for better text readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          
          16.hBox,
          
          // Modern page indicator
          Obx(
            () => Center(
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentIndex.value,
                count: controller.images.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.blue,
                  dotColor: Colors.grey.shade300,
                  dotHeight: 8,
                  dotWidth: 8,
                  expansionFactor: 3,
                ),
              ),
            ),
          ),
          
          24.hBox,
          
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available Workspaces",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  Screen.open(SearchView());
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
         16.hBox,

          // Modern office cards with enhanced loading states
          Obx(() {
            if (controller.isLoading.value) {
              return Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: const OfficeCardShimmer(),
                  ),
                ),
              );
            } else if (controller.officeSpaces.isEmpty) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.business_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No Workspaces Available",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Check back later for new spaces",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: List.generate(
                  controller.officeSpaces.length,
                  (index) {
                    final office = controller.officeSpaces[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: OfficeCard(
                        office: office,
                        onTap: () {
                          Screen.open(SingleDetailsView(office: office));
                        },
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}