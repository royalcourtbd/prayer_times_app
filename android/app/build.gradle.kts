import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile: File = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// Version management from local.properties
val localPropertiesFile: File = rootProject.file("local.properties")
val localProperties = Properties()
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

val flutterVersionCode: Int = localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
val flutterVersionName: String = localProperties.getProperty("flutter.versionName") ?: "1.0"

android {
    namespace = "com.sarahtech.prayer_times"
    compileSdk = 36

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.sarahtech.prayer_times"
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        multiDexEnabled = true
        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = keystoreProperties.getProperty("storeFile")?.let { file(it) }
            storePassword = keystoreProperties.getProperty("storePassword")
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isDebuggable = false
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            ndk {
                abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.6.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
