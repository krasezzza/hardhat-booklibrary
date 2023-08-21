#!/bin/bash

echo ""
echo "****************************"
echo "*   PROJECT SETUP START!   *"
echo "****************************"
echo ""
sleep 2

if [ -d "./artifacts" ];
then
  echo "Clearing the 'artifacts' directory..."
  rm -rf ./artifacts
  echo ""
  sleep 1
fi

if [ -d "./cache" ];
then
  echo "Clearing the 'cache' directory..."
  rm -rf ./cache
  echo ""
  sleep 1
fi

if [ -d "./coverage" ];
then
  echo "Clearing the 'coverage' directory..."
  rm -rf ./coverage
  echo ""
  sleep 1
fi

if [ -d "./node_modules" ];
then
  echo "Clearing the 'node_modules' directory..."
  rm -rf ./node_modules
  echo ""
  sleep 1
fi

if [ -d "./typechain-types" ];
then
  echo "Clearing the 'typechain-types' directory..."
  rm -rf ./typechain-types
  echo ""
  sleep 1
fi

if [ -f "./coverage.json" ];
then
  echo "Clearing the 'coverage.json' file..."
  rm -f ./coverage.json
  echo ""
  sleep 1
fi

if [ -f "./hardhat.log" ];
then
  echo "Clearing the 'hardhat.log' file..."
  rm -f ./hardhat.log
  echo ""
  sleep 1
fi

if [ -f "./.env" ];
then
  echo "ENV file was already configured!"
else
  cp ./env.example ./.env
  echo "ENV file is now configured."
fi
echo ""
sleep 1

echo "Installing node_modules..."
npm install
echo ""
sleep 2

echo "Compiling the typechain data..."
npx hardhat compile
echo ""
sleep 2

echo "Starting up the localhost network..."
npx hardhat node &> ./hardhat.log &
echo "(Running server in the background!)"
echo ""
sleep 2

echo "Executing all the tests..."
npx hardhat test
echo ""
sleep 2

# Kill the background hardhat processes
sudo kill -9 `pidof -s node`
