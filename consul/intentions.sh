#!/bin/bash

export CONSUL_HTTP_ADDR=http://localhost:8500

# Default rule: deny all
consul intention create -replace -deny '*' '*'

# Allow traffic to simple http echo service
consul intention create -replace -allow '*' http-echo 

# Allow traffic to Ambassador test service
consul intention create -replace -allow '*' qotm

# Allow traffic between sock shop components
consul intention create -replace -allow load-test front-end
consul intention create -replace -allow front-end carts 
consul intention create -replace -allow front-end orders
consul intention create -replace -allow front-end catalogue
consul intention create -replace -allow front-end user 
consul intention create -replace -allow carts carts-db
consul intention create -replace -allow orders orders-db 
consul intention create -replace -allow catalogue catalogue-db 
consul intention create -replace -allow user user-db
consul intention create -replace -allow queue-master rabbitmq

# Allow Ambassador to talk to anything
consul intention create -replace -allow ambassador '*'
