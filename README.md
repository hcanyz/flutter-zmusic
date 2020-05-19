# zmusic

A music player for flutter that imitation netease cloud music.

### TODO
- [ ] ui
- [ ] 架构

### 注意事项
- 本项目仅供学习使用,请尊重版权，请勿利用此项目从事商业行为
- 网易云音乐api sdk已单独抽离到 [这个仓库](https://github.com/hcanyz/flutter-netease-music-api)

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

### 编译环境
```text
Flutter 1.19.0-2.0.pre.71 • channel master • https://github.com/flutter/flutter.git
Framework • revision 800e951160 (3 hours ago) • 2020-05-14 20:47:01 -0400
Engine • revision 50e55cf69e
Tools • Dart 2.9.0 (build 2.9.0-9.0.dev 2676764792)
```