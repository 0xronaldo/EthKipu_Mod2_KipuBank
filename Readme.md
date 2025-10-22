# KipuBank Contract

## Sobre el contrato

KipuBank contrato en Solidity la verdad no documente bastante tengo que repasar aun mas sobre las funciones y los tipos de datos antes de entrar a temas de mutable no mutable

## Setup

1. Clonar:
   ```bash
   git clone https://github.com/0xronaldo/EthKipu_Mod2_KipuBank
   cd kipu-bank
```
   
Install Hardhat (if using it):bash

npm install --save-dev hardhat

Set up environment:Create .env file with:

PRIVATE_KEY=your_private_key
SEPOLIA_URL=your_infura_or_alchemy_url

Compile:bash

npx hardhat compile

Deploy to Sepolia:Use this script in scripts/deploy.js:javascript

const hre = require("hardhat");
async function main() {
  const KipuBank = await hre.ethers.getContractFactory("KipuBank");
  const bank = await KipuBank.deploy("1000000000000000000", "100000000000000000000");
  await bank.deployed();
  console.log("Deployed at:", bank.address);
}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

Run:bash

npx hardhat run scripts/deploy.js --network sepolia

Verify on Etherscan:bash

npx hardhat verify --network sepolia <CONTRACT_ADDRESS> "1000000000000000000" "100000000000000000000"


