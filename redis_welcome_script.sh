#!/bin/bash

echo "Connecting to Redis..."
redis-cli -h 192.168.49.2 -p 30079 <<EOF
SET prof_message "Hello Prof. Kyriazis, I hope you enjoyed this!"
GET prof_message
EOF
echo "Message set and retrieved successfully!"
