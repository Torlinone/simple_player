package com.keriy.simple_player

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.plugin.common.PluginRegistry
import io.flutter.app.FlutterApplication
import io.flutter.plugins.GeneratedPluginRegistrant
import com.ryanheise.audioservice.AudioServicePlugin
import io.flutter.embedding.android.FlutterEngineProvider
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.view.FlutterMain

class MainApplication : FlutterApplication(), PluginRegistry.PluginRegistrantCallback, FlutterEngineProvider {
    override fun onCreate() {
        super.onCreate()
        AudioServicePlugin.setPluginRegistrantCallback(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        GeneratedPluginRegistrant.registerWith(provideFlutterEngine(this))
    }

    override fun provideFlutterEngine(@NonNull context: Context): FlutterEngine {
        return FlutterEngine(context)
    }
}
