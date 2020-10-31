pragma solidity >=0.4.22 <0.7.0;
pragma experimental ABIEncoderV2;

/**
 * @title DataTrack
 * @dev follow validated data
 */
contract DataTrack {
    
    struct Data {
        uint date;
        address owner;
        address dataContract;
    }


    Data[] private contracts;

    /**
     * @dev Set data to be validated creation
     * @param creator document address and data contract address
     */
    function documentCreation(address creator, address newContract) public {
        contracts.push(Data({
          date: now,
          owner: creator,
          dataContract: newContract
        }));
    }

    /**
     * @dev Return contracts list 
     * @return Data array
     */
    function getContracts() external view returns (Data[] memory) {
        return contracts;
    }
}