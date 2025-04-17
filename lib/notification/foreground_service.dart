import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:training_mma_timer/config/helpers/timer_format.dart';
import 'package:training_mma_timer/presentation/bloc/timer_bloc.dart';




// The callback function should always be a top-level or static function.
@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {

  // Called when the task is started.
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    print('********************************************** onStart(starter: ${starter.name} **********************************************)');
  
  }

  // Called based on the eventAction set in ForegroundTaskOptions.
  @override
  void onRepeatEvent(DateTime timestamp) {
    // _incrementCount();
  }

  // Called when the task is destroyed.
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    print('onDestroy');
  }

  // Called when data is sent using `FlutterForegroundTask.sendDataToTask`.
  @override
  void onReceiveData(Object data) {
    print('onReceiveData: $data');
    // if (data == incrementCountCommand) {
    //   _incrementCount();
    // }
    // Update notification content.
    if(data is int) {
      FlutterForegroundTask.updateService(
        
      notificationTitle: 'Entrenamiento en Curso',
      notificationText: '${toMinutesStr(data )}:${toSecondsStr(data)}',
    );
    } else if (data is String) {
      //Hacer Nada
    }

  }

  // Called when the notification button is pressed.
  @override
  void onNotificationButtonPressed(String id) {
    if(id == 'pause') {
      // Emitir el evento para pausar el temporizador
      
    } else if (id == 'cancel') {
      //Emitir estado de cancelar en el bloc
      FlutterForegroundTask.stopService();
    }
 
  }

  // Called when the notification itself is pressed.
  @override
  void onNotificationPressed() {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa onNotificationPressed');
  }

  // Called when the notification itself is dismissed.
  @override
  void onNotificationDismissed() {
    print('onNotificationDismissed');
  }
}