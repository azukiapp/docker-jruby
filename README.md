[azukiapp/jruby](http://images.azk.io/#/jruby)
==================

Base docker image to run **JRuby** applications in [`azk`](http://azk.io)

Versions (tags)
---

<versions>
- [`latest`, `jre`, `1`, `1-jre`, `1.7`, `1.7-jre`](https://github.com/azukiapp/docker-jruby/blob/master/1.7/jre/Dockerfile)
- [`jdk`, `1-jdk`, `1.7-jdk`](https://github.com/azukiapp/docker-jruby/blob/master/1.7/jdk/Dockerfile)
</versions>

Image content:
---

- Debian
- JRuby
- Bundle

### Usage with `azk`

Example of using this image with [azk](http://azk.io):

```js
/**
 * Documentation: http://docs.azk.io/Azkfile.js
 */

// Adds the systems that shape your system
systems({
  "my-app": {
    // Dependent systems
    depends: [], // postgres, mysql, mongodb ...
    // More images:  http://images.azk.io
    image: {"docker": "azukiapp/jruby"},
    // Steps to execute before running instances
    provision: [
      "bundle install --path /azk/bundler"//,
      // "rake db:create",
      // "rake db:migrate"
    ],
    workdir: "/azk/#{manifest.dir}",
    shell: "/bin/bash",
    command: "bundle exec rackup config.ru --pid /tmp/jruby.pid --port $HTTP_PORT --host 0.0.0.0",
    wait: {"retry": 20, "timeout": 1000},
    mounts  : {
      '/azk/#{manifest.dir}': path('.'),
      '/azk/bundler'        : persistent('bundler'),
    },
    scalable: {"default": 2},
    http: {
      // my-app.dev.azk.io
      domains: [ "#{system.name}.#{azk.default_domain}" ]
    },
    envs: {
      // set instances variables
      JRUBY_ENV : 'development',
      BUNDLE_APP_CONFIG : '/azk/bundler',
    }
  },
});
```

### Usage with `docker`

To create the image `azukiapp/jruby`, execute the following command on the docker-jruby folder:

```sh
$ docker build -t azukiapp/jruby 1.7/
```

To run the image and bind to port 3000:

```sh
$ docker run -it --rm --name my-app -p 3000:3000 -v "$PWD":/myapp -w /myapp azukiapp/jruby ruby app.rb
```

Logs
---

```sh
# with azk
$ azk logs my-app

# with docker
$ docker logs <CONTAINER_ID>
```

## License

Azuki Dockerfiles distributed under the [Apache License](https://github.com/azukiapp/dockerfiles/blob/master/LICENSE).
