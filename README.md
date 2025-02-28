# Warp-proxy
This docker config generates a container that acts as a socks5 proxy, routing traffic through **Cloudflare** using [warp](https://one.one.one.one/).

Example with and without proxy.
> NOTE: notice `warp=` line
```console
root@host:~# curl -x socks5h://localhost:40000 https://www.cloudflare.com/cdn-cgi/trace
...
ip=104.28.223.105
...
warp=on
...

root@host:~# curl https://www.cloudflare.com/cdn-cgi/trace
...
ip=42.42.42.42
...
warp=off
...
```