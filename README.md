# zmusic

A music player for flutter that imitation netease cloud music.

### TODO
- [ ] ui
  - [x] splash
  - [x] login
  - [ ] home
  - [ ] ...
- [ ] 全局
  - [ ] fish redux
  - [ ] i18n
  - [ ] theme
  - [ ] ...

### 注意事项
- 本项目仅供学习使用,请尊重版权，请勿利用此项目从事商业行为
- 网易云音乐api sdk已单独抽离到 [flutter-netease-music-api](https://github.com/hcanyz/flutter-netease-music-api)

### 项目分包结构
```text
- lib
    - app
        - splash                     首屏页
            _*.dart                  具体业务逻辑，外部不能直接调用
            z_api.dart               模块对外服务
            
        - login                      登录
            z_api.dart
            
        - home                       首页
            z_api.dart
            
    - common                         公共
        
    main.dart                        入口
```
#### 约定
app目录中，每一个子目录代表一个独立模块，独立模块间不能直接调用代码，保证模块独立性。  
如果模块间需要交互，通过各个模块中的z_api.dart对外暴露接口、方法、bean、常量等

### flutter version
```text
flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel master, 1.21.0-6.0.pre.142, on Microsoft Windows [Version 10.0.18363.959], locale zh-CN)

[√] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
[√] Chrome - develop for the web
[√] Android Studio (version 4.0)
[√] VS Code (version 1.47.3)
[√] VS Code, 64-bit edition
[√] Connected device (2 available)
```