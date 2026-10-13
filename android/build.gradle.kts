allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// The SDK components the family image ships; /opt/android-sdk is read-only, so any other version fails the build.
extra["kataglyphisCompileSdk"] = 37
extra["kataglyphisBuildTools"] = "37.0.0"
extra["kataglyphisNdk"] = "29.0.14206865"

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
// Covers the plugins too; it must stay above evaluationDependsOn, which evaluates :app before afterEvaluate could register.
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { ext ->
            val android = ext as com.android.build.gradle.BaseExtension
            android.compileSdkVersion(rootProject.extra["kataglyphisCompileSdk"] as Int)
            android.buildToolsVersion = rootProject.extra["kataglyphisBuildTools"] as String
            android.ndkVersion = rootProject.extra["kataglyphisNdk"] as String
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
