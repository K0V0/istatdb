# Dockerfile
FROM ruby:2.5


# refresh outdated repos && intall nodejs and npm
#
RUN apt-get update && apt-get install -y \
    wget npm shared-mime-info tzdata libxml2-dev libxslt-dev bash mc \
    imagemagick libmagickwand-dev pkg-config


# install required node packages
#
RUN npm install -g yarn


# copy app to working directory
#
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app
RUN mkdir -p log && touch log/production.log


# Set environment variables
#
ENV RAILS_ENV=production


# Install some gems with native extensions
#
RUN bundle update caxlsx # mimemagick causing problems with purged version(s) from repo due to licence problems


# build rails app
#
RUN bundle install


# precompile assets
#
RUN rake assets:precompile


# run rails app
#
CMD rails s -b 0.0.0.0
