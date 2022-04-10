pragma solidity ^0.8.0;

library LibRegistry {

    bytes32 private constant REGISTRY_STORE_POSITION = keccak256("com.supplychain.registry");

    struct RegistryStorage {
        mapping (bytes32 => address) funcAddrMap; //function sig => contract address
        mapping (address => bool) contractMap; //address => bool
        address[] contracts;
    }

    function getRegistryStorage () internal pure returns (RegistryStorage storage regs) {
        bytes32 pos = REGISTRY_STORE_POSITION;
        assembly {
            regs.slot := pos
        }
    }
}