如代码放在docker外，需设置卷, 根据nginx设置调整

`docker run -d -p 22 -p 9000 -v [/host/path:/container/path]elex/php-yum`
