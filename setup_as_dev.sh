#!/bin/bash

sed -e "s/HOST_USERNAME/`whoami`/" dev.yml > docker-compose.yml
