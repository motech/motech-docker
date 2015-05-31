#!/bin/bash

sed -e "s/HOST_USERNAME/`whoami`/" imp.yml > docker-compose.yml
