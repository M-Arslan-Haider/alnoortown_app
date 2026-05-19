////plugins {
////    id("com.android.application")
////    id("kotlin-android")
////    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
////    id("dev.flutter.flutter-gradle-plugin")
////}
////
////android {
////    namespace = "com.example.alnoortown_app"
////    compileSdk = flutter.compileSdkVersion
////    ndkVersion = flutter.ndkVersion
////
////    compileOptions {
////        sourceCompatibility = JavaVersion.VERSION_17
////        targetCompatibility = JavaVersion.VERSION_17
////    }
////
////    kotlinOptions {
////        jvmTarget = JavaVersion.VERSION_17.toString()
////    }
////
////    defaultConfig {
////        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
////        applicationId = "com.example.alnoortown_app"
////        // You can update the following values to match your application needs.
////        // For more information, see: https://flutter.dev/to/review-gradle-config.
////        minSdk = flutter.minSdkVersion
////        targetSdk = flutter.targetSdkVersion
////        versionCode = flutter.versionCode
////        versionName = flutter.versionName
////    }
////
////    buildTypes {
////        release {
////            // TODO: Add your own signing config for the release build.
////            // Signing with the debug keys for now, so `flutter run --release` works.
////            signingConfig = signingConfigs.getByName("debug")
////        }
////    }
////}
////
////flutter {
////    source = "../.."
////}
//
//plugins {
//    id("com.android.application")
//    id("kotlin-android")
//
//    // Flutter plugin
//    id("dev.flutter.flutter-gradle-plugin")
//
//    // Google Services plugin
//    id("com.google.gms.google-services")
//}
//
//android {
//    namespace = "com.example.alnoortown_app"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_17
//        targetCompatibility = JavaVersion.VERSION_17
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_17.toString()
//    }
//
//    defaultConfig {
//        applicationId = "com.example.alnoortown_app"
//        minSdk = flutter.minSdkVersion
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
//
//dependencies {
//
//    // Firebase BoM
//    implementation(platform("com.google.firebase:firebase-bom:34.13.0"))
//
//    // Firebase Analytics
//    implementation("com.google.firebase:firebase-analytics")
//
//    // Agar Auth use kar rahe ho
//    implementation("com.google.firebase:firebase-auth")
//
//}

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.alnoortown_app"
    ndkVersion = "29.0.14206865"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.example.alnoortown_app"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = false
            isShrinkResources = false
        }
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:33.16.0"))
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")

    // Multidex
    implementation("androidx.multidex:multidex:2.0.1")

    // Core desugaring (needed for isCoreLibraryDesugaringEnabled)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    // AndroidX
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.6.1")

    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
            force("androidx.activity:activity:1.9.2")
            force("androidx.activity:activity-ktx:1.9.2")
        }
    }
}
