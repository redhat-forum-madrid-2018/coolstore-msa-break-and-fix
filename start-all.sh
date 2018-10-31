
#!/bin/bash

sh 1-setup-minishift.sh
echo ">>>> 1 minishft console: http://`minishift ip`:8443 <<<<"
sh 2-login-minishift.sh
echo ">>>> 2 loged as: `oc whoami` <<<<"
sh 3-install-istio.sh
echo ">>>> 3.1 installing istio <<<<"
sh 3-install-kiali.sh
echo ">>>> 3.2 installing kiali <<<<"
sh 4-coolstore-setup.sh
echo ">>>> 4 creating and setting up namespace <<<<"
sh 5-coolstore-deploy.sh
echo ">>>> 5 installing istio enabled coolstore <<<<"
sh 6-gateway.sh
echo ">>>> 6 gateway, destination rules, ... <<<<"
sh 7-dashboard-deploy.sh
echo ">>>> 7 Break and Fix Dashboard <<<<"
