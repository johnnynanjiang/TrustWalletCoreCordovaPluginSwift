# Cordova Echo Extension

This example project demonstrates how to create and extension for Cordova that uses native code.

## Install

1.

```
git clone <echo-cordova repo>
git clone <echo-cordova-plugin>
```

You should now have `./echo-cordova`, `./echo-cordova-plugin`.

Repos:
* https://github.com/nano3labs/echo-cordova
* https://github.com/nano3labs/echo-cordova-plugin

2.
```
cd ./echo-cordova
cordova platform add ios
cordova plugin add /full/path/to/echo-cordova-plugin
cordova build ios
```

## Running

Open `platforms/ios/EchoCordova.xcworkspace` in xcode and run either on the device or emulator.

## Notes
* remember to run `cordova build ios` everytime you make a change to the javascript
* remove and add plugin if you make changes to OBJ-C code and remember to build cordova again (as per above)
* debug using xcode debugger to step through code OBJ-C code
* debug using safari remote debugger to step through Javascript code or see errors

## References

* https://cordova.apache.org/docs/en/latest/guide/hybrid/plugins/
* https://cordova.apache.org/docs/en/latest/guide/platforms/ios/plugin.html
* https://github.com/apache/cordova-plugin-camera

