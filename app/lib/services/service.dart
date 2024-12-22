import 'package:app/model/caller_info.dart';

class ServiceManager {
  ServiceManager._privateConstructor();

  static final ServiceManager _instance = ServiceManager._privateConstructor();
  String? userId;
  final List<String> userStatus = ['online', 'in-a-call', 'offline'];
  int? status = 0;
  bool incomingCall = false;
  CallerInfo? callerInfo;

  factory ServiceManager() {
    return _instance;
  }

  final List<String> callHistory = [];
  String? currentCall;

  void startCall(String phoneNumber) {
    currentCall = phoneNumber;
    print('Starting call to $phoneNumber');
    callHistory.add(phoneNumber);
  }

  void endCall() {
    print('Ending call with $currentCall');
    currentCall = null;
  }

  List<String> getCallHistory() {
    return callHistory;
  }
}
