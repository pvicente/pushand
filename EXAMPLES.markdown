# Pushand Examples

You need to install first `pushand` on your server.

## Rails

Considering you have `rvm` installed on your server you only need to create
a `.pushand` file on your Rails project.

    #!/usr/bin/env bash

    if [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
      source "/usr/local/rvm/scripts/rvm"

      bundle install
      bundle exec rake db:migrate

      rake db:migrate
      touch tmp/restart.txt
    else
      printf "ERROR: An RVM installation was not found.\n"
    fi

## Django

Considering we are running a `Django` application under `passenger` and that
you are using `Virtualenv`:

    #!/usr/bin/env bash

    pip install --environment vendor/virtualenv --requirement Virtualenv

    source vendor/virtualenv/bin/activate
    pushd <YOUR_DJANGO_PROJECT>
      python manage.py syncdb
      python manage.py collectstatic --noinput
    popd
    deactivate

    touch tmp/restart.txt