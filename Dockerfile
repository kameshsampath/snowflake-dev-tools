# FROM alpine AS tools

# ARG TARGETARCH

# COPY Taskfile.yaml Taskfile.yaml

# RUN apk add -U curl busybox && \
#   sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
#   && task

FROM alpine:3.19

ARG TARGETARCH
ARG SNOWCLI_VERSION=3.1.0

RUN apk add --update --no-cache  bash g++ python3 python3-dev pipx curl ca-certificates python3 bash bash-completion git direnv wget net-tools tcpdump iputils nmap arp-scan bind-tools jq yq gettext httpie 

RUN pipx install snowflake-cli-labs --include-deps \
  && bash -c "pipx ensurepath"

# COPY --from=tools  /tools/bin/ /usr/local/bin/
# COPY --from=tools  /usr/local/bin/task /usr/local/bin/task

WORKDIR /apps

ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

CMD ["/bin/bash"]
