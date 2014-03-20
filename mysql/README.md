需挂载宿主机上的文件夹作为卷, 重用文件夹时需注意权限

`docker run -d -p [3306:]3306 -p 22 -v  /data/mysql:/var/lib/mysql elex/mysql_test`
