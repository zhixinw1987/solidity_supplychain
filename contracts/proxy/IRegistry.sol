pragma solidity ^0.8.0;

interface IRegistry {
    event contractAdded(address owner, address addr);
    event contractDeleted(address owner, address addr);
    event functionAdded(address owner, address addr, bytes4[] functions);
    event functionDeleted(address owner, address addr, bytes4[] functions);
}