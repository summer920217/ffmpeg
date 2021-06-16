## 如何使用ffmpeg切片视频
### 1. 安装ffmpeg命令行工具
```
  - 1. 下载ffmpeg-4.4-full_build.7z 压缩包
  - 2. 解压缩
  - 3. 添加到环境变量
    PATH: C:\Users\Administrator\Downloads\ffmpeg-4.4-full_build\bin;
  - 4. win+r
    - cmd
    - ffmpeg 测试成功即可使用
```
### 2. ffmpeg命令
``` 
  - 指定一个 flv格式切片
  - 【03.flv】 ---> 【result2/03.m3u8】 + n个【result2\course-%%04d.ts】 
  ffmpeg -i 03.flv -c copy -map 0 -f segment -segment_list "result2\03.m3u8" -segment_time 5 "result2\course-%%04d.ts"

  - 指定一个 mp4格式切片
  - 【03.mp4】 ---> 【result2/03.m3u8】 + n个【result2\course-%%04d.ts】
  ffmpeg -i 03.mp4 -f segment -segment_time 10 -segment_format mpegts -segment_list "result2\03.m3u8" -c copy -bsf:v h264_mp4toannexb -map 0 "result2\course-%%04d.ts"

```
### 3. win下创建.bat批处理文件，一键处理
  新建 run.bat
```
  ::指定一个 flv格式切片
  :: 【03.flv】 ---> 【result2/03.m3u8】 + n个【result2\course-%%04d.ts】
  ::for %%a in ("03.flv") do ffmpeg -i 03.flv -c copy -map 0 -f segment -segment_list "result2\03.m3u8" -segment_time 5 "result2\course-%%04d.ts"

  ::指定一个 mp4格式切片
  :: 【03.mp4】 ---> 【result2/03.m3u8】 + n个【result2\course-%%04d.ts】
  ::for %%a in ("03.flv") do ffmpeg -i 03.mp4 -f segment -segment_time 10 -segment_format mpegts -segment_list "result2\03.m3u8" -c copy -bsf:v h264_mp4toannexb -map 0 "result2\course-%%04d.ts"

  ::转当前目录所有mp4到result文件夹
  :: 【*.mp4】---> n个【result/03.m3u8】 + n个【result\course-%%04d.ts】
  ::for %%a in ("*.mp4") do ffmpeg -i %%a -f segment -segment_time 240 -segment_format mpegts -segment_list "result\%%a~nv.m3u8" -c copy -bsf:v h264_mp4toannexb -map 0 "result\%%a-%%04d.ts"

  ::转所有mp4到result/对应文件夹下
  :: 【*.mp4】---> n个文件夹(【result2/03.m3u8】 + n个【result2\course-%%04d.ts】)
  ::for %%a in ("*.mp4") do (if not exist "result\%%a" md "result\%%a" && ffmpeg -i %%a -f segment -segment_time 240 -segment_format mpegts -segment_list "result\%%a\~nv.m3u8" -c copy -bsf:v h264_mp4toannexb -map 0 "result\%%a\%%04d.ts")

  ::for %%a in ("*.mp4") do ffmpeg -i %%a -vcodec h264 "1-%%a"

  for %%a in ("*.flv") do (if not exist "result\%%a" md "result\%%a" && ffmpeg -i %%a -f segment -segment_time 240 -segment_format mpegts -segment_list "result\%%a\~nv.m3u8" -c copy  -map 0 "result\%%a\%%04d.ts")

  pause
```
