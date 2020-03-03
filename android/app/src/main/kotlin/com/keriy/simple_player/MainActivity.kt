package com.keriy.simple_player

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Context
import io.flutter.embedding.engine.dart.DartExecutor


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

//    override fun provideFlutterEngine(context: Context): FlutterEngine? {
//        val flutterEngine = FlutterEngine(context.getApplicationContext())
//        flutterEngine.getDartExecutor().executeDartEntrypoint(
//                DartExecutor.DartEntrypoint.createDefault()
//        )
//        return flutterEngine
//    }
}
