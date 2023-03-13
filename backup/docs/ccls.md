ccls build
---

### 最终编译脚本

```cmake
cmake \
    -H. \
    -BRelease \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=lld \
    -DCMAKE_PREFIX_PATH=/usr

cmake --build Release --parallel
cmake --install Release
```