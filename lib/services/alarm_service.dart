import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AlarmService() => _instance;

  AlarmService._internal() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      // Handle audio player state changes if needed
    });
  }

  void init() {
    // Initialize any necessary setup for alarms or audio player
    AndroidAlarmManager.initialize();
  }

  void scheduleAlarm(DateTime alarmTime, Function callbackFunction) {
    int alarmId = Random().nextInt(pow(2, 31).toInt()); // Generate a random ID

    AndroidAlarmManager.oneShotAt(
      alarmTime,
      alarmId,
      () async {
        // Trigger audio playback when alarm fires
        await _audioPlayer.play(AssetSource('sound/alarm_sound.mp3'));
        // Call the callback function for additional actions (e.g., show notification)
        callbackFunction();
      },
      exact: true,
      wakeup: true,
      allowWhileIdle: true,
    );
  }

  void cancelAlarm(int alarmId) {
    AndroidAlarmManager.cancel(alarmId);
    _audioPlayer.stop(); // Stop audio playback when cancelling alarm
  }
}
