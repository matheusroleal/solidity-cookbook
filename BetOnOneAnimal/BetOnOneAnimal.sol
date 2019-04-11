pragma solidity >=0.4.22 <0.6.0;

contract BetOnOneAnimal {
  struct Bet {
    address sender;
    uint animal;
    bool voted;
  }

  mapping(address => Bet) bets;
  string[] animals = ["Avestruz", "Águia", "Burro","Borboleta","Cachorro","Cabra","Carneiro","Camelo","Cobra","Coelho","Cavalo","Elefante","Galo","Gato","Jacaré","Leão","Macaco","Porco","Pavão","Peru","Touro","Tigre","Urso","Veado","Vaca"];
  uint numBets = 0;
  uint randomNum = 26;

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

  function getBet() public view returns(string memory _animalSelected){
    Bet storage sender = bets[msg.sender];
    return animals[sender.animal];
  }

  function setWinningAnimal() public returns(uint _animalSelected){
    require(numBets > 100, "Minumum quantity of 100 bets");
    if(randomNum == 26){
      randomNum = random(block.timestamp);
    }
    return randomNum;
  }

  function random(uint seed) private view returns (uint) {
    seed = (seed % 25);
    return seed;
  }
}
