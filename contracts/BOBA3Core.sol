//SPDX-License-Identifier: UNLICENSED

// Solidity files have to start with this pragma.
// It will be used by the Solidity compiler to validate its version.
pragma solidity ^0.8.9;

interface IStorage {
    function getBack() external view returns (string memory);
    function getOutline() external view returns (string memory);
    function getFore(uint256 _index) external view returns (string memory);
    function getShading(uint256 _index) external view returns (string memory);
}

contract Ashton721 is ERC721Enumerable, ReentrancyGuard, Ownable, Pausable {

    using Strings for uint256; // This is so that uint256 can call up functions from the Strings library

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address storageContract;

    string private ra1='A';
    string private ra2='B';

    string[] private z = [
        '<svg width="100%" height="100%" version="1.1" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">',
        '"<image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> <image width="32" height="32" image-rendering="pixelated" preserveAspectRatio="xMidYMid" xlink:href="',
        '"/> </svg>'
    ];

    struct Alphabet {
        uint8 fore;
        uint8 shading;
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function genChar(uint256 tokenId) internal view returns (Alphabet memory){
        
        Alphabet memory alphabet;

        alphabet.fore = uint8(random(string(abi.encodePacked(ra1,tokenId.toString()))) % 8);
        alphabet.shading = uint8(random(string(abi.encodePacked(ra2,tokenId.toString()))) % 8);

        return alphabet;
    }
 
    function genPNG(Alphabet memory alphabet) internal view returns (string memory) {

        string memory back_layer = IStorage(storageContract).getBack();
        string memory outline_layer = IStorage(storageContract).getOutline();
        string memory fore_layer = IStorage(storageContract).getFore(alphabet.fore);
        string memory shading_layer = IStorage(storageContract).getShading(alphabet.shading);

        string memory output = string(abi.encodePacked(z[0],z[1],back_layer,z[2]));
        output = string(abi.encodePacked(output,outline_layer,z[3],fore_layer,z[4],shading_layer,z[5]));

        return output;
    }

    function tokenURI(uint256 tokenId) override public view returns (string memory){
        require(_exists(tokenId), "TokenID does not exist");

        Alphabet memory alphabet = genChar(tokenId);

        string memory json = string(abi.encodePacked('{"name": "Ashton NFT #', tokenId.toString(), '",'));

        json = string(abi.encodePacked(json, '"description": "This is a NFT of the first initial of my name!",'));

        json = string(abi.encodePacked(json,
                '"attributes": [{"trait_type": "Foreground Colour", "value": "', uint256(alphabet.fore).toString(), 
                '"},',
                '{"trait_type": "Shading Colour", "value": "', uint256(alphabet.shading).toString(),
                '"}'));

        json = Base64.encode(bytes(string(abi.encodePacked(json, '],"image_data": "data:image/svg+xml;base64,', Base64.encode(bytes(genPNG(alphabet))),'"}'))));
        return string(abi.encodePacked('data:application/json;base64,', json));
        
    }

    // Public mint
   function claim() public nonReentrant whenNotPaused{

        _tokenIds.increment();
        uint256 tokenId = _tokenIds.current();

        _safeMint(_msgSender(), tokenId);
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
    
    constructor() ERC721("Ashton NFT", "ASH") Ownable() {
        storageContract = 0xA94F70BB8E7894fdF7fbfccFDc56231bD9Ab78F2;
    }
}