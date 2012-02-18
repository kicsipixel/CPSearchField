/*
 * Jakefile
 * CPSearchFieldExample
 *
 * Created by Szabolcs Toth on February 17, 2012.
 * Copyright 2012, purzelbaum.hu All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("CPSearchFieldExample", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "CPSearchFieldExample.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("CPSearchFieldExample");
    task.setIdentifier("com.yourcompany.CPSearchFieldExample");
    task.setVersion("1.0");
    task.setAuthor("purzelbaum.hu");
    task.setEmail("feedback @nospam@ yourcompany.com");
    task.setSummary("CPSearchFieldExample");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["CPSearchFieldExample"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "CPSearchFieldExample", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "CPSearchFieldExample", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "CPSearchFieldExample"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "CPSearchFieldExample"), FILE.join("Build", "Deployment", "CPSearchFieldExample")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "CPSearchFieldExample"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "CPSearchFieldExample"), FILE.join("Build", "Desktop", "CPSearchFieldExample", "CPSearchFieldExample.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "CPSearchFieldExample", "CPSearchFieldExample.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "CPSearchFieldExample"));
    print("----------------------------");
}
