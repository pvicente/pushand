# Pushand Examples

You need to install first `pushand` on your server.

## Rails

Considering you have `rvm` installed on your server you only need to create
a `.pushand` file on your Rails project.

    #!/bin/bash

    bundle install --deployment
    bundle exec rake db:migrate
    touch tmp/restart.txt

## Django

Considering we are running a `Django` application under `passenger` and
you are using `Virtualenv`:

    #!/bin/bash

    pip install --environment vendor/virtualenv --requirement Virtualenv

    source vendor/virtualenv/bin/activate
    pushd <YOUR_DJANGO_PROJECT>
      python manage.py syncdb
      python manage.py collectstatic --noinput
    popd
    deactivate

    touch tmp/restart.txt
