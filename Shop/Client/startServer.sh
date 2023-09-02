#!/bin/bash
cd ../Server
# Check out ../Server/.env.example for the correct connect string
SHOP_DATABASE='postgres://postgres:password@localhost:5432/smalljs'
node out/App.js
read -p "Press [Enter] to exit: "
