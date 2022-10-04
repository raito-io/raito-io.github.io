<h1 align="center">
  <img height="180px" src="https://github.com/raito-io/docs/raw/main/images/Raito_Logo_Vertical_RGB.png" alt="Raito" />
</h1>

<h4 align="center">
  Raito documentation
</h4>

<hr/>

# Introduction

This repository contains the documentation published [here](https://docs.raito.io).

It uses [Jekyll](https://jekyllrb.com/docs/) with the theme and search support from [Just the Docs](https://just-the-docs.github.io/just-the-docs/).

# Contributing

## Get Started

- Install the [dependencies](https://jekyllrb.com/docs/installation/).
- Install Jekyll and the bundler using `gem install jekyll bundler`
- Run `bundle install` (follow suggestion to install in local path: `bundle config set --local path 'vendor/bundle'`)
- Build and run the documentation locally using `bundle exec jekyll serve`
- The documentation website will now be available on http://localhost:4000

## Get Started using Docker

- `docker-compose build`
- `docker-compose up`
- The documentation website will now be available on http://localhost:4000
- if you make changes to dependencies, make sure to run `bundle install` in your local folder as well, otherwise there will be a mismatch between your `Gemfile.lock` (mounted in `/usr/src/app` and the installed dependencies in the Docker container).)

## Updating theme tokens

- All tokens are stored in `theme/tokens`
- run `npm i` then `npm run style-tokens:generate`
- copy the content of `_sass/custom/style-tokens.scss` at the top of `_sass/custom/custom.scss`
