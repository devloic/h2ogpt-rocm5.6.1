#!/bin/bash

RENDER_ID=$(getent group render | cut -d: -f3)
RENDER_ID=$RENDER_ID docker-compose up -d
