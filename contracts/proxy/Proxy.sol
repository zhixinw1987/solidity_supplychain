pragma solidity ^0.8.0;

import "../admin/Admin.sol";
import "./Registry.sol";

contract Proxy is Admin, Registry{

    fallback () external payable {

    } 

}