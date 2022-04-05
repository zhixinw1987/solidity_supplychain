pragma solidity ^0.8.0;

contract Ownable {
    address owner;

    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner () {
        require(isOwner(), "only owner is allowed");
        _;
    }

    function isOwner () public view returns (bool) {
        return (msg.sender == owner);
    }
}