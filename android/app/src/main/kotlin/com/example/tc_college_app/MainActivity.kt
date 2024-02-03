package com.example.tc_college_app

import io.flutter.embedding.android.FlutterActivity
// added for screenshot protection
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.view.WindowManager.LayoutParams
// ...

class MainActivity: FlutterActivity() {
    //this was also added for screenshot protection
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
    //...
}
