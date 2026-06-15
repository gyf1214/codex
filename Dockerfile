from gyf1214/el-rust:10

RUN dnf install -y libcap-devel openssl-devel llvm-devel clang-devel gdb &&\
    dnf clean all
