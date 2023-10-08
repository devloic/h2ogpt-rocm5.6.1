#!/bin/bash

RENDER_ID=$(getent group render | cut -d: -f3)
RENDER_ID=$RENDER_ID docker-compose -f docker-compose-build.yml up -d
