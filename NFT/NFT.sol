pragma solidity ^0.4.18;

contract NFT {
 event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
 function balanceOf(address _owner) public view returns (uint256 _balance);
 function ownerOf(uint256 _tokenId) public view returns (address _owner);
 function transfer(address _to, uint256 _tokenId) public;
}