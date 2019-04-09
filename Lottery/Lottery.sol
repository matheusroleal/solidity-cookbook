pragma solidity >=0.4.22 <0.6.0;

contract Lottery {
  address owner;

  struct Play {
    uint date;
    address player;
    uint number;
  }

  Play[] lottery;

  constructor(uint initial) public {
    owner = msg.sender;
    set(initial);
  }

  function set(uint num) public{
    lottery.push(Play({
      date: now,
      player: msg.sender,
      number: num
    }));
  }

  function get() public view returns(
    address _contractOwner,
    uint _LastNumSelected,
  ) {
    selectedNum = random(block.timestamp);
    return (
      owner,
      selectedNum
    );
  }

  function random(uint seed) private view returns (uint) {
    seed = (seed % 100) + 1
    return seed
  }
}
