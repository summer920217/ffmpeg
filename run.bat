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