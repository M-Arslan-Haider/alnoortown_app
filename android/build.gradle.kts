//////allprojects {
//////    repositories {
//////        google()
//////        mavenCentral()
//////    }
//////}
//////
//////val newBuildDir: Directory =
//////    rootProject.layout.buildDirectory
//////        .dir("../../build")
//////        .get()
//////rootProject.layout.buildDirectory.value(newBuildDir)
//////
//////subprojects {
//////    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//////    project.layout.buildDirectory.value(newSubprojectBuildDir)
//////}
//////subprojects {
//////    project.evaluationDependsOn(":app")
//////}
//////
//////tasks.register<Delete>("clean") {
//////    delete(rootProject.layout.buildDirectory)
//////}
////
////plugins {
////    id("com.google.gms.google-services") version "4.4.4" apply false
////}
////
////allprojects {
////    repositories {
////        google()
////        mavenCentral()
////    }
////}
////
////val newBuildDir: Directory =
////    rootProject.layout.buildDirectory
////        .dir("../../build")
////        .get()
////
////rootProject.layout.buildDirectory.value(newBuildDir)
////
////subprojects {
////    val newSubprojectBuildDir: Directory =
////        newBuildDir.dir(project.name)
////
////    project.layout.buildDirectory.value(newSubprojectBuildDir)
////}
////
////subprojects {
////    project.evaluationDependsOn(":app")
////}
////
////tasks.register<Delete>("clean") {
////    delete(rootProject.layout.buildDirectory)
////}
//
//plugins {
//    id("com.google.gms.google-services") version "4.4.4" apply false
//}
//
//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//val newBuildDir: Directory =
//    rootProject.layout.buildDirectory
//        .dir("../../build")
//        .get()
//
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory =
//        newBuildDir.dir(project.name)
//
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}


buildscript {
    extra["kotlin_version"] = "2.3.10"
    repositories {
        maven { url = uri("https://plugins.gradle.org/m2/") }
        mavenCentral()
        google()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.6.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.3.10")
        classpath("com.google.gms:google-services:4.4.4")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}