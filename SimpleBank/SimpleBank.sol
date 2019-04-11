pragma solidity >=0.4.22 <0.6.0;

contract SimpleBank {
  address public owner;

  mapping (address => uint) private accounts;
  uint private clientCount;

  event MadeDeposit(address indexed accountAddress, uint amount);

  constructor() public payable {
      require(msg.value == 50 ether, "50 ether initial funding required");
      owner = msg.sender;
      clientCount = 0;
  }

  function enroll() public returns (uint) {
      if (clientCount < 5) {
          clientCount++;
          accounts[msg.sender] = 10 ether;
      }
      return accounts[msg.sender];
  }

  function deposit() public payable returns (uint) {
    accounts[msg.sender] += msg.value;
    emit MadeDeposit(msg.sender, msg.value);
    return accounts[msg.sender];
  }

  function withdraw(uint withdrawAmount) public returns (uint remainingBal) {
    if (withdrawAmount <= accounts[msg.sender]) {
        accounts[msg.sender] -= withdrawAmount;
        msg.sender.transfer(withdrawAmount);
    }
    return accounts[msg.sender];
}

  function balance() public view returns (uint) {
    return accounts[msg.sender];
  }

}
