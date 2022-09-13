
![image](https://user-images.githubusercontent.com/54927531/189728317-a4968763-6fda-4595-8d54-f1f2ac582f57.png) 

# BOBA3

This is a full-stack application built for Ethlas.

BOBA3 was aimed at creating a simple simulation of what it is like if a bubble tea shop chooses to incorporate the use of blockchain technology.

Instead of using cash, users can use cryptocurrency to purchase their favourite drinks. Thereafter, the transaction gets stored in a database (Firestore) and the blockchain (Ethereum) for record keeping.

In addition to this, a receipt will be generated in the form of an NFT rather than an usual paper/e-receipt -- just for demonstration purposes, the NFT in this project will come in the form of a bubble tea picture.

## Tech Stack

**Client:** NextJS, Redux, TailwindCSS, DaisyUI

**Server:** Firebase, Solidity

**Others:** WAGMI, Ethers, Hardhat, Mocha, Open-zeppelin, Infura, Aseprite (to design the NFT layers)


## Improvements
  
  1) Security flaw: Going forward, the public API key or query link should be obfuscated from public, and be kept in the environment variables. Also, proper account authentication should be set up to gain access to them and application/website only restriction can be enforced on the API. **As a precautionary measure and not to break the current production code, I have already limited the quota calls for the public API key.**
  
  2) The main components in the index page can be further broken down into smaller funcctional components, which would give the overall code a much cleaner look

  3) Better structure the Redux slices

  4) Only unit tests were created and used for the smart contracts due to time constraint. Going forward, unit tests should be performed on the webpage.

  5) This application could also make use of the batch and transaction cloud functions should the functions become more complex. As of now, since the functions are pretty simple, only REST API queries were made with react-query.
  
  6) Fix the the black horizontal bar, just above the footer, that is appearing on laptop screens, but not on desktop monitors.
    
## Instructions

  1) Make sure you have a Metamask wallet 
  2) Get some MATIC for Mumbai testnet: https://faucet.polygon.technology/
  3) Head over to the Vercel app: https://ethlas-fs.vercel.app/
  4) Choose the bubble tea combination that you want from the menu
  5) Hit buy -- you'll only need to pay for the gas fees. I intentionally removed fees so that it will be easier to test.
  6) Visit OpenSea Testnet to view your NFT: https://testnets.opensea.io/
  7) Check your transaction history on the webpage to view latest transaction


## Signing off

Always happy to build, make mistakes and learn from them.

Cheers,
Ashton
 
 
 
