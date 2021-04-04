pragma solidity ^0.4.19;

import "./NFT.sol";
import "./ProductFactory.sol";

contract ProductOwnership is ProductFactory, NFT {
    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerProductCount[_owner];
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return productToOwner[_tokenId];
    }
    
    function _transfer(address _from, address _to, uint256 _tokenId) private {
        ownerProductCount[_to] = ownerProductCount[_to] + 1;
        ownerProductCount[msg.sender] = ownerProductCount[msg.sender] - 1;
        productToOwner[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }
    
    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }
}
