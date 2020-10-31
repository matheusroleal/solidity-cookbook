pragma solidity >=0.4.22 <0.7.0;

/**
 * @title ValidateData
 * @dev Set & assign data
 */
contract ValidateData {

    address private owner;
    string private filename;
    
    address[] private validators;
    mapping (address => bool) private validated;

    // event for EVM logging
    event OwnerSet(address indexed oldOwner, address indexed newOwner);
    
    // modifier to check if caller is owner
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    /**
     * @dev Set contract deployer as owner
     */
    constructor(string memory _filename) public {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        filename = _filename;
        emit OwnerSet(address(0), owner);
    }

    /**
     * @dev Validate data
     * @param newValidator address of new validator
     */
    function validateFile(address newValidator) public isOwner {
        validators.push(newValidator);
        validated[newValidator] = true;
    }
    
    /**
     * @dev Check if data has been validated by that address
     * @param newValidator address of validator
     */
    function hasValidated(address newValidator) external view returns(bool){
        return validated[newValidator];
    }

    /**
     * @dev Return owner address 
     * @return address of owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
    
    /**
     * @dev Return file name 
     * @return string of file name
     */
    function getFileName() external view returns (string memory) {
        return filename;
    }
}