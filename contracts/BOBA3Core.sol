//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

interface IStorage {
    function getBack() external view returns (string memory);
    function getOutline() external view returns (string memory);
    function getBase(uint256 _index) external view returns (string memory);
    function getBubbles() external view returns (string memory);
    function getCream() external view returns (string memory);
}

contract BOBA3Core is ERC721Enumerable, ReentrancyGuard, Ownable, Pausable {

    string[] private z = [
        '<svg width="100%" height="100%" version="1.1" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">',
        '"<image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> </svg>'
    ];

    struct BBT {
        uint8 is_bubbles;
        uint8 is_cream;
        uint8 base;
        //uint8 cost;
    }

    address public BOBA3StorageAddr;
    mapping (uint256 => BBT) public tokenIdToBBT;
    using Strings for uint256; // This is so that uint256 can call up functions from the Strings library
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;


    function genPNG(BBT memory bbt) internal view returns (string memory) {
        
        string memory back_layer = IStorage(BOBA3StorageAddr).getBack();
        string memory outline_layer = IStorage(BOBA3StorageAddr).getOutline();
        string memory base_layer = IStorage(BOBA3StorageAddr).getBase(bbt.base);
        string memory bubble_layer = "";
        string memory cream_layer = "";
        
        // Conditional statement for bubble layer
        if (bbt.is_bubbles == 1) {
            bubble_layer = IStorage(BOBA3StorageAddr).getBubbles();
        }

        // Conditional statement for cream layer
        if (bbt.is_cream == 1) {
            cream_layer = IStorage(BOBA3StorageAddr).getCream();
        }

        string memory output = string(abi.encodePacked(z[0],z[1],back_layer,z[2]));
        output = string(abi.encodePacked(output,outline_layer,z[3],base_layer,z[4],cream_layer,z[5],bubble_layer,z[6]));

        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory){
        require(_exists(tokenId), "TokenID does not exist");

        BBT memory bbt = tokenIdToBBT[tokenId];

        string memory json = string(abi.encodePacked('{"name": "BOBA3 NFT #', tokenId.toString(), '",'));

        json = string(abi.encodePacked(json, '"description": "Enjoy your BOBA3!",'));

        json = string(abi.encodePacked(json,
                '"attributes": [{"trait_type": "Bubbles", "value": "', uint256(bbt.is_bubbles).toString(), 
                '"},',
                '{"trait_type": "Cream", "value": "', uint256(bbt.is_cream).toString(),
                '"},',
                '{"trait_type": "Tea_or_Latte?", "value": "', uint256(bbt.base).toString(),
                '"}'
                ));

        json = Base64.encode(bytes(string(abi.encodePacked(json, '],"image_data": "data:image/svg+xml;base64,', Base64.encode(bytes(genPNG(bbt))),'"}'))));
        return string(abi.encodePacked('data:application/json;base64,', json));
        
    }

    // Public mint
   function claim(uint8 _is_bubbles, uint8 _is_cream, uint8 _base) public nonReentrant whenNotPaused{

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();

        _safeMint(_msgSender(), tokenId);

         tokenIdToBBT[tokenId].is_bubbles = _is_bubbles; 
         tokenIdToBBT[tokenId].is_cream = _is_cream;
         tokenIdToBBT[tokenId].base = _base;

    }

    function burnToken(uint256 tokenId) external whenNotPaused{
        _burn(tokenId);
    }

    function pauseContract() external onlyOwner {
        _pause();
    }

    function unpauseContract() external onlyOwner {
        _unpause();
    }
    
    constructor(address _addr) ERC721("BOBA3", "BB3") Ownable() {
        BOBA3StorageAddr = _addr;
    }
}