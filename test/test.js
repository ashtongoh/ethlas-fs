const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("BOBA3 Core", function () {

    let deployer, tester1, tester2;

    let _BOBA3Storage;
    let BOBA3Storage;

    let _BOBA3Core;
    let BOBA3Core;


    before(async function () {

        [deployer] = await ethers.getSigners();

        _BOBA3Storage = await ethers.getContractFactory("BOBA3Storage");
        BOBA3Storage = await _BOBA3Storage.deploy();

        _BOBA3Core = await ethers.getContractFactory("BOBA3Core");
        BOBA3Core = await _BOBA3Core.deploy(BOBA3Storage.address);
    });

    it("Owner tries to mint 1 NFT", async function () {

        await BOBA3Core.connect(deployer).claim(1, 1, 1);

    });


    it("Checks if owner really has 1 NFT minted", async function () {

        const bal = await BOBA3Core.connect(deployer).balanceOf(deployer.address);
        expect(bal).to.equal(1);

    });

    // it("Query test getPNGTest", async function () {
    //     const result = await BOBA3Core.genPNGTest();
    //     console.log(result);
    // });

    it("Check to see if tokenURI returns a string, not null", async function () {
        // const totalSupply = await BOBA3Core.totalSupply();

        // for (i = 1; i <= totalSupply; i++) {
        //     const data = await BOBA3Core.tokenURI(i);
        //     console.log(data);
        // }

        const data = await BOBA3Core.tokenURI(1);
        expect(data).to.be.an("string");

        console.log(data);

    });


});

