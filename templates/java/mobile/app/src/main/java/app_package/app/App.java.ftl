package ${configs.packageName}.app;

import android.app.Application;

<#if configs.dependencies.fabrickey??>
import ${configs.packageName}.BuildConfig;

import com.crashlytics.android.Crashlytics;

import io.fabric.sdk.android.Fabric;
</#if>
<#if configs.dependencies.onesignal??>
import com.onesignal.OneSignal;
</#if>

<#if configs.dependencies.calligraphy??>
import ${configs.packageName}.R;

import uk.co.chrisjenx.calligraphy.CalligraphyConfig;
</#if>

/**
 * Base class fot the application.
 * You need to add this class to your manifest file.
 */
public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
		<#if configs.dependencies.fabrickey??>

        if (BuildConfig.CRASHLYTICS_ENABLED) {
            Fabric.with(this, new Crashlytics());
        }
		</#if>
		<#if configs.dependencies.calligraphy??>

		CalligraphyConfig.initDefault(new CalligraphyConfig.Builder()
			.setDefaultFontPath(getString(R.string.fontRegular))
			.setFontAttrId(R.attr.fontPath)
			.build());
		</#if>
		<#if configs.dependencies.onesignal??>

        OneSignal.startInit(this).init();
		</#if>
    }
}
