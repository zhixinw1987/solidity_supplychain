pragma solidity ^0.8.0;

library LibAdmin {

    bytes32 private constant ADMIN_STORAGE_POSITION = keccak256("com.supplychain.admin");

    struct AdminStorage {
        address owner;
    }

    function getAdminStorage() internal pure returns (AdminStorage storage ads){
        bytes32 pos = ADMIN_STORAGE_POSITION;
        assembly {
            ads.slot := pos
        }
    }
}