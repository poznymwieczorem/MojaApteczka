plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.mojaapteczka.app"
    compileSdk = 34
    //ndkVersion = "27.0.12077973"  // <--- Zmienione z 26.3.11579264 na 27.0.12077973

    defaultConfig {
        applicationId = "com.mojaapteczka.app"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            // konfiguracja debug
        }
    }
}

flutter {
    source = "../.."
}
