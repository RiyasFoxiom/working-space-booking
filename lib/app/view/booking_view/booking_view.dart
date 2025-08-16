import 'package:coworking_space_booking/app/models/working_space_model.dart';
import 'package:coworking_space_booking/app/view/landing_view/landing_view.dart';
import 'package:coworking_space_booking/core/extensions/space_ext.dart';
import 'package:coworking_space_booking/core/screen_utils.dart';
import 'package:coworking_space_booking/core/style/app_font.dart';
import 'package:coworking_space_booking/shared/utils/date_time_helper.dart';
import 'package:coworking_space_booking/shared/widgets/app_bottum_sheet.dart';
import 'package:coworking_space_booking/shared/widgets/app_success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../../controllers/booking_controller.dart';

class BookingView extends StatelessWidget {
  const BookingView({super.key, required this.office});

  final WorkSpace office;

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking"),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          Obx(
            () => EasyTheme(
              data: EasyTheme.of(context).copyWithState(
                selectedCurrentDayTheme: const DayThemeData(
                  backgroundColor: Color(0xffc0bd00),
                  border: BorderSide.none,
                ),
              ),
              child: EasyDateTimeLinePicker(
                selectionMode: SelectionMode.alwaysFirst(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                focusedDate: controller.selectedDate.value,
                onDateChange: (date) => controller.setDate(date),
                headerOptions: const HeaderOptions(headerType: HeaderType.none),
                currentDate: controller.selectedDate.value,
              ),
            ),
          ),

          24.hBox,
          const Text(
            "Select Time Slot",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          12.hBox,

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: _timeSlots.length,
            itemBuilder: (context, index) {
              final slot = _timeSlots[index];
              return Obx(() {
                final isSelected = controller.selectedSlots.contains(slot);

                return GestureDetector(
                  onTap: () => controller.toggleSlot(slot),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xffc0bd00)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 18,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xffc0bd00),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          slot,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),

          // Order summary
          Obx(() {
            final selectedDate = controller.selectedDate.value;
            final selectedSlots = controller.selectedSlots;
            final slotCount = selectedSlots.length;
            final totalPrice = slotCount * (office.ratePerHr ?? 0);
            if (slotCount == 0) return SizedBox.shrink();
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Summary",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  8.hBox,
                  Row(
                    children: [
                      const Text("Selected Date :"),
                      const Spacer(),
                      Text(
                        formatDate(selectedDate),
                        style: const TextStyle(fontFamily: inter500),
                      ),
                    ],
                  ),
                  4.hBox,
                  Row(
                    children: [
                      const Text("Slots Selected :"),
                      const Spacer(),
                      Text(
                        "$slotCount",
                        style: const TextStyle(fontFamily: inter500),
                      ),
                    ],
                  ),
                  4.hBox,

                  Row(
                    children: [
                      const Text("Rate per Hour :"),
                      const Spacer(),
                      Text(
                        "₹${office.ratePerHr}",
                        style: const TextStyle(fontFamily: inter500),
                      ),
                    ],
                  ),
                  const Divider(height: 20, thickness: 0.5),
                  Row(
                    children: [
                      const Text("Total Price :"),
                      const Spacer(),
                      Text(
                        "₹$totalPrice",
                        style: const TextStyle(
                          fontFamily: inter700,
                          fontSize: 15,
                          color: Color(0xffc0bd00),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: Obx(() {
        // final selectedDate = controller.selectedDate.value;
        final selectedSlots = controller.selectedSlots;
        final isEnabled = selectedSlots.isNotEmpty;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: isEnabled
                    ? () {
                        openAppBottomSheet(
                          AppSuccessBottomSheet(
                            title: "Booking Successful 🎉",
                            subTitle: "Your booking has been confirmed.",
                          ),
                          isSuccess: true,
                        ).then((value) {
                        Screen.openAsNewPage(LandingView());
                          
                        },);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffc0bd00),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Confirm Booking"),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Time slots for booking
  static const List<String> _timeSlots = [
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
  ];
}
