package com.massivedisaster.kickoff.config;

import java.util.List;

public class Dependencies {

    private String fabrickey;
    private RetrofitConfiguration retrofit;
    private OnesignalConfiguration onesignal;
    private CalligraphyConfiguration calligraphy;
    private List<DependencyExtra> others;
    private List<String> filesToRemove;

    public String getFabrickey() {
        return fabrickey;
    }

    public RetrofitConfiguration getRetrofit() {
        return retrofit;
    }

    public OnesignalConfiguration getOnesignal() {
        return onesignal;
    }

    public CalligraphyConfiguration getCalligraphy() {
        return calligraphy;
    }

    public List<DependencyExtra> getOthers() {
        return others;
    }

    public List<String> getFilesToRemove() {
        return filesToRemove;
    }
}
