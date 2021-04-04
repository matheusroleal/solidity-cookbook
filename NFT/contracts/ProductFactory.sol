pragma solidity ^0.4.18;

contract ProductFactory {
    event NewProduct(uint productId, string name);
    
    struct Product {
        string name;
    }
    
    Product[] public products;
    
    mapping (uint => address) public productToOwner;
    mapping (address => uint) ownerProductCount;
  
    modifier onlyOwnerOf(uint _productId) {
        require(msg.sender == productToOwner[_productId]);
        _;
    }
  
    function createProduct(string _name) public {
        uint id = products.push(Product(_name));
        productToOwner[id] = msg.sender;
        ownerProductCount[msg.sender]++;
        emit NewProduct(id, _name);
    }
  
}
