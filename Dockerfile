# 使用多阶段构建
# 构建阶段
FROM gcc:latest as builder
WORKDIR /app
COPY . .
RUN make

# 运行阶段
FROM ubuntu:22.04
WORKDIR /app
# 设置非交互式安装
ENV DEBIAN_FRONTEND=noninteractive
# 安装必要的运行时依赖
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libc6 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/hello .
CMD ["./hello"] 