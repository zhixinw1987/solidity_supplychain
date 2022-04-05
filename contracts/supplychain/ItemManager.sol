pragma solidity ^0.8.0;
pragma abicoder v2;

import "./Ownable.sol";
import "./IItemManager.sol";

contract ItemManager is IItemManager, Ownable {

    mapping(string => Item) items;

    modifier itemNotExist(string calldata serial){
        require(address(items[serial]) == address(0), "Item already exists");
        _;
    }

    modifier itemExist(string calldata serial){
        require(address(items[serial]) != address(0), "Item already exists");
        _;
    }

    modifier itemIsCreated(string calldata serial) {
        require(items[serial].status() == Item.StatusEnum.CREATED, "Item not created yet");
        _;
    }

    modifier itemIsPaid(string calldata serial) {
        require(items[serial].status() == Item.StatusEnum.PAID, "Item not paid yet");
        _;
    }

    function createItem (string calldata _serial, string calldata _name, uint _price) itemNotExist(_serial) override external{
        Item item = new Item(this, _serial, _name, _price);
        items[_serial] = item;
        emit ItemCreated(_serial, _name, address(item));
    }

    function getItem (string calldata _serial) itemExist(_serial) override external{
        emit ItemFound(_serial, address(items[_serial]));
    }

    function triggerPayment (string calldata _serial) itemIsCreated(_serial) override external payable{
        require(items[_serial].price() <= msg.value, "payment less than the price");
        items[_serial].updateStatus(Item.StatusEnum.PAID);
        emit ItemPaied(_serial, msg.value);
    }

    function triggerDelivery (string calldata _serial) itemIsPaid(_serial) override external {
        items[_serial].updateStatus(Item.StatusEnum.DELIVERED);
        emit ItemDelivered(_serial, string(abi.encodePacked(_serial, " is delivered")));
    }
    
}

contract Item {
    enum StatusEnum {CREATED, PAID, DELIVERED}

    ItemManager public parent;
    string public serial;
    string public itemName;
    uint public price;
    StatusEnum public status;

    constructor (ItemManager _parent, string memory _serial, string memory _name, uint _price){
        parent = _parent;
        serial = _serial;
        itemName = _name;
        price = _price;
        status = StatusEnum.CREATED;
    }

    function updateStatus(StatusEnum _status) public {
        status = _status;
    }

    receive () payable external {
        (bool success,) = address(parent).call{value: msg.value}(abi.encodeWithSignature("triggerPayment(string)", serial));
        require(success, "payment failed");
    }
}