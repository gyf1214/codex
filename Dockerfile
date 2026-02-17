from gyf1214/el-rust:8

RUN dnf install -y libcap-devel openssl-devel llvm-devel clang-devel &&\
    dnf clean all
