
#!/bin/bash

sh 1-setup-minishift.sh
sh 2-login-minishift.sh
sh 3-install-istio.sh
sh 3-install-kiali.sh
sh 4-istio-coolstore-setup.sh
sh 5-istio-coolstore-deploy.sh
