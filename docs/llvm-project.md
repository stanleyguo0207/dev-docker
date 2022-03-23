LLVM build
---

### llvm-project编译手册

#### 参考链接

https://llvm.org/docs/CMake.html

### 最终编译脚本

### 文档解读

#### CMake 变量

-   `CMAKE_BUILD_TYPE:STRING`

    要编译的类型，直接用`Release `就好了。

-   `CMAKE_INSTALL_PREFIX:PATH`

    LLVM 的安装路径。

-   `CMAKE_{C,CXX}_FLAGS:STRING`

    `C`和`C++`源文件的构建标志。

-   `CMAKE_{C,CXX}_COMPILER:STRING`

    `C`和`C++`编译器指定。

-   `CMAKE_CXX_STANDARD:STRING`

    构建 LLVM 的 c++ 标准。默认为14。可以14、17、20。

-   `CMAKE_INSTALL_BINDIR:PATH`

    安装可执行的路径。默认"bin"。

-   `CMAKE_INSTALL_INCLUDEDIR:PATH`

    安装头文件的路径。默认"include"。

-   `CMAKE_INSTALL_DOCDIR:PATH`

    安装文档的路径。默认"share/doc"。

-   `CMAKE_INSTALL_MANDIR:PATH`

    安装man文档的路径。默认"share/man"。


#### LLVM 变量

-   `LLVM_ENABLE_PROJECTS:STRING`

    控制启动项目。

-   `LLVM_ENABLE_RUNTIMES:STRING`

    控制运行库。

-   `LLVM_LIBDIR_SUFFIX:STRING`

    安装库目录额外后缀。可以使用 `-DLLVM_LIBDIR_SUFFIX=64` 将库安装到 `/usr/lib64`。

-   `LLVM_PARALLEL_{COMPILE,LINK}_JOBS:STRING`

    并行度内存限制。`-GNinja -DLLVM_PARALLEL_LINK_JOBS=2`。

-   `LLVM_TARGETS_TO_BUILD:STRING`

    控制哪些目标。 `-DLLVM_TARGETS_TO_BUILD=X86`。

-   `LLVM_USE_LINKER:STRING`

    覆盖默认的链接器。`-DLLVM_USE_LINKER=lld`。

-   `BUILD_SHARED_LIBS:BOOL`

    LLVM 的组件是否使用共享库。`BUILD_SHARED_LIBS` 仅建议 LLVM 开发人员使用。 如果要将 LLVM 构建为共享库，则应使用 `LLVM_BUILD_LLVM_DYLIB` 选项。

-   `LLVM_ABI_BREAKING_CHECKS:STRING`

    是否应该使用 ABI 中断构建 LLVM 。`WITH_ASSERTS`（默认）、`FORCE_ON` 和 `FORCE_OFF`。

-   `LLVM_UNREACHABLE_OPTIMIZE:BOOL`

    控制llvm_unreachable()在发布版本中的行为（通常禁用断言时）。

-   `LLVM_APPEND_VC_REV:BOOL`

    嵌入版本。

-   `LLVM_BUILD_32_BITS:BOOL`

    是否构建32位的可执行文件和库。64位系统应该关闭。`-DLLVM_BUILD_32_BITS=OFF`。

-   `LLVM_BUILD_BENCHMARKS:BOOL`

    检测开关。`-DLLVM_BUILD_BENCHMARKS=OFF`。

-   `LLVM_BUILD_DOCS:BOOL`

    启用文档目标。默认关闭。`-DLLVM_BUILD_DOCS=OFF`。

-   `LLVM_BUILD_EXAMPLES:BOOL`

    关闭例子测试。`-DLLVM_BUILD_EXAMPLES=OFF`。

-   `LLVM_BUILD_INSTRUMENTED_COVERAGE:BOOL`

    如果启用，则在构建 LLVM 时启用基于源的代码覆盖率检测。



```shell
cmake \
    -Hllvm \
    -BRelease \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/llvm-toolset/ \
    -DCMAKE_C_COMPILER= \
    -DCMAKE_CXX_COMPILER= \
    -DCMAKE_CXX_STANDARD=20 \
    -DLLVM_ENABLE_PROJECTS="" \
    -DLLVM_ENABLE_RUNTIMES="" \
    -DLLVM_TARGETS_TO_BUILD=X86 \
    -DBUILD_SHARED_LIBS=ON \
```