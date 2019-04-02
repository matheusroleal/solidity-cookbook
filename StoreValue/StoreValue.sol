pragma solidity >=0.4.22 <0.6.0;

contract StoreValue {
  uint value;

  // Add value to my global variable
  function set(uint v) public{
    value = v;
  }

  // Retrive the value sent to the blockchain
  function get() public view returns (uint) {
    return value;
  }
}
