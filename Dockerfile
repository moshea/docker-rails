FROM centos:latest

ENV BUILD_PACKAGES gcc g++ make automake autoconf curl-devel openssl-devel zlib-devel httpd-devel apr-devel apr-util-devel sqlite-devel libxml2-devel libxslt-devel
ENV RUBY_PACKAGES ruby ruby-devel rubygems

RUN yum install -y $BUILD_PACKAGES
RUN yum install -y $RUBY_PACKAGES
RUN gem update --system
RUN gem install bundler --no-ri --no-rdoc

RUN mkdir -p /app
WORKDIR /app

ADD api_server/Gemfile* ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

EXPOSE 3000
CMD rails server -b 0.0.0.0
