pragma solidity >=0.4.22 <0.6.0;

contract Lottery {
  address owner;
  uint WinningNumber;

  struct Play {
    uint date;
    address payable player;
    uint number;
  }

  Play[] lottery;
  address payable[] winningPlayers;

  constructor(uint initial) public {
    owner = msg.sender;
  }

  modifier onlyOwner() {
      require (msg.sender ==  owner, "Only the contract owner can execute this");
      _;
  }

  event sentPrize(uint totalPrize,uint idividualPrize);

  function setPlay(uint num) public payable{
    require(msg.value == 1000 wei, "Require 1000 wei");
    lottery.push(Play({
      date: now,
      player: msg.sender,
      number: num
    }));
  }

  function getWinningNumber() public payable returns(
    address _contractOwner,
    uint _LastNumSelected
  ) {
    WinningNumber = random(block.timestamp);
    return (
      owner,
      WinningNumber
    );
  }

  function getWinners() public onlyOwner() returns(uint _LastNumSelected) {
    for(uint p = 0; p < lottery.length; p++){
      address payable player = lottery[p].player;
      if(lottery[p].number == WinningNumber){
        winningPlayers.push(player);
      }
    }

    uint totalPrize = address(this).balance;

    if(winningPlayers.length > 0){
      uint idividualPrize = totalPrize / winningPlayers.length;

      for(uint p = 0; p < winningPlayers.length; p++){
        winningPlayers[p].transfer(idividualPrize);
      }
      emit sentPrize(totalPrize,idividualPrize);
    }

    delete winningPlayers;

    return WinningNumber;
  }

  function random(uint seed) private view returns (uint) {
    seed = (seed % 100) + 1;
    return seed;
  }
}
