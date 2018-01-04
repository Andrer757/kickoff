android {

    flavorDimensions 'build'

    productFlavors {
        <#if configs.hasMultiDimensions!true>
        productFlavors.whenObjectAdded { flavor ->
            flavor.extensions.create("platformIds", AppIdExtension, "")
        }

        applicationVariants.all { variant ->
            def applicationId = project.APP_ID
            def flavors = variant.getProductFlavors()
            applicationId += flavors[0].platformIds.clientId

            if(variant.buildType.name.equals('dev')) {
                applicationId += project.DEV_APP_ID_SUFFIX
            <#if configs.hasQa!true>
            } else if(variant.buildType.name.equals('qa')) {
                applicationId += project.QA_APP_ID_SUFFIX
            }
            <#else>
            }
            </#if>
            variant.mergedFlavor.setApplicationId(applicationId)
        }
        </#if>
        app {
            dimension 'build'
            def appName = "${configs.projectName}"

            buildTypes {
                prod {
                    versionCode gitVersionCode
                    versionName gitVersionName
                    resValue ("string", "app_name", appName)
                    <#if configs.dependencies.retrofit??>
                    buildConfigField ("String", "API_BASE_URL", "\"${configs.dependencies.retrofit.prod}\"")
                    </#if>
					<#if configs.dependencies.fabrickey??>
                    buildConfigField ("boolean", "CRASHLYTICS_ENABLED", "true")
                    </#if>
                    <#if configs.dependencies.onesignal??>
                    manifestPlaceholders += [onesignal_app_id: "${configs.dependencies.onesignal.prod.appId}",
                    onesignal_google_project_number: "${configs.dependencies.onesignal.prod.googleProjectNumber}"]
                    </#if>
                }

                dev {
                    versionCode gitVersionCodeTime
                    versionName gitVersionName
                    resValue ("string", "app_name", appName + " DEV")
                    <#if configs.dependencies.retrofit??>
                    buildConfigField ("String", "API_BASE_URL", "\"${configs.dependencies.retrofit.dev}\"")
                    </#if>
					<#if configs.dependencies.fabrickey??>
                    buildConfigField ("boolean", "CRASHLYTICS_ENABLED", "false")
                    </#if>
                    <#if configs.dependencies.onesignal??>
                    manifestPlaceholders += [onesignal_app_id: "${configs.dependencies.onesignal.dev.appId}",
                    onesignal_google_project_number: "${configs.dependencies.onesignal.dev.googleProjectNumber}"]
                    </#if>
                }
                <#if configs.hasQa!true>

                qa {
                    versionCode gitVersionCodeTime
                    versionName gitVersionName
                    resValue ("string", "app_name", appName + " QA")
                    <#if configs.dependencies.retrofit??>
                    buildConfigField ("String", "API_BASE_URL", "\"${configs.dependencies.retrofit.qa}\"")
                    </#if>
					<#if configs.dependencies.fabrickey??>
                    buildConfigField ("boolean", "CRASHLYTICS_ENABLED", "false")
                    </#if>
                    <#if configs.dependencies.onesignal??>
                    manifestPlaceholders += [onesignal_app_id: "${configs.dependencies.onesignal.qa.appId}",
                    onesignal_google_project_number: "${configs.dependencies.onesignal.qa.googleProjectNumber}"]
                    </#if>
                }
                </#if>
            }
        }
    }
}

<#if configs.hasMultiDimensions!true>
class AppIdExtension {
    String clientId

    AppIdExtension(String cId){
        clientId = cId
    }

    void setClientId(String id){
        clientId = id
    }

    String getClientId(){
        clientId
    }
}
</#if>