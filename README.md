<div align="center">
    <h1>redsocks</h1>
    <img src="https://img.shields.io/badge/Made%20with-C-1f425f.svg" alt="made-with-c">
    <img src="https://img.shields.io/badge/Made%20with-Bash-1f5f42.svg" alt="made-with-bash">
    <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" alt="Maintenance">
    <img src="https://img.shields.io/badge/Maintainer-Ky9oss-red" alt="Maintainer">
    <br>
    <br>
    <img src="resources/linux.jpg" alt="" width="177" height="195">
    <br>
    <br>
</div>

This is a transparent TCP-to-proxy redirector. It's used to replace proxychains when `LD_PRELOAD` can not hijack the network of software, such as some software written in Go which does not even depend on `libc`.

It's a redirector rather than proxy. If you want some proxies in various protocal, then try 9proxy: [https://github.com/Ky9oss/9proxy]
