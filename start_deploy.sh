#!/bin/bash -
#===============================================================================
#
#          FILE: start_deploy.sh
#
#         USAGE: ./start_deploy.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Anatoly Afanasyev
#  ORGANIZATION:
#       CREATED: 23.08.2019 22:15
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

cd terraform && terraform init && terraform apply -auto-approve
