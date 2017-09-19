pragma solidity ^0.4.10;

contract Owned {
    address public owner;

    // Constructor for Owned
    function Owned() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address newOwner) {
        owner = newOwner;
    }
}

contract BsidesStash is Owned {
  // Top secret hashed password... A special place
  bytes32 passHash = 0x408c7c5887a0f3905767754f424989b0089c14ac502d7f851d11b31ea2d1baa6;

  function withdrawAllTo(address _to, string password) onlyOwner {
    if(sha256(password)==passHash)
      _to.transfer(this.balance);
  }

  function() payable {
      // Receiving some Eth?
      if (msg.value > 0)
          LogDeposit(msg.sender, msg.value);
  }

  // Events
  event LogDeposit(address _from, uint value);

}
