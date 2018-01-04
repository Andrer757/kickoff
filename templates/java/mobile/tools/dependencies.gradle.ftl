dependencies {
    compile fileTree(dir: 'libs', include: ['*.jar'])
    <#if configs.dependencies.fabrickey??>

    /* FABRIC CRASHLYTICS */
compile("com.crashlytics.sdk.android:crashlytics:$project.fabricCrashlyticsVersion") {
transitive = true;
}
</#if>
    <#if configs.dependencies.onesignal??>

    /* ONESIGNAL */
    compile "com.onesignal:OneSignal:$project.oneSignalVersion"
    </#if>
    <#if configs.dependencies.others??>
    <#list configs.dependencies.others>
    <#items as dependency>

    /* ${dependency.name} */
    <#list dependency.list as dep>
    compile("${dep}:$project.${dependency.name?lower_case?replace(" ", "")}Version")
    </#list>
    </#items>
    </#list>
    </#if>
}