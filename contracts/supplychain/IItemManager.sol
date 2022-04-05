pragma solidity ^0.8.0;

interface IItemManager {
    event ItemCreated (string serial, string name, address addr);
    event ItemPaied (string serial, uint price);
    event ItemDelivered(string serial, string msg);
    event ItemFound (string serial, address addr);

    function createItem (string calldata _serial, string calldata _name, uint _price) external;
    function triggerPayment (string calldata _serial) external payable;
    function triggerDelivery (string calldata _serial) external;
    function getItem (string calldata _serial) external;
}