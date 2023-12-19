package com.example.infinite_base;

import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
import com.baidu.mapapi.SDKInitializer;

public class MainActivity extends FlutterActivity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SDKInitializer.setAgreePrivacy(getApplication(), true);
        SDKInitializer.initialize(getApplication());
    }
}
