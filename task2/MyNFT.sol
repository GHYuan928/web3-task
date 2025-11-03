// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyNFT is ERC721 {
    uint256 public tokenIdCounter;
    mapping (uint => string) private tokenURIs;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){
       tokenIdCounter = 1;
    }

    // _tokenURI: json 的 ipfs地址
    function mintNFT(address recipient, string calldata _tokenURI) public {
        require(recipient != address(0), 'recipient invilid');
        uint currentTokenId = tokenIdCounter;
        tokenURIs[currentTokenId] = _tokenURI;
        tokenIdCounter ++;
        _safeMint(recipient, currentTokenId);
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return tokenURIs[tokenId];
    }
}