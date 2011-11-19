#!/bin/bash

SERVER='fesplugas@labs.francescesplugas.com'

echo "=> Connect to '$SERVER' server and install pushand:"
ssh $SERVER <<EOF
pushd \$(mktemp -d /tmp/pushand.install.XXXXXXXXXX)
  git clone git://github.com/fesplugas/pushand.git
  sudo ./pushand/uninstall.sh
  sudo ./pushand/install.sh
popd
EOF

echo "=> Create a local repo and push it to the server:"
pushd $(mktemp -d /tmp/pushand.XXXXXXXXXX)
  git init

  echo "=> Create a '.pushand' file and make it executable:"
  cat > \.pushand << EOF
#!/bin/bash
echo "Hello from .pushand ... this file is \$0"
EOF
  chmod +x \.pushand

  echo "=> Add file to git and commit it:"
  git add .
  git commit -m 'First Commit'

  echo "=> Add a remote to git and verify it's correct:"
  git remote add pushand $SERVER:$(pwd)
  git remote -v

  echo "=> Push the repo:"
  git push pushand master
popd
