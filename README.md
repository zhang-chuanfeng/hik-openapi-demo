# Hikapi Demo

hik openapi demo build

```
cd zig && zig build --release=small
```

通过zig构建编译生成  hikopenapi程序

export指定LD_LIBRARY_PATH pulic/lib/linux/Release


```
./hikopenapi 路径   请求body
```

实际是 POST  https://10.188.0.101:443/artemis/api/ + 路径 

可以通过修改hikopenapi.zig代码指定访问的路径