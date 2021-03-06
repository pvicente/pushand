Pushand
=======

If you setup **pushand**, your server will accept pushes from arbitrary
git repositories and, if a `.pushand` script exists in the root of the
pushed repository, it will run that script on the server.


Install
-------

To install:

    git clone git://github.com/fesplugas/pushand.git
    cd pushand
    ./bin/pushand install

To uninstall:

    cd pushand
    ./bin/pushand uninstall

Usage
-----

Create a `random-repo` and initialize git:

    mkdir random-repo
    cd random-repo
    git init

Create a `.pushand` file and make it executable:

    cat > .pushand << EOF
    #!/usr/bin/env bash
    echo "Hello from .pushand ... this file is \$0"
    EOF

Add `.pushand` to git:

    git add .
    git commit -a -m "First Commit"

Add a remote to git (this is where we are going to deploy the app):

    git remote add pushand deploy@labs.francescesplugas.com:/tmp/random-repo

Push the repo to the pushand enabled server:

    git push pushand master
    Counting objects: 3, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 275 bytes, done.
    Total 3 (delta 0), reused 0 (delta 0)
    remote: HEAD is now at b8a1656 First Commit
    remote: Hello from .pushand ... this file is /tmp/random-repo/.pushand
    To deploy@labs.francescesplugas.com:/tmp/random-repo
     * [new branch]      master -> master


Examples
--------

Considering we are running a `Rails` application under `passenger` and
you are using `Bundler`, your `.pushand` file will look like this:

```bash
#!/usr/bin/env bash

bundle install --deployment
touch tmp/restart.txt
```

Considering we are running a `Django` application under `passenger` and
you are using `Virtualenv`, your `.pushand` file will look like this:

```bash
#!/usr/bin/env bash

DJANGO_PROJECT_PATH='<YOUR_DJANGO_PROJECT>'

pip install --environment vendor/virtualenv --requirement Virtualenv

source vendor/virtualenv/bin/activate
pushd $DJANGO_PROJECT_PATH
  python manage.py syncdb
  python manage.py collectstatic --noinput
popd
deactivate

touch tmp/restart.txt
```