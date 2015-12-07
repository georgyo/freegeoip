FROM golang:1.5

ADD . /go/src/github.com/makerbot/freegeoip
WORKDIR /go/src/github.com/makerbot/freegeoip/cmd/freegeoip

RUN go get
RUN go install

# Init public web application
RUN cp -r public /var/www

# CMD instructions:
# Add  "-use-x-forwarded-for"      if your server is behind a reverse proxy
# Add  "-public", "/var/www"       to enable the web front-end
# Add  "-internal-server", "8888"  to enable the pprof+metrics server
#
# Example:
# CMD ["-use-x-forwarded-for", "-public", "/var/www", "-internal-server", "8888"]

CMD ["/go/bin/freegeoip", "-use-x-forwarded-for", "-public", "/var/www"]
