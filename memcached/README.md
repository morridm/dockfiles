
接受参数 ：
MAXCONN int 默认 1024
CACHESIZE int 默认 128

`
docker run -d -p 22 -p 11211 -m 192 elex/memcached

docker run -d -p 22 -p 11211 -m 384 -e MAXCONN=4096 -e CACHESIZE=256 elex/memcached
`
