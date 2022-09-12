const {ethers} = require("hardhat");

async function main() {

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const _BOBA3Storage = await ethers.getContractFactory('BOBA3Storage');
  const BOBA3Storage = await _BOBA3Storage.deploy();

  console.log("BOBA3Storage contract:", BOBA3Storage.address);

  const _BOBA3Core = await ethers.getContractFactory('BOBA3Core');
  const BOBA3Core = await _BOBA3Core.deploy(BOBA3Storage.address);

  console.log("BOBA3Core contract:", BOBA3Core.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
