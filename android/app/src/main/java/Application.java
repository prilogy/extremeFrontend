package com.example.extreme;

import io.flutter.app.FlutterApplication;
import com.vk.sdk.VKSdk;

public class Application extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        VKSdk.initialize(this);
    }
}