import 'package:get/get.dart';

class BookingController extends GetxController {
  // Observable selected date, initialized to now
  Rx<DateTime> selectedDate = DateTime.now().obs;

  // Observable selected time slot
  RxList<String> selectedSlots = <String>[].obs;

void toggleSlot(String slot) {
  if (selectedSlots.contains(slot)) {
    selectedSlots.remove(slot);
  } else {
    selectedSlots.add(slot);
  }
}

  void setDate(DateTime date) {
    selectedDate.value = date;
  }

  // void setSlot(String slot) {
  //   selectedSlot.value = slot;
  // }
}