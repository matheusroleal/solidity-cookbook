pragma solidity >=0.4.22 <0.6.0;

contract BetOnOneAnimal {
  struct Bet {
    address sender;
    uint animal;
    bool voted;
  }

  mapping(address => Bet) bets;
  uint numBets = 0;
  int randomNum = -1;

  event changeSent(address player, uint change);

  function vote(uint number) public payable minCost(1000){
    Bet storage sender = bets[msg.sender];
    if (sender.voted || number > 26) return;
    sender.voted = true;
    sender.animal = number - 1;
    numBets++;

    if(msg.value > 1000){
      uint change = msg.value - 1000;
      msg.sender.transfer(change);
      emit changeSent(msg.sender, change);
    }
  }

  modifier minCost(uint min) {
    require(msg.value >= min, "Minumum value of 1000 to bet");
    _;
  }

  function winningAnimal() public view returns(int){
    if(numBets < 100) return -1;
    if(randomNum == -1){
      randomNum = random();
    }
    return randomNum;
  }

  function random(uint seed) private view returns (uint) {
    seed = (seed % 100) + 1
    return seed
  }
}
