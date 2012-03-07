PhotoSubmitter Example
=================================
This repository is example project of [PhotoSubmitter](https://github.com/kent013/PhotoSubmitter) library. The purpose of PhotoSubmitter iOS class library is to facilitate the development of photo upload application.

This example project demonstrates minimum implementation of PhotoSubmitter. If you want to know more details, please visit [tottepost project](https://github.com/kent013/tottepost). Originally PhotoSubmitter library is designed to work with tottepost, so tottepost is demonstrates all of the functions in PhotoSubmitter.

<img src="http://github.com/kent013/tottepost/raw/master/AppStore/screenshot4_en.png"
 alt="ScreenShot4" title="ScreenShot4" height = 240 />
<img src="http://github.com/kent013/tottepost/raw/master/AppStore/screenshot5_en.png"
 alt="ScreenShot5" title="ScreenShot5" height = 240 />

Build the Project
-------------------------
To build and test functionalities, please read [PhotoSubmitter's README](https://github.com/kent013/PhotoSubmitter). If you want to use OAuth enabled services, you require to obtain API-Keys and API-Secret from services. Also some services require to configure Custom URI Scheme.

Since this project using Camera, currently not works on simulator. Please run on device.

And, just after cloning the repository, you must run commands below to init and update submodule.
```
git submodule init
git submodule update
```

GIT TIPS
------------------------------------
For contributors reminder, if you want to update submodule to latest revision, type next command.
```
git submodule foreach 'git checkout master; git pull'
```