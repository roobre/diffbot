FROM golang:1.23-alpine as builder

WORKDIR /diffbot

RUN wget -O argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/v2.13.2/argocd-linux-amd64 \
    && install -m 555 argocd-linux-amd64 /bin/argocd

COPY . .
RUN go build -o /bin/diffbot .

FROM alpine:3.21.0

COPY --from=builder /bin/diffbot /usr/local/bin/
COPY --from=builder /bin/argocd /usr/local/bin/
