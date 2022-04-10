pragma solidity ^0.8.0;

import "./LibAdmin.sol";

contract Admin {

    bytes32 ADMIN_STORAGE_POSITION = keccak256("com.supplychain.admin");

    constructor (){
        LibAdmin.AdminStorage storage adms = LibAdmin.getAdminStorage();
        adms.owner = msg.sender;
    }

    modifier onlyOwner () {
        LibAdmin.AdminStorage storage adms = LibAdmin.getAdminStorage();
        require(isOwner(), "action is only permitted to owner");
        _;
    }

    function isOwner () public view returns (bool) {
        LibAdmin.AdminStorage storage adms = LibAdmin.getAdminStorage();
        return (msg.sender == adms.owner);
    }
}