RC单词
这个app是由HerrysYu开发完成的.大概的功能就是使用open ai调用gpt3.5模型,来对用户对单词,短语,内容翻译的查询.
用户配置自己的服务器需要有自己的api key
由于国内app上架对我来说不方便,故使用此方式发布.未来可能会在海外应用商城上架使用官方服务器的官方编译版.有需要的请翻墙下载
服务器端配置方式仅需将文件上传,打开防火墙端口,运行py文件即可
服务器部分程序/lib/SeverSoftware/sv.py  
服务器
配置(ubuntu)
据sv.py内说明配置好文件
使用pip安装websockets,openai两个依赖
ufw放行端口
运行 sv.py
客户端请搜索使用vscode运行flutter项目的步骤
