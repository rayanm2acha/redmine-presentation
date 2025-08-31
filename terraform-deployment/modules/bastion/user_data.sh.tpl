#!/bin/bash
echo "${redmine_private_key}" > /home/ubuntu/redmine-key2.pem
chmod 600 /home/ubuntu/redmine-key2.pem
chown ubuntu:ubuntu /home/ubuntu/redmine-key2.pem