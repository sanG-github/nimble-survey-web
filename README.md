## Introduction

> A simple survey API

## Project Setup

### Prerequisites

[![ruby-version-image](https://img.shields.io/badge/ruby-2.7.1-brightgreen.svg)](https://www.ruby-lang.org/en/news/2020/03/31/ruby-2-7-1-released/)
[![node-version-image](https://img.shields.io/badge/node-14.17.0-brightgreen.svg)](https://nodejs.org/download/release/v14.17.0/)

### Docker

* Install [Docker for Mac](https://docs.docker.com/docker-for-mac/install/)

* Setup and boot the Docker containers:

```sh
./bin/envsetup.sh
```

### Development

* Setup the databases:

    * Postgres:

    ```sh
    rake db:setup
    ```

* Run the Rails app

```sh
foreman start -f Procfile.dev
```

## Tests

### Docker-based tests on the CI server

Add the following build settings to run the tests in the Docker environment via Docker Compose (configuration in `docker-compose.test.yml`):

* Configure the environment variable `BRANCH_TAG` to tag Docker images per branch:

```sh
export BRANCH_TAG=$CI_BRANCH_ID
```

Each branch needs to have its own Docker image to avoid build settings disparities and leverage Docker image caching.

> BRANCH_TAG must not contain special characters (`/`) to be valid. So using $BRANCH_NAME will not work e.g. chore/setup-docker.
An alternative is to use a unique identifier such as PR_ID or BRANCH_ID on the CI server.

* Pull the latest version the Docker image for the branch:

```sh
docker pull $DOCKER_IMAGE:$BRANCH_TAG || true
```

On each build, the CI environment does not contain yet a cached version of the image. Therefore, it is required to pull
it first to leverage the `cache_from` settings of Docker Compose which avoids rebuilding the whole Docker image on subsequent test builds.

* Build the Docker image:

```sh
docker-compose -f docker-compose.test.yml build
```

Upon the first build, the whole Docker image is built from the ground up and tagged using `$BRANCH_TAG`.

* Push the latest version of the Docker image for this branch:

```sh
docker push $DOCKER_IMAGE:$BRANCH_TAG
```

* Setup the test database:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec rake db:test:prepare
```

### Test

* Run all tests:

```sh
docker-compose -f docker-compose.test.yml run test
```

* Run a specific test:

```sh
docker-compose -f docker-compose.test.yml run test bin/bundle exec spec [rspec-params]
```

### Automated Code Review Setup

* Add a bot to this repository or to the organization. The bot requires permission level “Write” to be able to set a PR’s status

* Create a token from bot account with `public_repo` scope, and use it to create a `DANGER_GITHUB_API_TOKEN` secret on this repository

## SVG Icons

- Install the [SVGO](https://github.com/svg/svgo) as global (if you din't install it)

        yarn global add svgo

- We place the icons in `/app/assets/images/icons` and use [Svgeez](https://github.com/jgarber623/svgeez) to generate icon sprite

- To generate icon sprite:

        bin/svg-sprite

- To use the icon we use `svg_tag` provided in `SvgHelper` and provided `icon_id` matched with icon file name with prefix `icon-`:

        svg_tag icon_id: 'icon-[icon-file-name]', html: {}
