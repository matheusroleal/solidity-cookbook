pragma solidity >=0.4.22 <0.6.0;

contract Donation {
  address payable public owner;

  struct donation {
    address sender;
    uint value_sent;
  }

  donation[] public donors;
  uint totalAmount = 0;

  constructor() public {
    owner = msg.sender;
  }

  event donationSent(uint value);

  function donate() public payable{
    require(msg.value >= 1 wei, "At least 1 wei is required");

    donation memory newDonation;
    newDonation.sender = msg.sender;
    newDonation.value_sent = msg.value;
    donors.push(newDonation);

    totalAmount = totalAmount + newDonation.value_sent;

    owner.transfer(newDonation.value_sent);
    emit donationSent(newDonation.value_sent);
  }

  function getTotalAmount() public view returns (uint _TotalAmount) {
    return totalAmount;
  }
}
