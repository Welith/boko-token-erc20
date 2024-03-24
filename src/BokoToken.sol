// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "../lib/foundry-chainlink-toolkit/lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract BokoToken is ERC20 {
    address immutable i_owner;

    constructor(uint256 initialSupply) ERC20("BokoToken", "BOKO") {
        _mint(msg.sender, initialSupply);
        i_owner = msg.sender;
    }

    function testMint(address to, uint256 amount) public {
        if (msg.sender != i_owner) {
            revert("Ownable: caller is not the owner");
        }
        _mint(to, amount);
    }
}
