pragma solidity ^0.8.0;

import "./IRegistry.sol";
import "./LibRegistry.sol";

contract Registry is IRegistry{

    modifier isContract (address addr) {
        uint length = 0;
        assembly {
            length := extcodesize(addr)
        }
        require (length > 0, "Registry: contract is empty");
        _;
    }

    function addContract (address addr) isContract(addr) public {
        LibRegistry.RegistryStorage storage regStorage = LibRegistry.getRegistryStorage();
        bool contractExist = false;
        for (uint i; i < regStorage.contracts.length; i ++) {
            if (regStorage.contracts[i] == addr) {
                contractExist = true;
                break;
            }
        }
        require(!contractExist, "Registry: contract already added");
        
        regStorage.contracts.push(addr);
        emit contractAdded(msg.sender, addr);
    }

    function delContract (address addr) public {

    }

    function addFunc (address addr, bytes32 func) public{

    }

    function delFunc (address addr, bytes32 func) public {

    }
}