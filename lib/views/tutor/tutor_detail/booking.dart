import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mockBookingService = BookingService(
        bookingStart: DateTime(now.year,now.month,now.day,8,0),
        bookingEnd: DateTime(now.year, now.month, now.day, 21, 0),
        serviceName: 'Mock Service',
        serviceDuration: 30);
  }

  Stream<dynamic>? getBookingStreamMock({required DateTime end, required DateTime start}){
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    DateTime first = now;
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Tutor Booking'),
      ),
      body: Center(
        child: BookingCalendar(
          bookingService: mockBookingService,
          convertStreamResultToDateTimeRanges: convertStreamResultMock,
          getBookingStream: getBookingStreamMock,
          uploadBooking: uploadBookingMock,
          pauseSlots: generatePauseSlots(),
          pauseSlotText: 'LUNCH',
          hideBreakTime: false,
          loadingWidget: const Text('Fetching data...'),
          uploadingWidget: const CircularProgressIndicator(),
          locale: 'en_EN',
          startingDayOfWeek: StartingDayOfWeek.tuesday,
        ),
      ),
    );
  }
}
